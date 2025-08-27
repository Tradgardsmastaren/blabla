local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    print("Luasnip didn't load")
end
require("luasnip.loaders.from_vscode").lazy_load()

if package.config:sub(1,1)=="\\" then
    require("luasnip.loaders.from_lua").load({paths = "~/AppData/Local/nvim/snippets"})
else
    require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
end


ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
            active = {
                virt_text = { { "*", "Purpule" } },
            },
        },
    },
})

---- Keybindings ----
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)

