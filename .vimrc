set nocompatible

" Plugin manager: vim-plug (~/.vim/autoload/plug.vim from masterScript.sh)
" Run :PlugInstall after first setup
filetype plugin indent on

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin(expand('~/.vim/plugged'))

  " glowshi: custom maps at end of vimrc (; is mapped to : separately)
  let g:glowshi_ft_no_default_key_mappings = 1

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'will133/vim-dirdiff'
  Plug 'chrisbra/vim-diff-enhanced'
  Plug 'ryanoasis/vim-devicons'
  Plug 'saihoooooooo/glowshi-ft.vim'
  Plug 'oblitum/rainbow'
  Plug 'tpope/vim-surround'
  Plug 'preservim/nerdtree'
  Plug 'yegappan/mru'
  Plug 'preservim/tagbar'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/vim-easy-align'
  Plug 'kshenoy/vim-signature'
  Plug 'mileszs/ack.vim'
  Plug 'godlygeek/tabular'
  " Mark--Karkat removed: hijacks * and # (conflicts with native search)
  Plug 'vim-airline/vim-airline'
  Plug 'benmills/vimux'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
  Plug 'honza/vim-snippets'
  Plug 'Townk/vim-autoclose'
  Plug 'junegunn/goyo.vim'
  Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim'
  Plug 't9md/vim-quickhl'
  Plug 'preservim/nerdcommenter'
  Plug 'christoomey/vim-tmux-navigator'
  " ccase.vim removed: broken on Vim 9+ (E1208 -complete errors)
  Plug 'mhinz/vim-startify'
  Plug 'krisajenkins/vim-pipe'
  Plug 'tmhedberg/matchit'
  Plug 'valloric/MatchTagAlways'

  call plug#end()
endif

function! s:setup_glowshi_maps() abort
  if !exists('g:loaded_glowshi_ft')
    return
  endif
  for [lhs, plug] in [
        \ ['f', '(glowshi-ft-f)'],
        \ ['F', '(glowshi-ft-F)'],
        \ ['t', '(glowshi-ft-t)'],
        \ ['T', '(glowshi-ft-T)'],
        \ [',', '(glowshi-ft-opposite)'],
        \ ]
    silent! execute 'unmap' lhs
    execute 'noremap' lhs '<Plug>' . plug
  endfor
endfunction
augroup dotfiles_glowshi
  autocmd!
  autocmd VimEnter * call s:setup_glowshi_maps()
augroup END

" Prefer ripgrep for :Ack if available
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif






set nomodeline
set modelines=0


set nu
nnoremap / mq/
nnoremap ? mq?
nnoremap * mq*
nnoremap # mq#
              

" rebuild the tag file in the directory of the current source file
"nmap ,t :!(cd %:p:h;ctags *.[ch])&


" robot framework syntaxis:
" # -*- coding: robot -*-
" g:robot_syntax_for_txt

" Case insensitive search
set ic



" sets how many lines of history VIM has to remember
set history=700


" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" Highlight search results
set hlsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show indexing brackets when text indicator is over them 
set showmatch



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

"Be smart when using tabs ;)
set smarttab

"Auto indent
set ai

"1 tab == 4 spaces
set shiftwidth=4
"set tabstop=4
"show if file was externally edited

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful mappings for managing tabs
map <leader>tc :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tx :tabclose<cr>
map <leader>tp :tabprevious<cr>
map <leader>tn :tabnext<cr>
map <leader>tm :tabmove

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
 autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%

"    => Status line
"    Always show the status line
    set laststatus=2

"   Show full file path on status line
    set statusline+=%F  

"   Use clipboard buffer
    set clipboard+=unnamedplus


"Auto-reload .vimrc
"
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"F1-F12 mappings
"
nmap <F2> :TagbarToggle<CR> 
map <F3> :NERDTreeToggle <CR><Esc>
imap <F3> <Esc> :NERDTreeToggle <CR>a<Left>
map <F4> :set cursorcolumn! <CR><Esc>
map <F5> :set cursorline! <CR><Esc>
map <F6> :set spell! <CR><Esc>
map <F7> :Files<CR>
map <F8> :set hlsearch! <CR><Esc>
imap <F8> <Esc> :set hlsearch! <CR><Esc>a<Left>
" F9: reserved (AutoComplPop removed — use built-in completion or coc/lsp)
" map <F9> ...

