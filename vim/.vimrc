" An example for a vimrc file.一般设置cli相关设置，即命令行相关设置，插件相关设置。原因加载顺序是先读取vimrc配置，然后读取plugin插件，然后加载GUI，最后再读取gvimrc配置文件。所以，GUI以及快捷键一般放到gvimrc里设置，有时候在vimrc设置跟界面显示相关的没作用，要在gvimrc里设置才有用。vimrc配置是vim，gvimrc配置文件是gvim，如果想要vim也有配色等，可以将界面相关的设置放在vimrc文件里重新设置一下。

"-------------------------------------------------------------------------------
"基本设置
"-------------------------------------------------------------------------------
set nocompatible                                                    "启用Vim的特性，而不是Vi的（必须放到配置的最前边）

"nvim相关基本配置---begin
" 开启 NVIM 专用选项
if has('nvim')
  " 允许真彩显示
  "let $NVIM_TUI_ENABLE_TRUE_COLOR = 0
  "set termguicolors
  " 允许光标变化,insert时变成|,normal时为方块
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" 插入模式自动补全标签显示更多信息
set showfulltag
"nvim相关基本配置---end


set encoding=utf-8                                                  " 设置编码
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5

"set cursorline                                                      "光标所在行设置下划线

set autoread                                                        "文件在vim之外改动过后，会被自动载入

set number                                                          "显示行号

"set lines=70 columns=200                                           "设置默认打开窗口大小

"set transparency=10                                                "设置窗口透明度

set guioptions=aAce                                                 "隐藏工具栏和滑动条

"设置标签栏
"最多30个标签
set tabpagemax=30
"显示标签栏
set showtabline=2
"显示状态栏
set laststatus=2

"设定文件浏览器目录为当前目录
"set bsdir=buffer
"set autochdir

"保存100条命令历史记录
set history=100

"总是在窗口右下角显示光标的位置
set ruler

"在Vim窗口右下角显示未完成的命令
set showcmd

" 启用鼠标
if has('mouse')
  set mouse=a
endif

"设置语法高亮
if &t_Co > 2 || has("gui_running")
  syntax on
endif

"shift模式
"if has("gui_macvim")
"  let macvim_hig_shift_movement = 1
"endif
"
"设置备份文件目录
set backupdir=/Users/jiangye/Documents/temp
"设置临时文件目录
set directory=/Users/jiangye/Documents/temp
"设置代码折叠
set foldmethod=manual

" our <leader> will be the space key
let mapleader=" "

" our <localleader> will be the '-' key
let maplocalleader="-"


"-------------------------------------------------------------------------------
"文本操作设置
"-------------------------------------------------------------------------------
"设置字体
set gfn=Monaco:h16


"设置自动缩进
"设置智能缩进
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab


"设置Tab键跟行尾符显示出来
"set list lcs=tab:>-,trail:-
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

"设置不自动换行
set nowrap

"设置Insert模式和Normal模式下Left和Right箭头键左右移动可以超出当前行
set whichwrap=b,s,<,>,[,]

"设置光标移动到屏幕之外时，自动向右滚动1个字符,并多显示3个字符
set sidescroll=1
set sidescrolloff=3

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=8

"设置使~命令成为操作符命令，从而使~命令可以跟光标移动命令组合使用
set tildeop

"在Insert模式下，设置Backspace键如何删除光标前边的字符。这里三个值分别表示空白字符，分行符和插入模式之前的字符。
set backspace=indent,eol,start

"定义键映射，不使用Q命令启动Ex模式，令Q命令完成gq命令的功能---即文本格式化。
map Q gq

" CTRL-U 在Insert模式下可以删除当前光标所在行所在列之前的所有字符.  Insert模式下，在Enter换行之后，可以立即使用CTRL-U命令删除换行符。
inoremap <C-U> <C-G>u<C-U>

"使 "p" 命令在Visual模式下用拷贝的字符覆盖被选中的字符。
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

"对齐线背景色
":hi colorcolumn guibg=Dimgray
:hi colorcolumn ctermbg=DarkGreen guibg=DarkGreen


" Split fast
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>

"<Leader>t 输入当前时间
imap <silent><leader>p <c-r>=strftime('%c')<cr>

"<leader>t 自动输入当前日期
imap <silent><leader>d <c-r>=strftime('%Y-%m-%d')<cr>

