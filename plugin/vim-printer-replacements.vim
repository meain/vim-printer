
if exists('g:loaded_vim_printer_replacements') || &compatible
  finish
endif
let g:loaded_vim_printer_replacements = 1

let g:vim_printer_items = { 
            \ 'python': 'print("{$}:", {$})', 
            \ 'javascript': 'console.log("{$}:", {$})',
            \ 'javascript.jsx': 'console.log("{$}:", {$})',
            \ 'typescipt': 'console.log("{$}:", {$})',
            \ 'go': 'fmt.Println("{$}:", {$})',
            \ 'vim': 'echo "{$}: ".{$}',
            \ 'rust': 'println!("{$}: {}", {$})',
            \ 'cs': 'Console.WriteLine("{$}: {0}", {$});'
            \ }
