require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = {
            enabled = true,
        },
        which_key = true,
    },
})

vim.cmd.colorscheme("catppuccin")

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            ".git/",
            "result",
            "node_modules/",
            ".direnv/",
        },
        layout_config = {
            horizontal = {
                preview_width = 0.55,
            },
        },
    },
})


require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "nix",
        "lua",
        "python",
        "javascript",
        "typescript",
        "rust",
        "sh",
        "json",
        "yaml",
        "markdown",
    },
    callback = function()
        vim.treesitter.start()
    end,
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
})

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
    }),
})

require("lualine").setup({
    options = {
        theme = "catppuccin",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
    },
})

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        offsets = {
            {
                filetype = "oil",
                text = "File Explorer",
                highlight = "Directory",
                separator = true,
            },
        },
    },
})

require("which-key").setup()

require("gitsigns").setup()

require("nvim-autopairs").setup()

require("Comment").setup()
