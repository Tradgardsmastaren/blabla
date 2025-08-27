local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local d = ls.choice_node
local d = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets = {}
local autosnippets = {

    s({ trig = "veci", name = "int vector" }, { t("std::vector<int>") }, {}),
    s({ trig = "cout", name = "std::cout" }, { t("std::cout << ") }, {}),
    s({ trig = "endl", name = "std::endl" }, { t("<< std::endl") }, {}),
}
return snippets, autosnippets
