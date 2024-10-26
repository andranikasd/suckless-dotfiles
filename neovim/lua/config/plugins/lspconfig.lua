return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local nvim_lsp = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    local protocol = require("vim.lsp.protocol")

    local on_attach = function(client, bufnr)
      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup_handlers({
      -- Default handler for all servers
      function(server)
        nvim_lsp[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      ["tailwindcss"] = function()
        nvim_lsp["tailwindcss"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["html"] = function()
        nvim_lsp["html"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["jsonls"] = function()
        nvim_lsp["jsonls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["pyright"] = function()
        nvim_lsp["pyright"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- Go configuration
      ["gopls"] = function()
        nvim_lsp["gopls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        })
      end,
      -- C/C++ configuration
      ["clangd"] = function()
        nvim_lsp["clangd"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- Bash configuration
      ["bashls"] = function()
        nvim_lsp["bashls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- Docker configuration
      ["dockerls"] = function()
        nvim_lsp["dockerls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- YAML configuration
      ["yamlls"] = function()
        nvim_lsp["yamlls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            yaml = {
              schemas = {
                kubernetes = "/*.yaml",                 -- Kubernetes schema support
              },
            },
          },
        })
      end,
      -- Ansible configuration
      ["ansiblels"] = function()
        nvim_lsp["ansiblels"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- Terraform configuration
      ["terraformls"] = function()
        nvim_lsp["terraformls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}
