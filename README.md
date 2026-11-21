# kingscott.nvim

My Neovim config. It is built on [LazyVim](https://www.lazyvim.org/), starting from Omarchy's LazyVim setup.

## What this config is

- **Base:** Omarchy's LazyVim config. The LazyVim extras are listed in `lazyvim.json`: neo-tree, Ember, Go, TypeScript, and TypeScript oxc.
- **Theme:** `lua/plugins/theme.lua` is a symlink to Omarchy's current Neovim theme file, so the colorscheme follows the Omarchy theme. `lua/plugins/omarchy-theme-hotreload.lua` reloads it when the theme changes. `lua/plugins/all-themes.lua` loads the theme plugins.
- **Personal changes:**
  - `lua/config/` holds options, keymaps, autocmds, and the clipboard setup (`remote_clipboard.lua`).
  - `lua/plugins/kingscott.lua` holds the start screen, picker settings, LSP and git keymaps, extra Treesitter parsers, and Harpoon.

## Installation

### External dependencies

- Basic tools: `git`, `make`, `unzip`, and a C compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) for searching file contents
- [fd](https://github.com/sharkdp/fd#installation) for finding files
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md). nvim-treesitter needs it on Neovim 0.12 to build parsers.
- Clipboard tool: `wl-clipboard` (`wl-copy` and `wl-paste`) on Wayland, or `xclip` or `xsel` on X11
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides icons
- Language toolchains:
  - TypeScript: `npm`
  - Go: `go`

Neovim 0.12 or newer is required.

> **NOTE**
> See [Install recipes](#install-recipes) for quick install commands.

### Install the config

> **NOTE**
> [Back up](#faq) your existing Neovim configuration first, if you have one.

Neovim's configuration is located under the following paths, depending on your OS:

| OS | Path |
| :- | :--- |
| Linux, macOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd) | `%localappdata%\nvim\` |
| Windows (PowerShell) | `$env:LOCALAPPDATA\nvim\` |

Clone the config (Linux and macOS):

```sh
git clone https://github.com/kingscott/kingscott.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Post installation

Start Neovim:

```sh
nvim
```

On first launch, lazy.nvim installs the plugins and Mason installs the language servers and tools that the enabled extras need. Use `:Lazy` to check plugin status. Press `q` to close the window.

Run `:checkhealth` to see if any dependencies are missing.

### Plugin versions

`lazy-lock.json` pins every plugin to a specific commit. Use `:Lazy restore` to match the pinned versions. Use `:Lazy update` to update plugins, which also rewrites `lazy-lock.json`. Commit the lock file when you update plugins so other machines get the same versions.

## Install recipes

### Arch Linux

```sh
sudo pacman -S --needed gcc make git ripgrep fd unzip neovim tree-sitter-cli wl-clipboard
```

For TypeScript and Go, install their toolchains as well:

```sh
sudo pacman -S --needed npm go
```

Other distributions need the same packages. Install Neovim 0.12 or newer from your distribution or from the [Neovim releases](https://github.com/neovim/neovim/releases).

## FAQ

- **I already have a Neovim configuration. What should I do?**
  - Back it up, then remove it from the active paths:

    ```sh
    mv ~/.config/nvim{,.bak}
    mv ~/.local/share/nvim{,.bak}
    ```

- **Can I keep my existing configuration in parallel?**
  - Yes. Use [`NVIM_APPNAME`](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME) to run a second config from a different directory. For example, clone this config to `~/.config/nvim-kingscott` and add an alias:

    ```sh
    alias nvim-kingscott='NVIM_APPNAME="nvim-kingscott" nvim'
    ```

    Neovim then uses `~/.config/nvim-kingscott` and its own data directory, `~/.local/share/nvim-kingscott`.

- **How do I uninstall this configuration?**
  - See the [lazy.nvim uninstall instructions](https://lazy.folke.io/usage#-uninstalling).
