local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local d = ls.choice_node
local d = ls.function_node
local sn = ls.snippet_node


local conds = require("luasnip.extras.expand_conditions")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep







local snippets = {}
local autosnippets = {
    -- Prints
    s({ trig = "pn", name = "println!", wordTrig = true}, {t("println!("), i(1, ""), t(")")}),
    s({ trig = "prin", name = "print!", wordTrig = true}, {t("print!("), i(1, ""), t(")") }),

    -- Vec

}
return snippets, autosnippets
