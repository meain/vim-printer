" ============================================================================
" File:        vim-printer.vim
" Author:      Abin Simon
" Description: Easily print out variables in any language
" License:     MIT
" ============================================================================

if exists('g:loaded_vim_printer') || &compatible
  finish
endif
let g:loaded_vim_printer = 1

let s:vim_printer_items_full = { 
            \ 'python': 'print("{$}:", {$})', 
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'javascriptreact': 'console.log("{$}:", {$})',
            \ 'javascript.jsx': 'console.log("{$}:", {$})',
            \ 'typescript': 'console.log("{$}:", {$})',
            \ 'typescriptreact': 'console.log("{$}:", {$})',
            \ 'typescript.tsx': 'console.log("{$}:", {$})',
            \ 'go': 'fmt.Println("{$}:", {$})',
            \ 'vim': 'echo "{$}: ".{$}',
            \ 'rust': 'println!("{$}: {:?}", {$});',
            \ 'sh': 'echo "{$}: ${$}"',
            \ 'bash': 'echo "{$}: ${$}"',
            \ 'zsh': 'echo "{$}: ${$}"',
            \ 'java': 'System.out.println("{$}: " + {$});',
            \ 'lua': 'print("{$}: " .. {$})',
            \ 'cpp': 'std::cout << "{$}: " << {$} << endl;',
            \ 'f77': 'write(6,*)"{$}: ", {$}',
            \ 'f90': 'write(6,*)"{$}: ", {$}' 
            \ }

let g:vim_printer_items = get(g:, 'vim_printer_items', {})
for pi in keys(g:vim_printer_items)
  let s:vim_printer_items_full[pi] = g:vim_printer_items[pi]
endfor

let s:print_below_keybinding = get(g:, 'vim_printer_print_below_keybinding', '<leader>p')
let s:print_above_keybinding = get(g:, 'vim_printer_print_above_keybinding', '<leader>P')


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

    let filetype = &filetype
    if has_key(s:vim_printer_items_full, filetype)
      if a:visual == 1
          let exp = s:GetVisualSelection()
      else
          let exp = expand('<cword>')
      endif

      let ns = substitute(s:vim_printer_items_full[filetype], '{$}', exp, 'g')
      if a:above == 1
          execute ':normal! O' . ns
      else
          execute ':normal! o' . ns
      endif
    else
      echo 'No vim-printer definition available for '. filetype
    endif
endfunction


execute 'nnoremap <silent>'. s:print_below_keybinding . ' :call AddPrintLine(0, 0)<CR>'
execute 'nnoremap <silent>'. s:print_above_keybinding . ' :call AddPrintLine(0, 1)<CR>'
execute 'vnoremap <silent>'. s:print_below_keybinding . ' :call AddPrintLine(1, 0)<CR>'
execute 'vnoremap <silent>'. s:print_above_keybinding . ' :call AddPrintLine(1, 1)<CR>'
