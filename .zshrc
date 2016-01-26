# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

export LANG=ja_JP.UTF-8
autoload colors
colors
setopt auto_cd # ディレクトリ名の入力のみで移動する
setopt nobeep
setopt correct # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify # バックグラウンドジョブの状態変化を即時報告する
setopt equals # =commandを`which command`と同じ処理にする


# export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
# export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
# zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 100000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
setopt auto_list
setopt list_types
setopt list_packed
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# ibus settings
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# eclipse for arm setting
path=($HOME/bin/Eclipse/eclipse(N-/) $path)

# MATLAB
path=(/usr/local/MATLAB/R2015a/bin/ $path)

# ranger
function r() {
    if [ -z "$RANGER_LEVEL" ]; then
        ranger $@
    else
        exit
    fi
}

# Z
# 'j' to use "Z" which is replacement tool for "cd"
_Z_CMD=j
source ~/.zsh/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

# auto-fu.zsh
if [ -f ~/.zsh/auto-fu.zsh ]; then
    source ~/.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi

# Command Line Stack
# TODO: cannot work
# Esc-q : stack
# Esc-h : pop
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack

# zsh-prompt
source /home/nonoho/git/zsh-git-prompt/zshrc.sh


PROMPT='%B%F{white}%K{blue}%n@%m%k%f %F{green}%~%f%b
 %# '


# emacsview
# http://qiita.com/arcizan/items/45f962caba9a73cece99
function emacsview(){
    emacsclient -n =(<&0)
}


alias ls='ls --color -p -a'
alias l='ls --color -p -a'
path=(/usr/share/pear/ $path)
path=(/usr/share/pear/bin/ $path)
path=(/usr/share/gnurx_v15.02_elf-1/bin/ $path)

path=(/home/nonoho/git/llvm_build/lib/ $path)
