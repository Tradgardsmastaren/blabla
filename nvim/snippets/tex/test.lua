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

local frac_no_parens = {
    f(function(_, snip)
        return string.format("\\frac{%s}", snip.captures[1])
    end, {}),
    t("{"),
    i(1),
    t("}"),
    i(0),
}

local GREEK_LETTERS = {}
GREEK_LETTERS["a"] = "alpha"
GREEK_LETTERS["b"] = "beta"
GREEK_LETTERS["d"] = "delta"
GREEK_LETTERS["k"] = "kappa"
GREEK_LETTERS["e"] = "eps"
GREEK_LETTERS["g"] = "gamma"
GREEK_LETTERS["l"] = "lambda"
GREEK_LETTERS["o"] = "omega"
GREEK_LETTERS["s"] = "sigma"
GREEK_LETTERS["t"] = "tau"
GREEK_LETTERS["p"] = "pi"
GREEK_LETTERS["m"] = "mu"
GREEK_LETTERS["x"] = "chi"

local tex = {}
tex.in_align = function()
    return vim.fn["vimtex#env#is_inside"]("align")[1] ~= 0
end

tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

local frac_no_parens = {
    f(function(_, snip)
        return string.format("\\frac{%s}", snip.captures[1])
    end, {}),
    t("{"),
    i(1),
    t("}"),
    i(0),
}


