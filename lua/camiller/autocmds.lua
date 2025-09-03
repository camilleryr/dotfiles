local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local random = augroup("random", { clear = true })
local term_settings = augroup("term_settings", { clear = true })

autocmd("VimResized", { group = random, pattern = "*", command = "wincmd =" })

autocmd("GUIEnter", {
  group = random,
  pattern = "*",
  callback = function()
    vim.opt.visualbell = "t_vb="
  end,
})

autocmd("LspAttach", {
  group = augroup("lsp", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local map_opts = { buffer = bufnr, silent = true }

    local fzf = function(func, override)
      local opts = override or { winopts = { height = 0.9, width = 0.9 } }
      return function()
        require("fzf-lua")[func](opts)
      end
    end

    vim.keymap.set("n", "ff", vim.lsp.buf.format, map_opts)
    vim.keymap.set("n", "df", vim.diagnostic.open_float, map_opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, map_opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, map_opts)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, map_opts)
    vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, map_opts)
    vim.keymap.set("n", "gr", fzf("lsp_references"), map_opts)
    vim.keymap.set("n", "gi", fzf("lsp_implementations"), map_opts)
    vim.keymap.set("n", "g0", fzf("lsp_document_symbols"), map_opts)
    vim.keymap.set("n", "g7", fzf("lsp_workspace_symbols"), map_opts)
    vim.keymap.set("n", "<leader>ca", fzf("lsp_code_actions", {}), map_opts)
    vim.keymap.set("n", "<leader>dd", fzf("lsp_document_diagnostics"), map_opts)
    vim.keymap.set("n", "<leader>da", fzf("lsp_workspace_diagnostics"), map_opts)
    vim.keymap.set("n", "<C-r>", vim.lsp.codelens.run, map_opts)

    vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
    vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
    if client.server_capabilities.codelensProvider then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
      vim.lsp.codelens.refresh()
    end

    -- if client.server_capabilities.documentSymbolProvider then
    --   require("nvim-navic").attach(client, bufnr)
    -- end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint(bufnr, true)
    end
  end,
})

autocmd("ColorScheme", {
  group = random,
  pattern = "everforest",
  callback = function()
    local highlights = {
      ["@module.elxir"] = { fg = "#61afef" },
      ["@constant.elixir"] = { link = "PurpleItalic" },
    }

    for key, value in pairs(highlights) do
      vim.api.nvim_set_hl(0, key, value)
    end
  end,
})

autocmd("FileType", {
  group = random,
  pattern = "netrw",
  callback = function()
    if vim.fn.hasmapto("<Plug>NetrwRefresh") > 0 then
      vim.cmd([[unmap <buffer> <C-l>]])
    end

    if vim.fn.hasmapto("<Plug>NetrwHideEdit") > 0 then
      vim.cmd([[unmap <buffer> <C-h>]])
    end
  end,
})

autocmd("BufWritePre", {
  group = random,
  pattern = {"*.ex", "*.exs"},
  callback = function()
    vim.lsp.buf.format({})
  end,
})

autocmd("FileType", {
  group = random,
  pattern = "elixir",
  callback = function()
    vim.cmd.setlocal("winhighlight+=Normal:Normal")
    vim.keymap.set("t", "<esc>", "<C-c>", { buffer = 0 })
  end,
})

autocmd("BufWritePre", {
    pattern = "*",
    group = random,
    callback = function()
      vim.cmd("StripWhitespace")
    end
  })

local open = function(url)
  vim.cmd("!open . shellescape(a:url, 1)", { silent = true })
  vim.cmd("redraw")
end

autocmd("TermOpen", {
    pattern = "*",
    group = term_settings,
    callback = function()
      local opt_local = vim.opt_local

      opt_local.number = false
      opt_local.bufhidden = "hide"

      vim.cmd("startinsert")

      local set = vim.keymap.set

      set('n', 'gx', ':call open(expand("<cfile>"))<CR>', { buffer = true })
      set('v', 'gx', '"xy | :call open(@x)<CR>', { buffer = true })
      set('t', '<Esc><Esc>', '<c-\\><c-n>', { buffer = true })
    end
  })
