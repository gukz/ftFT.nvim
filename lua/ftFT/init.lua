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
  -- result:
  -- {
  --   -- first element is the character, second to last element is the 1st, 2nd element occur index
  --   { "a", 0 },
  --   { "b", 3, 4, 6 },
  --   { "c", 5, 7 },
  -- }
  if (not string.upper(key) == "F") and (not string.upper(key) == "T") then
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
    local item = get_item_by_char(result, char)
    if item == nil then
      table.insert(result, {char, index - 1})
    elseif #item < 11 then
      -- allow record 2nd..9th duplicate character
      table.insert(item, index - 1)
    end
  end

  return result
end


local M = {}

function M.setup()
  local key_bind_opt = { noremap = true, silent = true }
  local total_keys = vim.g.ftFT_keymap_keys or { "f", "t", "F", "T" }
  if vim.g.ftFT_keymap_skip_n == nil then
    for _, key in ipairs(total_keys) do
      vim.api.nvim_set_keymap("n", key, "<cmd>lua require('ftFT').execute('"..key.."')<CR>", key_bind_opt)
    end
  end
  if vim.g.ftFT_keymap_skip_v == nil then
    for _, key in ipairs(total_keys) do
      vim.api.nvim_set_keymap("v", key, "<cmd>lua require('ftFT').execute('"..key.."')<CR>", key_bind_opt)
    end
  end
  if vim.g.ftFT_keymap_skip_ydc == nil then
    for _, key in ipairs(total_keys) do
      vim.api.nvim_set_keymap("n", "y"..key, "<cmd>lua require('ftFT').execute('y"..key.."')<CR>", key_bind_opt)
      vim.api.nvim_set_keymap("n", "d"..key, "<cmd>lua require('ftFT').execute('d"..key.."')<CR>", key_bind_opt)
      vim.api.nvim_set_keymap("n", "c"..key, "<cmd>lua require('ftFT').execute('c"..key.."')<CR>", key_bind_opt)
    end
  end
end

function M.execute(key)
  local curpos = vim.fn.getcurpos()
  local cur_row, cur_col = curpos[2] - 1, curpos[3]
  local line_content = vim.api.nvim_buf_get_lines(0, cur_row, cur_row + 1, false)[1]
  local hl_group = vim.g.ftFT_hl_group or 'Search'
  local sight_hl_group = vim.g.ftFT_sight_hl_group or 'Search'

  local cur_ns = vim.api.nvim_create_namespace('ftFT_ns')
  local hl_amount = 0
  local mode_key = key:sub(#key, #key)
  for _, item in pairs(generate_ftFT_indexs(mode_key, cur_col, line_content)) do
    -- item: { "a", 0, 3, 5 }
    hl_amount = hl_amount + 1
    if vim.v.count1 < #item then
      vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row, item[1 + vim.v.count1], {
        virt_text = {{item[1], hl_group}},
        virt_text_pos = 'overlay',
        hl_mode = 'combine',
        priority = 65500
      })
    end

    -- draw sight line
    if vim.g.ftFT_sight_enable != nil and vim.v.count1 == 1 then
      local bg_str = " "
      vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row + 1, 0, {
        virt_text = {{bg_str, sight_hl_group}},
        virt_text_win_col = 0,
        hl_mode = 'combine',
        priority = 65500
      })

      local rep = 1
      for i = 3, #item do
        vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row + 1, 0, {
          virt_text = {{tostring(rep), sight_hl_group}},
          virt_text_win_col = item[i],
          hl_mode = 'combine',
          priority = 65500
        })
        rep = rep + 1
      end
    end
  end

  if hl_amount > 0 then vim.cmd('redraw') end

  local ok, key2 = pcall(vim.fn.getchar)
  if ok then
    if type(key2) == 'number' then
      key2 = vim.fn.nr2char(key2)
    end
    vim.api.nvim_feedkeys(tostring(vim.v.count1)..key..key2, 'ni', false)
  end
  vim.api.nvim_buf_clear_namespace(0, cur_ns, 0, -1)
end

return M