map <F10> gg<CR><C-w><C-w>gg<CR>:set scrollbind<CR>:diffthis<CR><C-w><C-w>:set scrollbind<CR>:diffthis<CR>

" NERD_tree
"
set autoread
au CursorHold * checktime

" Visual mode
"
" clipboard
vmap <C-c> "+y
vmap <C-v> "+p

"vnoremap <C-c> "*y
"vnoremap <C-v> "*p

fixdel 
hi cursorline ctermbg=243




if &term=="xterm"
  set t_kb=<CTRL+V><BS>
  fixdel
endif


" Project tags (optional): set tags+=./tags;/opt/interface/tags
highlight Pmenu ctermfg=10 ctermbg=8 guibg=Magenta
highlight PmenuSel ctermfg=10
set autochdir


" Z - cd to recent / frequent directories
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
    let cmd = 'fasd -d -e printf'
    for arg in a:000
        let cmd = cmd . ' ' . arg
    endfor
    let path = system(cmd)
    if isdirectory(path)
        echo path
        exec 'cd ' . path
    endif
endfunction



"When joining lines, leave the cursor between joined lines
set cpoptions=q 

" ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png 

" Toggle paste mode
" (prefer this over 'pastetoggle' to echo current state)
nmap <leader>p :setlocal paste! paste?<cr>

set mouse=a
noremap j gj
noremap k gk

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>


cmap Q q
cmap W w


vmap <expr> <S-LEFT> DVB_Drag('left') 
vmap <expr> <S-RIGHT> DVB_Drag('right') 
vmap <expr> <S-DOWN> DVB_Drag('down') 
vmap <expr> <S-UP> DVB_Drag('up') 
let g:DVB_TrimWS = 1
"
"
""DRAGGING VISUAL BLOCK
"
"vnoremap K  xkP`[V`]
"vnoremap U  xp`[V`]
"vnoremap L  >gv
"vnoremap H  <gv


"toggles whether or not the current window is automatically zoomed
"function! ToggleMaxWins()
"        if exists('g:windowMax')
"            au! maxCurrWin
"            wincmd =
"            unlet g:windowMax
"        else
"            augroup maxCurrWin
"                " au BufEnter * wincmd _ | wincmd |
"                "
"                " only max it vertically
"                au! WinEnter * wincmd _
"            augroup END
"            do maxCurrWin WinEnter
"            let g:windowMax=1
"        endif
"    endfunction
"    nnoremap <Leader>= :call ToggleMaxWins()<CR>













"This function turns Rolodex Vim on or off for the current tab
"If turning off, it sets all windows to equal height
"function! ToggleRolodexTab()
"    if exists("t:rolodex_tab") > 0
"        unlet t:rolodex_tab
"        call ClearRolodexSettings()
"        execute "normal \<C-W>="
"    else
"        let t:rolodex_tab = 1
"        call SetRolodexSettings()
"    endif
"endfunction
" 
""This function clears the Rolodex Vim settings and restores the previous values
"function! ClearRolodexSettings()
"    "Assume if one exists they all will
"    if exists("g:remember_ea") > 0
"        let &equalalways=g:remember_ea
"        let &winheight=g:remember_wh
"        let &winminheight=g:remember_wmh
"        let &helpheight=g:remember_hh
"    endif
"endfunction
" 
""This function set the Rolodex Vim settings and remembers the previous values for later
"function! SetRolodexSettings()
"    if exists("t:rolodex_tab") > 0
"        let g:remember_ea=&equalalways
"        let g:remember_wh=&winheight
"        let g:remember_wmh=&winminheight
"        let g:remember_hh=&helpheight
"        set noequalalways winminheight=0 winheight=9999 helpheight=9999
"    endif
"endfunction
" 
""These two autocmds make Vim change the settings whenever a new tab is selected
""We have to use TabLeave to always clear them.  If we try and turn them off
""in TabEnter, it is too late ( I think, since WinEnter has already been called and triggered the display)
"au TabLeave * call ClearRolodexSettings()
"au TabEnter * call SetRolodexSettings()
" 
""With this mapping, F2 toggles a tab to be Rolodex style
"noremap <Leader>= :call ToggleRolodexTab()<CR>



