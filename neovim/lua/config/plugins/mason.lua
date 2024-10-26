return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Mason setup
    require("mason").setup()

    -- Mason LSP configuration setup
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        -- Python
        "pyright",         -- Python LSP
        "pylsp",           -- Alternative Python LSP

        -- Go
        "gopls",         -- Go LSP

        -- C, C++
        "clangd",         -- C/C++ LSP

        -- DevOps/Infrastructure
        "bashls",              -- Bash LSP
        "dockerls",            -- Dockerfile LSP
        "yamlls",              -- YAML LSP
        "ansiblels",           -- Ansible LSP
        "terraformls",         -- Terraform LSP
        "lua_ls",              -- Lua LSP (for Neovim configs or scripting)
      },
    })

    -- Mason Tool Installer setup
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Python tools
        "prettier",         -- Formatter for many languages
        "stylua",           -- Lua formatter
        "isort",            -- Python import sorter
        "black",            -- Python code formatter
        "pylint",           -- Python linter

        -- Go tools
        "golines",         -- Go code formatter
        "gofumpt",         -- Go code formatter
        "revive",          -- Go linter

        -- C/C++ tools
        "clang-format",         -- C/C++ formatter
        "cpplint",              -- C++ linter

        -- DevOps tools
        "shfmt",              -- Shell script formatter
        "shellcheck",         -- Shell script linter
        "hadolint",           -- Dockerfile linter
        "yamlfmt",            -- YAML formatter
        "tflint",             -- Terraform linter
      },
    })
  end,
}