"<Leader>空格 删除行尾空格
nmap <leader><space> :%s/\s\+$//<CR>:let @/=''<CR>

"<Leader>w 快速切换折行
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

" phycical line 和 screen line 操作一致
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$


"-------------------------------------------------------------------------------
"搜索设置
"-------------------------------------------------------------------------------
"打开搜索高亮
set hlsearch

"忽略大小写
set ignorecase

"在查找时输入字符过程中就高亮显示匹配点。然后回车跳到该匹配点。
set incsearch

"设置查找到文件尾部后折返开头或查找到开头后折返尾部。
set wrapscan

"-------------------------------------------------------------------------------
"文件设置
"-------------------------------------------------------------------------------

"设置当Vim覆盖一个文件的时候保持一个备份文件，但vms除外（vms会自动备份。备份文件的名称是在原来的文件名上加上 "~" 字符
if has("vms")
  set nobackup
else
  set backup
endif

if has("autocmd")
  "启用文件类型检测并启用文件类型相关插件，不同类型的文件需要不同的插件支持，同时加载缩进设置文件, 用于自动根据语言特点自动缩进.
  filetype plugin indent on

  "将下面脚本命令放到自动命令分组里，这样可以很方便地删除这些命令.
"  augroup vimrcEx
"  au! "删除原来组的自动命令

  "对于所有文件类型，设置textwidth为78个字符.
 " autocmd FileType text setlocal textwidth=78

"vim启动后自动打开NerdTree
"  autocmd vimenter * NERDTree
"  autocmd vimenter * if !argc() | NERDTree | endif
"  "设置关闭vim NerdTree窗口
"  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  "当打开编辑文件时总是自动执行该脚本，跳转到最后一个有效的光标位置Mark标记。当一个事件正在处理时，不执行该脚本命令。
  "行首的反斜杠用于把所有语句连接成一行，避免一行写得太长. 
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  "Enter换行时总是使用与前一行的缩进等自动缩进。
  set autoindent
  "设置智能缩进
  set smartindent
endif


"编辑一个文件时，你所编辑的内容没保存的情况下，可以把现在的文件内容与编辑之前的文件内容进行对比，不同的内容将高亮显示
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif


"-------------------------------------------------------------------------------
"插件设置
"-------------------------------------------------------------------------------
"plug的配置
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/autoload/
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/bundle')



"文本按字符对齐,  如选中需要对齐的代码，然后输入 :Tab/=  可以让代码在=两边对齐
Plug 'godlygeek/tabular'

"markdown语法高亮
Plug 'plasticboy/vim-markdown'
"打开markdown文件时自动打开浏览器预览，npm支持
Plug 'suan/vim-instant-markdown'

"同样也可以看buffers，这样同时可以取代'jlanzarotta/bufexplorer' 
"热键C-p 呼出
"呼出后C-b,C-f 切换模式
" https://github.com/kien/ctrlp.vim
Plug 'kien/ctrlp.vim'
" 默认使用混合模式
let g:ctrlp_cmd = 'CtrlPMixed'


" ------------------------------------------------------------
" 智能补全
Plug 'Valloric/YouCompleteMe'
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)

"代码搜索
Plug 'mileszs/ack.vim'
"如果有ag，使用ag进行搜索,需要先安装the_silver_searcher：brew install the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"默认不跳转到第一条
cnoreabbrev Ack Ack!
"映射快捷命令
nnoremap <Leader>a :Ack!<Space>


" 代码格式化
" 热键 F3
Plug 'Chiel92/vim-autoformat'
"格式化时处理行尾空格
let g:autoformat_remove_trailing_spaces = 0
noremap <F3> :Autoformat<CR><CR>

"tags相关插件，ctags生成tag，taglist列出tag
Plug 'ctags.vim'
Plug 'taglist.vim'
nmap <F7> :Tlist<CR>
" tags 管理
" 热键 F8
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;/

" 语法检测
Plug 'scrooloose/syntastic'
let g:syntastic_rst_checkers = ['rstcheck']
let g:syntastic_html_tidy_ignore_errors = [
      \"trimming empty",
      \"is not recognized!",
      \"discarding unexpected",
      \"proprietary attribute \"ng-",
      \"proprietary attribute \"is-",
      \"proprietary attribute \"dropdown",
      \"<input> proprietary attribute \"autocomplete\"",
      \"<textarea> proprietary attribute \"placeholder\"",
      \"proprietary attribute \"role\"",
      \"proprietary attribute \"hidden\"",
      \"attribute \"href\" lacks value",
      \]


