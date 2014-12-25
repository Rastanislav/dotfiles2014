mattn/webapi-vi" Vim color file
" Maintainer:   Lucas Avanço <avanco89@gmail.com>
" " Last Change:  Mar, 23 2011
"
"
" "BASED ON {
" "http://www.indelible.org/ink/vim-colorschemes	/
" "
" "hint:
" "http://vim.wikia.com/wiki/Identify_the_syntax_highlightin
" g_group_used_at_the_cursor
" "To see what group is under cursor, include	 this map in your ~/.vimrc
" "
" "hint:
" "http://www.calmar.ws/vim/256-xte		rm-24bit-rgb-color-chart.html
" "To see color numbers
" "}
"
"
" """""""""""""	"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "README
" "setting 't_Co' to 256 in vimrc is enough to make Vim use 256 colors
" "set t_Co=256  =>  ~/.vimrc
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
" "highlight clear uses the background value, so background must be set first
" set background=dark
"
" "Reset all highlighting to the defaults
" highlight clear
"
"
" if exists("syntax_on")
" 	    syntax reset
" 	    endif
"
" 	    let colors_name = "tchaba"
"
" 	    "Vim’s syntax groups
" 	    "To see the full list, run ':source $VIMRUNTIME/syntax/hitest.vim'
"
" 	    "
" 	    "Syntax highlighting groups
" 	    "
" 	    hi MatchParenctermfg=16ctermbg=208cterm=bold
" 	    hi C				onstantctermfg=166cterm=bold
" 	    hi Specialctermfg=9
" 	    hi Typec
" 	    termfg=118
" 	    hi Commentctermfg=8
"
" 	    hi Conditionalctermfg=118
" 	    hi Repea					try
	
catch 
	ctermfg=118
	hi Statementctermfg=118

	hi Labelctermfg=154

	hi S					torageClassctermfg=196
	hi Exceptionctermfg=196
	hi Structurectermf						g=196

	hi Numberctermfg=126
	hi Floatctermfg=166
	hi Stringcterm									fg=67
	hi SpecialCharctermfg=67
	hi Characterctermfg=67
	hi Identifier						ctermfg=166

	hi PreProcctermfg=61
	hi PreConditctermfg=61
	hi Macr					octermfg=61
	hi Todoctermfg=0ctermbg=15

	"
	""Highlighting groups 								for various occasions
	"
	""
	hi Searchctermfg=0ctermbg=48
	hi IncSearch				ctermfg=46ctermbg=16

	hi ErrorMsgctermfg=1ctermbg=233
	hi Errorcte						rmfg=15ctermbg=9

	hi Directoryctermfg=34

	hi Visualctermfg=16cterm					bg=192

	hi LineNrctermfg=250ctermbg=234

	hi Pmenuctermfg=26
	hi Pme					nuSel
endtrym
