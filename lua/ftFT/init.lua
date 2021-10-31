-- calculate unique character index in a line
local function char_exist(tbl, val)
  for _, v in ipairs(tbl) do
    if v[1] == val then
      return true
    end
  end
  return false
end

local function generate_ftFT_indexs(key, cur_col, line_content)
  -- result:
  -- {
  --   { "a", 0 },
  --   { "b", 3 },
  --   { "c", 5 },
  -- }
  if #line_content > 300 then
    return {}
  end
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
    if not char_exist(result, char) then
      table.insert(result, {char, index - 1})
    end
  end

  return result
end


local M = {}

function M.execute(key)
  local curpos = vim.fn.getcurpos()
  local cur_row, cur_col = curpos[2], curpos[3]
  local line_content = vim.api.nvim_buf_get_lines(0, cur_row - 1, cur_row, false)[1]
  local hl_group = vim.g.ftFT_hl_group or 'Search'

  local cur_ns = vim.api.nvim_create_namespace('hop_grey_cur')
  local hl_amount = 0
  local mode_key = key:sub(#key, #key)
  for _, item in pairs(generate_ftFT_indexs(mode_key, cur_col, line_content)) do
    -- item: { "a", 0 }
    hl_amount = hl_amount + 1
    vim.api.nvim_buf_set_extmark(0, cur_ns, cur_row - 1, item[2], {
      virt_text = {{item[1], hl_group}},
      virt_text_pos = 'overlay',
      hl_mode = 'combine',
      priority = 65500
    })
  end

  if hl_amount > 0 then vim.cmd('redraw') end

  local ok, key2 = pcall(vim.fn.getchar)
  if ok then
    if type(key2) == 'number' then
      key2 = vim.fn.nr2char(key2)
    end
    vim.api.nvim_feedkeys(key..key2, 'n', false)
  end
  vim.api.nvim_buf_clear_namespace(0, cur_ns, 0, -1)
end

return M