"窗口管理插件   :WMToggle
Plug 'winmanager'
noremap <F10> :WMToggle<CR><CR>
"注释  gcc
Plug 'tomtom/tcomment_vim'

"状态栏增强插件  ok
"Plug 'Lokaltog/vim-powerline'
"let g:Powerline_stl_path_style = 'full'

"如果要使用fancy , 需要先添加字体 -> git clone git://gist.github.com/1630581.git ~/.fonts/ttf-dejavu-powerline
"let g:Powerline_symbols = 'fancy'
"另一个状态栏增强插件
Plug 'vim-airline/vim-airline'
"使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
"开启tabline
let g:airline#extensions#tabline#enabled = 1
"tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
"tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
"tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'

"设置consolas字体"前面已经设置过
"set guifont=Consolas\ for\ Powerline\ FixedD:h11

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " old vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

"映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
"映射<leader>num到num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>



Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='molokai'

" Git，Git 管理
Plug 'tpope/vim-fugitive'

"匹配成对的括号，键入% 后可跳转到对应的括号
Plug 'matchit.zip'
"matchit 的字符匹配自定义设置
let b:match_words = '\<if\>:\<endif\>,'
    \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'

"语法高亮
Plug 'othree/html5.vim'
Plug 'python-syntax'
let python_highlight_all = 1
" Plugin 'JavaScript-syntax'

" JSON 高亮
Plug 'elzr/vim-json'
let g:indentLine_noConcealCursor=""

" angularjs
Plug 'burnettk/vim-angular'


"括号增强  ok 这个插件设置后，后面不能再设syntax enabled这样的语句
"否则，有可能会使部分括号的彩虹效果消失
Plug 'kien/rainbow_parentheses.vim'
syntax enable
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle              "开启彩虹括号
au Syntax * RainbowParenthesesLoadRound             "小括号显示彩虹效果
au Syntax * RainbowParenthesesLoadSquare            "中括号
au Syntax * RainbowParenthesesLoadBraces            "大括号

"Sphinx增强插件  ok
Plug 'Rykka/riv.vim'
let g:riv_disable_folding = 1                       "不开启折叠
let g:riv_fold_auto_update = 0                      "不开启自动折叠
"Sphinx所见即所得插件
Plug 'Rykka/InstantRst'
let g:instant_rst_slow = 1                          "机子较慢的情况使用
let g:instant_rst_bind_scroll = 0                   "不绑定滚动，这样不会动一下光标就刷一次

"grep搜索插件
Plug 'vim-scripts/EasyGrep'

"目录树插件  ok
Plug 'https://github.com/scrooloose/nerdtree.git'
nmap <F9> :NERDTreeToggle<CR>

"缩进插件    ok
"Bundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1      "打开vim就启动
"let g:indent_guides_auto_colors = 0                "自定义颜色
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"let g:indent_guides_guide_size = 1                   "缩进线的尺寸

"另一种缩进插件
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'

"用vim7.3的标尺功能，显示第80列
set cc=80
"缩进插件的增强方法,按下,ch可以高亮当前列，再按,ch取消
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

"主题  ok
"solarized主题
"Bundle 'altercation/vim-colors-solarized'
"let g:solarized_termcolors = 256
"let g:solarized_termtrans = 1
"let g:solarized_contrast = "normal"
"let g:solarized_visibility = "normal""
"molokai主题
Plug 'tomasr/molokai'
"let g:molokai_original = 1
"moria主题
"Bundle 'moria'

Plug 'flazz/vim-colorschemes'

" 配色方案
set background=dark
set t_Co=256
"下面这块可能要在gvim.rc里配置
if has('gui_running')
    "colorscheme solarized
    "colorscheme moria
    colorscheme molokai
    "colorscheme phd
  else
    "colorscheme solarized
    colorscheme molokai
    "colorscheme desert
endif

"vim启动后，直接设置配色方案为molokai
"autocmd vimenter * :colorscheme molokai

call plug#end()


filetype plugin indent on     " required!
