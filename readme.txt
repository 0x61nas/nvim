   ___                            _     
  / _ | ___  ___ ____   ___ _  __(_)_ _ 
 / __ |/ _ \/ _ `(_-<_ / _ \ |/ / /  ' \
/_/ |_/_//_/\_,_/___(_)_//_/___/_/_/_/_/

        Your cozy Neovim setup, ready in seconds.
  Gruvbox'd, lazy-loaded, and containerized for any env.

Zero-effort Neovim with lualine, telescope, nvim-cmp, gitsigns,
oil.nvim, leap.nvim, conform, todo-comments, and more —
all pre-installed and configured.

Pick your poison — Docker (zero deps, works everywhere)
or native install on your machine.

---------------
 MANUAL INSTALL
---------------

1. Install Neovim 0.11+ and deps

  # Arch
  sudo pacman -S neovim git ripgrep lua-format

  # macOS
  brew install neovim git ripgrep lua-format

  # Debian/Ubuntu — get a recent nvim first, then
  sudo apt install git ripgrep lua-formatter-ng

2. Clone & link the config

  git clone https://github.com/0x61nas/dotfiles ~/dotfiles
  mkdir -p ~/.config
  ln -sf ~/dotfiles/home/.config/nvim ~/.config/nvim

3. Open nvim — plugins install themselves

  nvim

4. (Optional) Build native extensions for better perf

  cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make
  cd ~/.local/share/nvim/lazy/LuaSnip && make install_jsregexp

---------------
 DOCKER IMAGE
---------------

Pre-built (fastest):

  docker pull ghcr.io/0x61nas/nvim:latest
  docker pull anaselgarhy/nvim:latest

  docker run --rm -it ghcr.io/0x61nas/nvim
  docker run --rm -it -v "$(pwd):/workspace" ghcr.io/0x61nas/nvim

Build from source:

  docker build -t anas-nvim .
  docker run --rm -it anas-nvim

Done.
