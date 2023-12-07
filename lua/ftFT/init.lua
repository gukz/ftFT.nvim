local M = {
  keys = {"f", "t", "F", "T"},
  modes = {"n", "v"},
  hl_group = "Search",
  sight_hl_group = "",
  flag = "",
  ns = vim.api.nvim_create_namespace('ftFT_ns'),
}

local function get_item_by_char(tbl, val)
  -- input tbl:
  -- {
  --   { "a", 0 },
  --   { "b", 3, 4, 6 },
  -- }
  -- input val:
  -- "b"
  --
  -- result:
  -- nil or { "b", 3, 4, 6 }
  for _, v in ipairs(tbl) do
    if v[1] == val then
      return v
    end
  end
  return nil
end

-- calculate character index in a line
local function generate_ftFT_indexs(key, cur_col, line_content)
  -- input key: f t F T
  -- input cur_col: 5 column number
  -- input line_content: the line content value
  -- result:
  -- {
  --   -- first element is the character, second to last element is the 1st, 2nd element occur index
  --   { "a", 0 },
  --   { "b", 3, 4, 6 },
  --   { "c", 5, 7 },
  -- }
  if (not (string.upper(key) == "F")) and (not (string.upper(key) == "T")) then
    return {}
  end

  local max_iter = cur_col
  local offset = -1
  if key == "f" or key == "t" then
    max_iter = #line_content - cur_col
    offset = 1
  end

  local result = {}
  for i = 1, max_iter do
    local index = cur_col + i * offset
    local char = line_content:sub(index, index)
    if (not (string.byte(char) == nil)) and (string.byte(char) < 128) then
      local item = get_item_by_char(result, char)
      if item == nil then
        table.insert(result, {char, index - 1})
      elseif #item < 11 then -- allow record 2nd..9th duplicate character
        table.insert(item, index - 1)
      end
    end
  end
  return result
end

local function contains(tb, element)
  for _, item in ipairs(tb) do
    if item == element then
      return true
    end
  end
  return false
end

local function onKey(k)
  if contains(M.modes, vim.fn.mode()) then
    if M.flag == "" then
      if contains(M.keys, k) then
        M.flag = k
        M.highlight(k)
      end
    else
      M.flag = ""
      vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
    end
  end
end

function M.setup(opts)
  if (not (opts == nil)) and (not (opts.keys == nil)) then
    M.keys = opts.keys
  end
  if (not (opts == nil)) and (not (opts.modes == nil)) then
    M.modes = opts.modes
  end
  if (not (opts == nil)) and (not (opts.hl_group == nil)) then
    M.hl_group = opts.hl_group
  end
  if (not (opts == nil)) and (not (opts.sight_hl_group == nil)) then
    M.sight_hl_group = opts.sight_hl_group
  end

  if (not (vim.g.ftFT_sight_enable == nil)) or (not (vim.g.ftFT_keymap_skip_n == nil)) or (not (vim.g.ftFT_keymap_skip_v == nil)) or (not (vim.g.ftFT_keymap_skip_ydc == nil)) or (not (vim.g.ftFT_hl_group == nil)) then
    error("ftFT.nvim has breaking changes, pls go to https://github.com/gukz/ftFT.nvim for more info.")
  end
  vim.on_key(onKey, 0)
end

function M.execute(key)
  M.highlight(key)
  local ok, key2 = pcall(vim.fn.getchar)
  if ok then
    if type(key2) == 'number' then
      key2 = vim.fn.nr2char(key2)
    end
    vim.api.nvim_feedkeys(tostring(vim.v.count1)..key..key2, 'ni', false)
  end
  vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
end

function M.highlight(key)
  local curpos = vim.fn.getcurpos()
  local cur_row, cur_col = curpos[2] - 1, curpos[3]
  local line_content = vim.api.nvim_buf_get_lines(0, cur_row, cur_row + 1, false)[1]
  local hl_group = M.hl_group
  local sight_hl_group = M.sight_hl_group 

  local cur_ns = M.ns
  local hl_amount = 0
  local mode_key = key:sub(#key, #key)
  for _, item in pairs(generate_ftFT_indexs(mode_key, cur_col, line_content)) do
    -- item: { "a", 0, 3, 5 }
    -- draw cur line first hit character
    hl_amount = hl_amount + 1
    if vim.v.count1 < #item then
      vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row, item[1 + vim.v.count1], {
        virt_text = {{item[1], hl_group}},
        virt_text_pos = 'overlay',
        priority = 65500
      })
    end

    -- draw sight line
    if (not (sight_hl_group == "")) and vim.v.count1 == 1 then
      local rep = 1
      for i = 3, #item do
        vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row + 1, 0, {
          virt_text = {{tostring(rep), sight_hl_group}},
          virt_text_win_col = item[i],
          priority = 65500
        })
        rep = rep + 1
      end
    end
  end

  if hl_amount > 0 then
    vim.cmd('redraw')
  end
end

return M
