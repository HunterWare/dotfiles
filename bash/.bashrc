# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# Set the terminal titles and prompt
if [ ! -z "$TERM" ]; then
    case $TERM in
        xterm*)
            PS1="\[\033]0;\h:\w\007\]"
            ;;
        screen*)
            PS1="\[\033]0;\h:\w\033"
            ;;
        *)
            PS1=""
            ;;
    esac
    if [ "$TERM" != "dumb" ]; then
        export PS1="${PS1}\[\033[38;5;2m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]"
        export PS1="${PS1}\[\033[38;5;4m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"
    fi
fi

set savehist = 20000
set correct=all
set autocorrect
set autolist = true

[ -f ~/.fzf-compl.bash ] && source ~/.fzf-compl.bash
[ -f ~/.fzf-keys.bash ]  && source ~/.fzf-keys.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.exports ] && source ~/.exports

[ -f ~/.localrc ] && source ~/.localrc

# If you have zsh, run it. Set SHELL properly. If bash was given -c blah then pass blah along
if [ -x "$(command -v zsh)" ] && [ ! -z "$DO_ZSH" ]; then
    ZSH_SHELL=`which zsh`
    if [ -z "$BASH_EXECUTION_STRING" ]; then
        SHELL=${ZSH_SHELL} exec zsh -l
    else
        SHELL=${ZSH_SHELL} exec zsh -lc "${BASH_EXECUTION_STRING}"
    fi
fi
