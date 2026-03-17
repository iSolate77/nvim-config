local function switch_source_header(bufnr, client)
  local method_name = "textDocument/switchSourceHeader"
  if not client or not client:supports_method(method_name) then
    vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
    return
  end

  local params = vim.lsp.util.make_text_document_params(bufnr)
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info(bufnr, client)
  local method_name = "textDocument/symbolInfo"
  if not client or not client:supports_method(method_name) then
    vim.notify("Clangd client not found", vim.log.levels.ERROR)
    return
  end

  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  client:request(method_name, params, function(err, res)
    if err or not res or #res == 0 then
      return
    end

    local container = ("container: %s"):format(res[1].containerName)
    local name = ("name: %s"):format(res[1].name)
    vim.lsp.util.open_floating_preview({ name, container }, "", {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      title = "Symbol Info",
    })
  end, bufnr)
end

local function create_tinymist_command(command_name, client, bufnr)
  local cmd_display = command_name:match("tinymist%.export(%w+)")
  local function run_tinymist_command()
    local arguments = { vim.api.nvim_buf_get_name(bufnr) }
    return client:exec_cmd({
      title = "Export " .. cmd_display,
      command = command_name,
      arguments = arguments,
    }, { bufnr = bufnr })
  end
  return run_tinymist_command, ("Export" .. cmd_display), ("Export to " .. cmd_display)
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local blink_ok, blink = pcall(require, "blink.cmp")
    local capabilities = blink_ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Go to previous diagnostic message" })
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Go to next diagnostic message" })
    vim.keymap.set("n", "<leader>k", function()
      vim.diagnostic.open_float()
    end, { desc = "Open floating diagnostic message" })
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
    vim.keymap.set("n", "<leader>lt", function()
      vim.diagnostic.config({ virtual_text = true })
    end)
    vim.keymap.set("n", "<leader>tl", function()
      vim.diagnostic.config({ virtual_text = false })
    end)

    local lsp_keymaps_group = vim.api.nvim_create_augroup("mfaris_lsp_keymaps", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_keymaps_group,
      callback = function(args)
        local bufnr = args.buf
        local function map(lhs, rhs, desc, mode)
          vim.keymap.set(mode or "n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        local function snacks_picker(method, fallback)
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks.picker and snacks.picker[method] then
            snacks.picker[method]()
            return
          end
          fallback()
        end

        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        -- Regression check: `:verbose nmap gr` should point to this file after LspAttach.
        map("gr", function()
          snacks_picker("lsp_references", vim.lsp.buf.references)
        end, "References")
        map("gi", function()
          snacks_picker("lsp_implementations", vim.lsp.buf.implementation)
        end, "Goto Implementation")
        map("gD", function()
          snacks_picker("lsp_type_definitions", vim.lsp.buf.type_definition)
        end, "Goto Type Definition")
        map("<leader>ss", function()
          snacks_picker("lsp_symbols", vim.lsp.buf.document_symbol)
        end, "LSP Symbols")
        map("<leader>sS", function()
          snacks_picker("lsp_workspace_symbols", function()
            local query = vim.fn.input("Workspace symbols: ")
            if query ~= "" then
              vim.lsp.buf.workspace_symbol(query)
            end
          end)
        end, "LSP Workspace Symbols")

        map("<leader>lf", vim.lsp.buf.format, "format")
        map("<leader>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ls", vim.lsp.buf.signature_help, "Signature Documentation")
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
      end,
    })

    vim.lsp.config("*", {
      root_markers = { ".git" },
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = {
        "lua",
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
      },
      settings = {
        Lua = {
          hint = { enable = true },
          workspace = {
            library = {
              vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "go.mod", "gosum", "go.sum", "gowork", "gotmpl", "go.tmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
    })

    vim.lsp.config("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
      },
      capabilities = vim.tbl_deep_extend("force", {}, capabilities, {
        textDocument = {
          completion = {
            editsNearCursor = true,
          },
        },
        offsetEncoding = { "utf-8", "utf-16" },
      }),
      on_init = function(client, init_result)
        if init_result.offsetEncoding then
          client.offset_encoding = init_result.offsetEncoding
        end
      end,
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
          switch_source_header(bufnr, client)
        end, { desc = "Switch between source/header" })

        vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
          symbol_info(bufnr, client)
        end, { desc = "Show symbol info" })
      end,
    })

    vim.lsp.config("tinymist", {
      cmd = { "tinymist" },
      filetypes = { "typst" },
      root_markers = { ".git" },
      settings = {
        formatterMode = "typstyle",
      },
      on_attach = function(client, bufnr)
        for _, command in ipairs({
          "tinymist.exportSvg",
          "tinymist.exportPng",
          "tinymist.exportPdf",
          "tinymist.exportHtml",
          "tinymist.exportMarkdown",
        }) do
          local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
        end
      end,
    })

    vim.lsp.config("zls", {
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_markers = { "zls.json", "build.zig", ".git" },
      settings = {
        zls = {
          semantic_tokens = "partial",
          zig_exe_path = "/opt/homebrew/bin/zig",
        },
      },
    })

    vim.lsp.config("dts_lsp", {
      name = "dts_lsp",
      cmd = { "dts-lsp" },
      filetypes = { "dts", "dtsi", "overlay" },
      root_markers = { ".git" },
      settings = {},
    })

    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "relative",
          includePackageJsonAutoImports = "auto",
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })

    vim.lsp.config("buf_ls", {
      cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
      filetypes = { "proto" },
      root_markers = { "buf.yaml", ".git" },
    })

    vim.lsp.config("ols", {
      name = "ols",
      filetypes = { "odin" },
      cmd = { "ols" },
      root_markers = { "ols.json", ".git" },
    })

    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
      update_in_insert = false,
      underline = true,
      severity_sort = false,
      float = {
        focusable = true,
        style = "minimal",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })

    vim.lsp.enable({
      "lua_ls",
      "gopls",
      "clangd",
      "tinymist",
      "zls",
      "dts_lsp",
      "ts_ls",
      "buf_ls",
      "ols",
    })
  end,
}
