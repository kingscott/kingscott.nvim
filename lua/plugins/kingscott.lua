-- Personal plugins and overrides on top of LazyVim

local logo = [[
              _.-~-.
             7''  Q..\
          _7         (_
        _7  _/    _q.  /
      _7 . ___  /VVvv-'_                                            .
    7/ / /~- \_\\      '-._     .-'                      /       //
   ./ ( /-~-/||'=.__  '::. '-~'' {             ___   /  //     ./{   _      ./{
   V   V-~-~| ||   __''_   ':::.   ''~-~.___.-'' _/  // / {_   /  {  / }    /   \
  VV/-~-~-|/ \ .'__'. '.    '::  _    _                   {_/        _   _      ''
  / /~~~~||VVV/ /  \ )  \       | | _(_)_ __   ___   ___  ___  ___ _| |_| |_   .::'
 / (~-~-~\\.-' /    \'   \::::. | |/ | | '_ \ / _ \ / __|/ __'/ _ |_   _   _|  :::'
/..\    /..\__/      '     '::: |   \| | | | | (_) )\  \  (__( ( ) )| | | |   ::'
vVVv    vVVv                 ': |_|\_|_|_| |_|\__' |____|\___,\___/ |_| |_|   ''
                                              .__| |
                                               \__/
]]

-- The start screen centers each line on its own, so pad every line to the same
-- width to keep the drawing's shape.
local function pad_lines(text)
  local rows = vim.split(text, "\n")
  local width = 0
  for _, row in ipairs(rows) do
    width = math.max(width, vim.fn.strdisplaywidth(row))
  end
  for i, row in ipairs(rows) do
    rows[i] = row .. string.rep(" ", width - vim.fn.strdisplaywidth(row))
  end
  return table.concat(rows, "\n")
end

return {
  -- Start screen
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = pad_lines(logo),
        },
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".github", "target", ".DS_Store", "vendor", "node_modules", "log", ".dev", "coverage" },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".github", "target", ".DS_Store", "vendor", "node_modules", "log", ".dev", "coverage" },
          },
        },
      },
    },
  },

  -- Keep the ":" command line at the bottom instead of a popup
  {
    "folke/noice.nvim",
    opts = {
      cmdline = { view = "cmdline" },
      presets = { command_palette = false },
    },
  },

  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          -- stylua: ignore
          keys = {
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition", has = "definition" },
            { "gr", function() Snacks.picker.lsp_references() end, desc = "[G]oto [R]eferences", nowait = true },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
            { "<leader>D", function() Snacks.picker.lsp_type_definitions() end, desc = "Type [D]efinition" },
            { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "[D]ocument [S]ymbols" },
            { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[W]orkspace [S]ymbols" },
            { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame", has = "rename" },
            { "<C-h>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature [H]elp", has = "signatureHelp" },
            {
              "<leader>th",
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 }) end,
              desc = "[T]oggle Inlay [H]ints",
              has = "inlayHint",
            },
          },
        },
      },
    },
  },

  -- Git hunk keymaps, added alongside LazyVim's
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local lazyvim_on_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        if lazyvim_on_attach then
          lazyvim_on_attach(bufnr)
        end
        local gitsigns = require("gitsigns")
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Jump to next git [c]hange")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Jump to previous git [c]hange")

        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "stage git hunk")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "reset git hunk")
        map("n", "<leader>hs", gitsigns.stage_hunk, "git [s]tage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "git [r]eset hunk")
        map("n", "<leader>hS", gitsigns.stage_buffer, "git [S]tage buffer")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "git [u]ndo stage hunk")
        map("n", "<leader>hR", gitsigns.reset_buffer, "git [R]eset buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "git [p]review hunk")
        map("n", "<leader>hb", gitsigns.blame_line, "git [b]lame line")
        map("n", "<leader>hd", gitsigns.diffthis, "git [d]iff against index")
        map("n", "<leader>hD", function()
          gitsigns.diffthis("@")
        end, "git [D]iff against last commit")
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle git show [b]lame line")
        map("n", "<leader>tD", gitsigns.toggle_deleted, "[T]oggle git show [D]eleted")
      end
    end,
  },

  -- which-key group labels for the keymaps above
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "<leader>n", group = "File tree" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>w", group = "[W]orkspace" },
      },
    },
  },

  -- Treesitter parsers not already installed by LazyVim or the language extras
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "embedded_template", "json5", "proto", "scss", "sql" },
    },
    init = function()
      -- Parse jsonc with json5, which allows trailing commas. nvim-treesitter maps jsonc to json
      -- when it loads, so register after that.
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function(ev)
          if ev.data == "nvim-treesitter" then
            vim.treesitter.language.register("json5", "jsonc")
            return true
          end
        end,
      })
    end,
  },

  -- Git
  { "tpope/vim-fugitive", cmd = "Git" },

  -- Quick file switcher
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      menu = { width = vim.api.nvim_win_get_width(0) - 25 },
      settings = { save_on_toggle = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "H[a]rpoon file" },
      { "<C-e>", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Toggle harpoon menu" },
      { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Navigate to harpoon file [1]" },
      { "<C-t>", function() require("harpoon"):list():select(2) end, desc = "Navigate to harpoon file [2]" },
      { "<C-n>", function() require("harpoon"):list():select(3) end, desc = "Navigate to harpoon file [3]" },
      { "<C-m>", function() require("harpoon"):list():select(4) end, desc = "Navigate to harpoon file [4]" },
    },
  },
}
