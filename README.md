# vim-printer

Quickly print/log the variable in your favourite language

## Installation

Use your favourite plugin manager to install. I use `vim-plug`.

```
Plug 'meain/vim-printer'
```

## Usage

There is two keybinding in each normal mode and visual mode.
In normal mode it works on current word under cursor and in visual mode it works on the visual selection.

- `<leader>p` to add print/log statement below current line
- `<leader>P` to add print/log statement above current line


## Configuration

You can change the default keybindings like below.
It will be used both in normal mode and visual mode.

```
let g:vim_printer_print_below_keybinding = '<leader>p'
let g:vim_printer_print_above_keybinding = '<leader>P'
```

You can add new languages own your own by using.
The ones you add will be combined with the existing ones.

> The text inside `{$}` will be replaced by the variable

```
let g:vim_printer_items = {
      \ 'javascript': 'console.log("{$}:", {$})',
      \ }
```



## Future TODO

- add some kind of debug mode print
    eg: `logging.log()` in python or `println!('{:?}', var)` in rust
    
    
    
## Alternatives


- [vim-printf](https://github.com/mptre/vim-printf)
