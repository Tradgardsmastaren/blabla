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

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local myFirstSnippet = s("myFirstSnippet", {
    t("function ("),
    i(1, "arg"),
    t(") "),
})


local mySecondSnippet = s(
    "mySecondSnippet", 
    fmt(
        [[
            local {} = function({})
                {}
            end
        ]],
        {
            i(1,"variable"),
            c(2,{t(""), t("argument")}),
            i(3,"-- TODO"),
        }
    )
)
table.insert(snippets, myFirstSnippet)
table.insert(snippets, mySecondSnippet)

    
return snippets, autosnippets
