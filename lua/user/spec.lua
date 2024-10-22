local M = {}

local _LAZY_PLUGIN_SPEC = {}

function M.add(item)
	if type(item) == "string" then
		table.insert(_LAZY_PLUGIN_SPEC, { import = item })
	elseif type(item) == "table" then
		table.insert(_LAZY_PLUGIN_SPEC, item)
	else
		error("Invalid item type. Expected string or table")
	end
end

function M.get()
	return _LAZY_PLUGIN_SPEC
end

return M
