local ui = require('lspsaga').config.ui

local function merge_custom(kind)
  local function find_index_by_type(k)
    for index, opts in pairs(kind) do
      if opts[1] == k then
        return index
      end
    end
  end

  for k, v in pairs(ui.kind or {}) do
    local index = find_index_by_type(k)
    if not index then
      vim.notify('[lspsaga.nvim] could not find kind in default')
      return
    end
    if type(v) == 'table' then
      kind[index][2], kind[index][3] = unpack(v)
    elseif type(v) == 'string' then
      kind[index][3] = v
    else
      vim.notify('[Lspsaga.nvim] value must be string or table')
      return
    end
  end
end

local function get_kind()
  local kind = {
    { 'File', ' ', 'Tag' },
    { 'Module', ' ', 'Exception' },
    { 'Namespace', ' ', 'Include' },
    { 'Package', ' ', 'Label' },
    { 'Class', ' ', 'Include' },
    { 'Method', ' ', 'Function' },
    { 'Property', ' ', '@property' },
    { 'Field', ' ', '@field' },
    { 'Constructor', ' ', '@constructor' },
    { 'Enum', ' ', '@number' },
    { 'Interface', ' ', 'Type' },
    { 'Function', '󰡱 ', 'Function' },
    { 'Variable', ' ', '@variable' },
    { 'Constant', ' ', 'Constant' },
    { 'String', '󰅳 ', 'String' },
    { 'Number', '󰎠 ', 'Number' },
    { 'Boolean', ' ', 'Boolean' },
    { 'Array', '󰅨 ', 'Type' },
    { 'Object', ' ', 'Type' },
    { 'Key', ' ', 'Constant' },
    { 'Null', '󰟢 ', 'Constant' },
    { 'EnumMember', ' ', 'Number' },
    { 'Struct', ' ', 'Type' },
    { 'Event', ' ', 'Constant' },
    { 'Operator', ' ', 'Operator' },
    { 'TypeParameter', ' ', 'Type' },
    -- ccls
    [252] = { 'TypeAlias', ' ', 'Type' },
    [253] = { 'Parameter', ' ', '@parameter' },
    [254] = { 'StaticMethod', ' ', 'Function' },
    [255] = { 'Macro', ' ', 'Macro' },
    -- for completion sb microsoft!!!
    [300] = { 'Text', '󰭷 ', 'String' },
    [301] = { 'Snippet', ' ', '@variable' },
    [302] = { 'Folder', ' ', 'Title' },
    [303] = { 'Unit', '󰊱 ', 'Number' },
    [304] = { 'Value', ' ', '@variable' },
  }

  merge_custom(kind)
  return kind
end

local kind = get_kind()

return {
  kind = kind,
}
