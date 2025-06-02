## Setup

To setup neovim using the configurations in this repository, you need to do the following:
1. Install Packer for neovim from Github - [link to github repo](https://github.com/wbthomason/packer.nvim)
2. Run :PackerSync in the ~/.config/nvim/lua/alex/plugins.lua file
  2.a. If you see a long list of errors, hit G and enter to acknowlege all errors. Otherwise,
  you won't be able to run PackerSync
3. Run :so to source the init.lua file from ~/.config/nvim/init.lua

## LSP Configurations

Note: The ftplugin folder is ignored by git. This is because each device I configure neovim
may configure LSPs differently for various reasons (e.g; different build tools, lsps for languages
I may use on one device but not another, etc)

To setup new LSP configurations, define a folder ftplugin and in this folder create a file for each
language you'd like to configure an LSP. Make sure to import the lsp.lua file and pass
in the `on_attach` function which has custom keymaps for LSPs.
