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

    s({ trig = "Text", name = "text" }, { t({ "<Text>" }), i(1), t({ "</Text>"}) },        { condition = conds.line_begin }),
    s({ trig = "Button", name = "button" }, { t({ "<Button onPress={" }), i(1), t({ "} title=\""}), i(2), t({"\" />", ""}) },        { condition = conds.line_begin }),
}
return snippets, autosnippets
