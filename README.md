# nvim-config

## Requirements

* Neovim 0.11^
* Git
* Some NerdFont
* Node.js
* Python
* Rust

## Install

> Windows
```bash
git clone https://github.com/haruyq/nvim-config.git "$env:LOCALAPPDATA\nvim"
```

> Linux
```bash
git clone https://github.com/haruyq/nvim-config.git "~/.config/nvim"
```

### LSP

```
:Mason
```

### Formatter

```bash
npm install -g prettierd prettier
py -m pip install --user ruff
cargo install stylua
```