set nocompatible              " be iMproved, required
filetype off                  " required

" Automatically install Vundle is it doesnt exist
if !filereadable(expand("$HOME/.vim/bundle/Vundle.vim/README.md"))
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
    silent !vim +PluginInstall +qall
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()            " required
filetype plugin indent on    " required

" Vim native settings
set pastetoggle=<F2>
set number " Show gutter
set nowrap " don't wrap lines

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" NERDTree
autocmd vimenter * NERDTree " open a NERDTree automatically when vim starts up
autocmd vimenter * if !argc() | NERDTree | endif " open a NERDTree automatically when vim starts up if no files were specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "  close vim if the only window left open is a NERDTree
let NERDTreeShowHidden=1 " Show hidden files

" Syntastic
let g:syntastic_aggregate_errors = 1 "display together the errors found by all checkers enabled for the current file

" vim-airline
let g:airline_powerline_fonts = 1 " automatically populate the g:airline_symbols dictionary with the powerline symbols.
let g:airline#extensions#tabline#enabled = 1 "Automatically displays all buffers when there's only one tab open.

" vim-gitgutter
let g:gitgutter_diff_args = '-w' " Ignore whitespace on git diffs
let g:gitgutter_realtime = 1 "Turn to zero for performance
let g:gitgutter_eager = 1 " Turn to zero for performance
let g:gitgutter_sign_column_always = 1 " Always show the gutter

highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermbg=none
highlight GitGutterChange ctermbg=none
highlight GitGutterDelete ctermbg=none
highlight GitGutterChangeDelete ctermbg=none

