(require-macros :hibiscus.core)
(require-macros :hibiscus.vim)

(set! autoindent true)
(set! tabstop 4)
(set! shiftwidth 4)
(set! mouse "")
(set! backspace "indent,eol,start")
(set! cursorline true)
(set! ttyfast true)
(set! number true)
(set! incsearch true)
(set! clipboard :unnamedplus)
(set! splitkeep :screen)
(set! signcolumn :yes)
(set! lazyredraw true)
(set! termguicolors true)
(set! conceallevel 2)

(g! smartindent 1)
(g! mapleader " ")
;Neovim config for the links to show properly
(set! conceallevel 2)
(set! concealcursor :nc)

(g! maplocalleader ",")
(set! fillchars
      "horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┫,vertright:┣,verthoriz:╋")
(vim.diagnostic.config {:severity_sort true
                        :signs true
                        :underline true
                        :update_in_insert true
                        :virtual_text true})

(local signs {:Error "! " :Hint " " :Info " " :Warn " "})
(each [type icon (pairs signs)] (local hl (.. :DiagnosticSign type))
  (vim.fn.sign_define hl {:numhl hl :text icon :texthl hl}))

(when (= (vim.fn.executable :rg) 1)
  (set vim.opt.grepprg
       "rg --no-heading --vimgrep --smart-case --hidden --glob=!.git/")
  (set vim.opt.grepformat "%f:%l:%c:%m"))

(vim.cmd "  command! -bang -nargs=* -complete=file_in_path -bar Grep call asyncdo#run(
              \\ <bang>0,
              \\ { 'job': &grepprg, 'errorformat': &grepformat },
              \\ <f-args>) 
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

  noreabbrev  <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'
  augroup init_quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
  augroup END
")