local snippets = {
    -- Boilerplate
    s("boiler", fmt([[
      \documentclass{article}
      \usepackage{amsmath, amssymb}
      \usepackage[hidelinks]{hyperref}
      \usepackage[margin=1in]{geometry}
      \usepackage{float}
      \usepackage{xcolor}

      \title{<>}
      \author{Eric Johansson}
      \date{}

      \begin{document}
      <>
      \end{document}
      ]],
        { i(1, "title"), i(2) },
        { delimiters = "<>" }
    ), conds.line_begin),


}
local autosnippets = {
    -- Environments
    s({ trig = "mk", name = "inline math" }, { t("\\( "), i(1, ""), t(" \\) ") }, { condition = tex.in_text }),
    s({ trig = "dm", name = "display math" }, { t({ "\\[", "\t" }), i(1), t({ "", "\\]", "" }) },
        { condition = tex.in_text and conds.line_begin }),
    s({ trig = "aln", name = "align equation" }, { t({ "\\begin{align*}", "\t" }), i(1), t({ "", "\\end{align*}", "" }) },
        { condition = tex.in_text and conds.line_begin }),
    s({ trig = "eqn", name = "equation" },
        { t({ "\\begin{equation} \\label{eqn:" }), i(1), t({ "}", "" }), i(2), t({ "", "\\end{equation}", "" }) },
        { condition = tex.in_text and conds.line_begin }),
    s("beg", fmt([[
      \begin{<>}
        <>
      \end{<>}]],
        { i(1, "env"), i(0, "%content"), rep(1) },
        { delimiters = "<>" }
    )
    ),
    -- Sections
    s({ trig = "sse", name = "section" }, { t("\\section{"), i(1, ""), t("}") },
        { condition = tex.in_text and conds.line_begin }),
    s({ trig = "sss", name = "subsection" }, { t("\\subsection{"), i(1, ""), t("}") },
        { condition = tex.in_text and conds.line_begin }),
    s({ trig = "ss2", name = "sub-subsection" }, { t("\\subsubsection{"), i(1, ""), t("}") },
        { condition = tex.in_text and conds.line_begin }),

    -- Symbols
    s({ trig = "ö(%l)", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            if GREEK_LETTERS[snip.captures[1]] then
                return "\\" .. GREEK_LETTERS[snip.captures[1]]
            end
            return ""
        end)
    }, { condition = tex.in_mathzone }),
    s({ trig = "pi", wordTrig = false, name = "pi" }, { t("\\pi") }, { condition = tex.in_mathzone }),
    s({ trig = "phi", wordTrig = false, name = "phi" }, { t("\\phi") }, { condition = tex.in_mathzone }),
    s({ trig = "mu", wordTrig = false, name = "mu" }, { t("\\mu") }, { condition = tex.in_mathzone }),
    s({ trig = "inf", wordTrig = false, name = "infinity" }, { t("\\infty") }, { condition = tex.in_mathzone }),
    s({ trig = "inn", wordTrig = false, name = "in" }, { t("\\in") }, { condition = tex.in_mathzone }),
    s({ trig = "abs", wordTrig = false, name = "absolute" }, { t("\\left| "), i(1), t(" \\right|") },
        { condition = tex.in_mathzone }),
    s({ trig = "mbf", wordTrig = false, name = "mathbold" }, { t("\\mathbf{"), i(1, ""), t("}") },
        { condition = tex.in_mathzone }),
    s({ trig = "qd", wordTrig = false, name = "quad" }, { t("\\quad ") }, { condition = tex.in_mathzone }),
    s({ trig = "qqd", wordTrig = false, name = "quad" }, { t("\\qquad ") }, { condition = tex.in_mathzone }),
    -- Comparison
    s({ trig = "leq", wordTrig = false, name = "leq" }, { t("\\leq ") }, { condition = tex.in_mathzone }),
    s({ trig = "geq", wordTrig = false, name = "geq" }, { t("\\geq ") }, { condition = tex.in_mathzone }),
    s({ trig = "app", wordTrig = false, name = "approx" }, { t("\\approx ") }, { condition = tex.in_mathzone }),
    -- Exponents
    s({ trig = "qs", wordTrig = false, name = "squared" }, { t("^2") }, { condition = tex.in_mathzone }),
    s({ trig = "cb", wordTrig = false, name = "cubed" }, { t("^3") }, { condition = tex.in_mathzone }),
    s({ trig = "sq", wordTrig = false, name = "square root" }, { t("\\sqrt{"), i(1, ""), t("}") },
        { condition = tex.in_mathzone }),
    s({ trig = "ee", wordTrig = false, name = "e^" }, { t("e^{"), i(1, ""), t("}") }, { condition = tex.in_mathzone }),


    -- Align things
    s({ trig = "==", wordTrig = false, name = "equals" }, { t(" &= ") }, { condition = tex.in_mathzone and tex.in_align }),
    s({ trig = "nl", wordTrig = false, name = "newline" }, { t("\\\\", "\t") },
        { condition = tex.in_mathzone and tex.in_align }),

    -- Arrows
    s({ trig = "=>", wordTrig = true, name = "Big rightarrow" }, { t(" \\implies ") },
        { condition = tex.in_mathzone }),
    s({ trig = "->", wordTrig = false, name = "Small rightarrow" }, { t(" \\rightarrow ") },
        { condition = tex.in_mathzone }),
    s({ trig = "<=", wordTrig = false, name = "Big leftarrow" }, { t(" \\impliedby ") },
        { condition = tex.in_mathzone }),
    s({ trig = "<-", wordTrig = false, name = "Small leftarrow" }, { t(" \\leftarrow ") },
        { condition = tex.in_mathzone }),

    -- Trigonometry
    s({ trig = 'sin', name = 'sin', wordTrig = false }, { t('\\sin ') }, { condition = tex.in_mathzone }),
    s({ trig = 'cos', name = 'cos', wordTrig = false }, { t('\\cos ') }, { condition = tex.in_mathzone }),
    s({ trig = 'tan', name = 'tan', wordTrig = false }, { t('\\tan ') }, { condition = tex.in_mathzone }),
    s({ trig = 'sec', name = 'sec', wordTrig = false }, { t('\\sec ') }, { condition = tex.in_mathzone }),
    s({ trig = '**', name = 'cdot', wordTrig = false }, { t('\\cdot ') }, { condition = tex.in_mathzone }),
    s({ trig = 'xx', name = 'times', wordTrig = false }, { t('\\times ') }, { condition = tex.in_mathzone }),
    s({ trig = 'arcsin', name = 'arcsin', wordTrig = false, priority = 1001 }, { t('\\arcsin ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'arccos', name = 'arccos', wordTrig = false, priority = 1001 }, { t('\\arccos ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'arctan', name = 'arctan', wordTrig = false, priority = 1001 }, { t('\\arctan ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'arcsec', name = 'arcsec', wordTrig = false, priority = 1001 }, { t('\\arcsec ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'asin', name = 'arcsin', wordTrig = false, priority = 1001 }, { t('\\arcsin ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'acos', name = 'arccos', wordTrig = false, priority = 1001 }, { t('\\arccos ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'atan', name = 'arctan', wordTrig = false, priority = 1001 }, { t('\\arctan ') },
        { condition = tex.in_mathzone }),
    s({ trig = 'asec', name = 'arcsec', wordTrig = false, priority = 1001 }, { t('\\arcsec ') },
        { condition = tex.in_mathzone }),


    -- Logarithm
    s({ trig = 'ln', name = 'ln' }, { t('\\ln ') }, { condition = tex.in_mathzone }),
    s({ trig = 'lln', name = 'abs ln' }, { t('\\ln\\left|'), i(1, ""), t('\\right|') }, { condition = tex.in_mathzone }),


    -- Derivatives
    s({ trig = 'der', name = 'derivatie', wordTrig = false },
        { t('\\frac{\\mathrm{d}'), i(1, "y"), t('}{\\mathrm{d}'), i(2, 'x'), t('}') }, { condition = tex.in_mathzone }),
    s({ trig = 'par', name = 'partial derivatie' },
        { t('\\frac{\\partial'), i(1, "y"), t('}{\\partial'), i(2, 'x'), t('}') }, { condition = tex.in_mathzone }),
    s({ trig = 'dy', name = 'dy', wordTrig = false }, { t('\\mathrm{d}y') }, { condition = tex.in_mathzone }),
    s({ trig = 'dx', name = 'dx', wordTrig = false }, { t('\\mathrm{d}x') }, { condition = tex.in_mathzone }),

    -- Integrals
    s({ trig = 'iint', name = 'indefinite integral' }, { t("\\int "), i(2, ""), t(" \\; \\mathrm{d}"), i(1, "x") },
        { condition = tex.in_mathzone }),
    s({ trig = 'sum', name = 'sum' }, { t("\\sum_{"), i(1, "i=0"), t("}^{"), i(2, "n"), t("}") },
        { condition = tex.in_mathzone }),
    s({ trig = 'prod', name = 'prod' }, { t("\\prod_{"), i(1, "i=0"), t("}^{"), i(2, "n"), t("}") },
        { condition = tex.in_mathzone }),

    s({ trig = 'ttt', name = 'texttt' }, { t("\\texttt{"), i(1), t("}") },
        { condition = not tex.in_mathzone }),

    -- Crypto things
    s({ trig = "Z([%d+]) ", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            return "\\mathbb{Z}_" .. snip.captures[1]
        end)
    }, { condition = tex.in_mathzone }),

    s({ trig = "mod (%d+) ", regTrig = true, wordTrig = false }, {
        f(function(_, snip)
            return "\\ (\\mathrm{mod}\\ " .. snip.captures[1] .. ") "
        end)
    }, { condition = tex.in_mathzone }),

    s({ trig = 'eqi', name = 'equiv', wordTrig = false }, { t('\\equiv ') }, { condition = tex.in_mathzone }),

    s({ trig = "figure", name = "figure" }, fmt([[
    \begin{figure}[H]
      \centering
      \includegraphics[<>\textwidth]{<>}
      \caption{<>}
      \label{fig:<>}
    \end{figure}

    ]],
        { i(2, "0.7"), i(1, "path"), i(3, "captivating caption"), i(4, "unique label") }, { delimiters = "<>" }
    ), { condition = conds.line_begin }),


    s({ trig = "table(%d+)", regTrig = true, name = "table" }, fmt([[
    \begin{table}[H]
      \centering
      \begin{tabular}[cc]
      \end{tabular}
      \label{tab:<>}
    \end{figure}

    ]],
        { i(1, "0.7"), }, { delimiters = "<>" }
    ), { condition = conds.line_begin }),


















    -- Fractions
    s({ trig = "//", name = "Fraction" }, { t("\\frac{"), i(1), t("}{"), i(2), t("}") }, { condition = tex.in_mathzone }),
    s({
        priority = 1000,
        trig = ".*%)/",
        wordTrig = true,
        regTrig = true,
        name = "() frac",
    }, {
        f(function(_, snip)
            local match = vim.trim(snip.trigger)

            local stripped = match:sub(1, #match - 1)

            i = #stripped
            local depth = 0
            while true do
                if stripped:sub(i, i) == ")" then
                    depth = depth + 1
                end
                if stripped:sub(i, i) == "(" then
                    depth = depth - 1
                end
                if depth == 0 then
                    break
                end
                i = i - 1
            end

            local rv = string.format(
                "%s\\frac{%s}",
                stripped:sub(1, i - 1),
                stripped:sub(i + 1, #stripped - 1)
            )
            return rv
        end, {}),
        t("{"),
        i(1),
        t("}"),
        i(0),
    }, { condition = tex.in_mathzone }),
    s({
        trig = "(\\?[%w]+\\?^%w)/",
        name = "Fraction no ()",
        regTrig = true,
    }, vim.deepcopy(frac_no_parens), { condition = tex.in_mathzone }),

    s({
        trig = "(\\?[%w]+\\?_%w)/",
        name = "Fraction no ()",
        regTrig = true,
    }, vim.deepcopy(frac_no_parens), { condition = tex.in_mathzone }),

    s({
        trig = "(\\?[%w]+\\?^{%w*})/",
        name = "Fraction no ()",
        regTrig = true,
    }, vim.deepcopy(frac_no_parens), { condition = tex.in_mathzone }),

    s({
        trig = "(\\?[%w]+\\?_{%w*})/",
        name = "Fraction no ()",
        regTrig = true,
    }, vim.deepcopy(frac_no_parens), { condition = tex.in_mathzone }),

    s({
        trig = "(\\?%w+)/",
        name = "Fraction no ()",
        regTrig = true,
    }, vim.deepcopy(frac_no_parens), { condition = tex.in_mathzone }
    ),



}
return snippets, autosnippets
