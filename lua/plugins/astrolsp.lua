-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(plugin, opts)
    opts.servers = opts.servers or {}
    table.insert(opts.servers, "gopls")
    table.insert(opts.servers, "clangd")

    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        -- root_dir = root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      },
      clangd = {
        capabilities = {
          root_dir = require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja",
            "compile_flags.txt"
          ),
          offsetEncoding = "utf-8",
          cmd = {
            "clangd",
            "--offset-encoding=utf-8",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--falback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    })
  end,
}
--   -- Configuration table of features provided by AstroLSP
--   features = {
--     codelens = true, -- enable/disable codelens refresh on start
--     inlay_hints = false, -- enable/disable inlay hints on start
--     semantic_tokens = true, -- enable/disable semantic token highlighting
--   },
--   -- customize lsp formatting options
--   formatting = {
--     -- control auto formatting on save
--     format_on_save = {
--       enabled = true, -- enable or disable format on save globally
--       allow_filetypes = { -- enable format on save for specified filetypes only
--         "go",
--         --   "c",
--         --   "cpp",
--         --   "h",
--         --   "hpp",
--       },
--       ignore_filetypes = { -- disable format on save for specified filetypes
--         -- "python",
--       },
--     },
--     disabled = { -- disable formatting capabilities for the listed language servers
--       -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
--       -- "lua_ls",
--     },
--     timeout_ms = 1000, -- default format timeout
--     -- filter = function(client) -- fully override the default formatting function
--     --   return true
--     -- end
--   },
-- enable servers that you already have installed without mason

-- customize language server configuration options passed to `lspconfig`
---@diagnostic disable: missing-fields
-- config = {
-- clangd = { capabilities = { offsetEncoding = "utf-8" } },
-- clangd = {
--   capabilities = {
--     root_dir = util.root_pattern(
--       "Makefile",
--       "configure.ac",
--       "configure.in",
--       "config.h.in",
--       "meson.build",
--       "meson_options.txt",
--       "build.ninja",
--       "compile_flags.txt"
--     ),
--     offsetEncoding = "utf-8",
--     cmd = {
--       "clangd",
--       "--offset-encoding=utf-8",
--       "--background-index",
--       "--clang-tidy",
--       "--header-insertion=iwyu",
--       "--completion-style=detailed",
--       "--function-arg-placeholders",
--       "--falback-style=llvm",
--     },
--     init_options = {
--       usePlaceholders = true,
--       completeUnimported = true,
--       clangdFileStatus = true,
--     }
--   },
-- },
-- gopls = {
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
--   -- root_dir = root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--     },
--   },
-- },
