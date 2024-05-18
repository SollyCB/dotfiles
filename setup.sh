#!/usr/bin/bash

{set -xe} 2>/dev/null

if [[ -z $XDG_CONFIG_HOME]]; then
    echo \$XDG_CONFIG_HOME is not set, script cannot run
    exit -1
fi

mkdir pack/nvim/
mkdir pack/nvim/start/
mkdir pack/nvim/start/

git clone https://github.com/nvim-lua/plenary.nvim /home/solly/.config/dotfiles/pack/nvim/start/plenary
git clone https://github.com/neovim/nvim-lspconfig /home/solly/.config/dotfiles/pack/nvim/start/nvim-lspconfig
git clone https://github.com/nvim-telescope/telescope.nvim /home/solly/.config/dotfiles/pack/nvim/start/telescope

ln -s $PWD/pack/ $XDG_CONFIG_HOME/nvim/pack/

