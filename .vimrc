  	set nocompatible               " Be iMproved

  	set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on
"startup,
" this will conveniently prompt you to install
"them.
"
NeoBundleLazy "junegunn/fzf"
NeoBundle "chrisbra/vim-diff-enhanced"
NeoBundle "ryanoasis/vim-devicons"
NeoBundle "saihoooooooo/glowshi-ft.vim"
NeoBundle "oblitum/rainbow"
NeoBundle "tpope/vim-surround"
NeoBundle "scrooloose/nerdtree"
NeoBundle "yegappan/mru"
NeoBundle "majutsushi/tagbar"
NeoBundle "tpope/vim-fugitive"
NeoBundle "junegunn/vim-easy-align"
NeoBundle "Lokaltog/powerline"
NeoBundle "kshenoy/vim-signature"
NeoBundle 'mileszs/ack.vim'
NeoBundle "godlygeek/tabular"
NeoBundle "vim-scripts/Mark--Karkat"
NeoBundle "bling/vim-airline"
NeoBundle "benmills/vimux"
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle "garbas/vim-snipmate"
NeoBundle "honza/vim-snippets"
NeoBundle "Townk/vim-autoclose"
NeoBundle "junegunn/goyo.vim"
NeoBundle "mattn/gist-vim"
NeoBundle "mattn/webapi-vim"
NeoBundle "t9md/vim-quickhl"
NeoBundle "scrooloose/nerdcommenter"
NeoBundle "shinokada/dragvisuals.vim"
NeoBundle "christoomey/vim-tmux-navigator"
NeoBundle "vim-scripts/ccase.vim"
NeoBundle "mhinz/vim-startify"
NeoBundle "krisajenkins/vim-pipe"
NeoBundle "tmhedberg/matchit"
NeoBundle "valloric/MatchTagAlways"
NeoBundleCheck






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



" PATHOGEN
"
"execute pathogen#infect()
""generate helptags for everything in Ã¢â‚¬ËœruntimepathÃ¢â‚¬â„¢
"call pathogen#helptags()
"filetype plugin indent on


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

nnoremap <C-Left>b 
nnoremap <C-Right>w 

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


" Show full file path on status line
set statusline+=%F  


"Auto-reload .vimrc
"
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"SHIT! powerline still doesn't work
"


let g:Powerline_symbols = 'fancy'
set nocompatible 


"Study
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn


"F1-F12 mappings
"
nmap <F2> :TagbarToggle<CR> 
map <F3> :NERDTreeToggle <CR><Esc>
imap <F3> <Esc> :NERDTreeToggle <CR>a<Left>
map <F4> :set cursorcolumn! <CR><Esc>
map <F5> :set cursorline! <CR><Esc>
map <F6> :set spell! <CR><Esc>
map <F7> :FufFile <CR><Esc>
map <F8> :set hlsearch! <CR><Esc>
imap <F8> <Esc> :set hlsearch! <CR><Esc>a<Left>
map <F9> :AutoComplPopDisable <CR><Esc>
imap <F9> <Esc>:AutoComplPopDisable <CR><Esc>a<Left>

map <F10> gg<CR><C-w><C-w>gg<CR>:set scrollbind<CR>:diffthis<CR><C-w><C-w>:set scrollbind<CR>:diffthis<CR>

"nnoremap <F9> :call ToggleAutoCompl()<cr>
"
"function" FoldColumnToggle()
"    if &foldcolumn
"        setlocal foldcolumn=0
"    else
"        setlocal foldcolumn=4
"    endif
"endfunction

" Airline
"""""""""""""
"map <C-Enter> :set hlsearch! <CR><Esc>


"Enable airline plugins

"let g:airline_enable_fugitive=1
"let g:airline_enable_syntastic=1
"let g:airline_enable_bufferline=1
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#enabled = 1
""Change symbols
"
"let g:airline_left_sep = 'Ã¢â€“Â¶'
"let g:airline_right_sep = 'Ã¢â€”â‚¬'
"let g:airline_linecolumn_prefix = 'Ã‚Â¶ '
"let g:airline_fugitive_prefix = 'Ã¢Å½â€¡ '
"let g:airline_paste_symbol = 'ÃÂ' 


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


set tags=/opt/interface/tags
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


"vmap <expr> <LEFT> DVB_Drag('left')
"vmap <expr> <RIGHT> DVB_Drag('right')
"vmap <expr> <DOWN> DVB_Drag('down')
"vmap <expr> <UP> DVB_Drag('up')
"vmap <expr> D DVB_Duplicate('left')
"
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

 nmap <leader>i :silent! w! ~/clearmake.txt <CR>
set matchpairs+=<:>
set hidden
set diffopt+=iwhite

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax



set makeprg=clearmake
set shortmess+=I
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

nmap <Leader>z :on<CR>
nmap <Leader>a :vnew<CR><Esc> b1<CR>
"nmap <Leader>a :vnew<CR><Esc>:b1<CR>
"
"
"autocmd BufEnter * :TagbarOpen



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

"   autocmd BufEnter * :call rainbow_parenthsis#LoadSquare()
"   autocmd BufEnter * :call rainbow_parenthsis#LoadRound()
"   autocmd BufEnter * :call rainbow_parenthsis#LoadBraces()
"   autocmd BufEnter * :call rainbow_parenthsis#Activate()
"   nnoremap <leader><space> :nohl<cr> :match None<cr>



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
filetype plugin on 
set omnifunc=syntaxcomplete#Complete

map <Leader>vp :VimuxPromptCommand<CR>




nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)



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


let g:glowshi_ft_no_default_key_mappings = s:true
map f <plug>(glowshi-ft-f)
map F <plug>(glowshi-ft-F)
map t <plug>(glowshi-ft-t)
map T <plug>(glowshi-ft-T)
map , <plug>(glowshi-ft-opposite)

" highlight
let g:glowshi_ft_selected_hl_link = 'White'
let g:glowshi_ft_candidates_hl_link = 'Black'



" timeout
let g:glowshi_ft_timeoutlen = 99999
