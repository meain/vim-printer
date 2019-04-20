" ============================================================================
" File:        vim-printer.vim
" Author:      Abin Simon
" Description: Easily out variables in any language
" License:     MIT
" ============================================================================

if exists('g:loaded_vim_printer') || &compatible
  finish
endif
let g:loaded_vim_printer = 1


let s:print_below_keybinding = get(g:, 'g:vim_printer_print_below_keybinding', '<leader>p')
let s:print_above_keybinding = get(g:, 'g:vim_printer_print_above_keybinding', '<leader>P')


" i am not sure if this is the right way to do it
function s:GetVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2) 

    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    let selectedText = join(lines, "\n")
    return selectedText
endfunction

function! AddPrintLine(visual, above)

    if a:visual == 1
        let exp = s:GetVisualSelection()
    else
        let exp = expand('<cword>')
    endif

    let filetype = &filetype
    let ns = substitute(g:vim_printer_items[filetype], '{$}', exp, 'g')
    if a:above == 1
        call append(line('.') - 1, ns)
    else
        call append(line('.'), ns)
    endif
endfunction


execute 'nnoremap <silent>'. s:print_below_keybinding . ' :call AddPrintLine(0, 0)<CR>'
execute 'nnoremap <silent>'. s:print_above_keybinding . ' :call AddPrintLine(0, 1)<CR>'
execute 'vnoremap <silent>'. s:print_below_keybinding . ' :call AddPrintLine(1, 0)<CR>'
execute 'vnoremap <silent>'. s:print_above_keybinding . ' :call AddPrintLine(1, 1)<CR>'
