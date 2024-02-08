local s = require("luasnip")

-- console log snippet
local console_log = s.parser.parse_snippet({ trig = "cl" }, "console.log(${1:msg});")
