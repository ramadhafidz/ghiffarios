local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("nil_ls", {
    capabilities = capabilities,
    settings = {
        ["nil"] = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
})

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config("pyright", {
    capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
    capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
})

vim.lsp.config("marksman", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "nil_ls",
    "lua_ls",
    "pyright",
    "ts_ls",
    "rust_analyzer",
    "marksman",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
    end,
})