set wildmenu
set wildmode=full
set clipboard=unnamedplus


command! WQ wq
command! Wq wq
command! W w
command! Q q

set matchpairs+=<:>
set hidden
set diffopt+=iwhite

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax



set shortmess+=I

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

nnoremap <Leader>ev :vsplit $MYVIMRC<Cr>
nnoremap <Leader>ez :vsplit ~/.zshrc<Cr>
nnoremap <Leader>et :vsplit ~/.tmux.conf<Cr>
nnoremap <Leader>so :source $MYVIMRC<Cr>


set tabpagemax=100
set nowrap
onoremap in( :<c-u>normal! f(vi(<cr>)))



nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
noremap <Space>e :QuickhlManualReset<cr>

  nnoremap di" di"<left>m" 
  nnoremap di' di'<left>m' 
  nnoremap dib f(dib<left>mb 
  nnoremap diib F(dib<left>mb 



  " toggle between number and relative number on ,l
  nnoremap <leader>l :set relativenumber!<CR>
nnoremap Q <nop>

function! HighlightNearCursor()
   match Todo /\k*\%#\k*/
      let s:highlightcursor=1
      endfunction


set virtualedit=block
"set shell=zsh\ -l
"nmap <leader>w w!<cr>
"
"
nnoremap gp `[v`]`
set wildignorecase
set omnifunc=syntaxcomplete#Complete

map <Leader>vp :VimuxPromptCommand<CR>

map H <Plug>(operator-quickhl-manual-this-motion)
colorscheme 256-jungle

nnoremap <silent> c-h :TmuxNavigateLeft<cr>
nnoremap <silent> c-j :TmuxNavigateDown<cr>
nnoremap <silent> c-k :TmuxNavigateUp<cr>
nnoremap <silent> c-l :TmuxNavigateRight<cr>
"nnoremap <silent>  :TmuxNavigatePrevious<cr>
inoremap jj <esc>l


set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo "

"Print current path
cmap <C-e> <C-r>=expand('%:p:h')<CR>/


set splitbelow        " new hoz splits go below
set splitright        " new vert splits go right "

map ; :

 function! DeleteInnerBlock()
 	  
 	 let columnNum = virtcol('.')
 	 normal di(
 	 let charUnderCursor = matchstr(getline('.'), '\%' . col('.') . 'c.')
 	 if charUnderCursor != ")"
 	 	 normal f(<cr>
 	 	 normal di(
 	 	  
 	 	 if columnNum == virtcol('.')
 	 	 	 normal F(<cr>
 	 	 	 normal di(
 	 	 endif
 	 endif
 endfunction
  
 map dib :call DeleteInnerBlock() <cr>
 map <leader><space> :nohlsearch<cr>


 highlight DiffAdd cterm=none ctermfg=Black ctermbg=Green gui=none guifg=fg guibg=Blue
 highlight DiffDelete cterm=none ctermfg=Black ctermbg=Red gui=none guifg=fg guibg=Blue
 highlight DiffChange cterm=none ctermfg=Black ctermbg=Blue gui=none guifg=fg guibg=Blue
 highlight DiffText cterm=none ctermfg=Black ctermbg=Yellow gui=none guifg=bg guibg=White

 let g:mta_filetypes = {
     \ 'html' : 1,
     \ 'xhtml' : 1,
     \ 'xml' : 1,
     \ 'jinja' : 1,
     \ 'php' : 1,
     \}

 highlight MatchTag ctermfg=black ctermbg=white guifg=black guibg=white

 vmap <Enter> <Plug>(EasyAlign)


" glowshi-ft (mappings applied in s:setup_glowshi_maps after plugins load)
let g:glowshi_ft_selected_hl_link = 'White'
let g:glowshi_ft_candidates_hl_link = 'Black'
let g:glowshi_ft_timeoutlen = 99999
