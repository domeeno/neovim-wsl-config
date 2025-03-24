local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("fori", {
    t("for i := 0; i < "), i(1, "n"), t("; i++ {"),
    t({ "", "\t" }), i(2, "// body"),
    t({ "", "}" }),
  }),
}
