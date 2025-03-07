# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="refined"
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="random"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  colored-man-pages
  vi-mode
  bazel
)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Use and set LC_USER so that SSH prompts will be right
DEFAULT_USER=${LC_USER:-$USER}
unset LC_USER

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_VI_INSERT_MODE_STRING=""
POWERLEVEL9K_VI_COMMAND_MODE_STRING="NOR"

POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_ETC_ICON=''
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"

POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND='red'

POWERLEVEL9K_VCS_HIDE_TAGS=true

POWERLEVEL9K_STATUS_OK=false

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

# Multiline Prompt
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

local user_symbol="$"
    if [[ $(print -P "%#") =~ "#" ]]; then
        user_symbol = "#"
    fi

POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2570\U2500${user_symbol} "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs vi_mode background_jobs status command_execution_time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

[ -f ~/.fzf-keys.zsh ] && source ~/.fzf-keys.zsh
[ -f ~/.fzf-compl.zsh ] && source ~/.fzf-compl.zsh

[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases ]   && source ~/.aliases
[ -f ~/.exports ]   && source ~/.exports
[ -f ~/.localrc ]   && source ~/.localrc

# clean up exit code from above sources
:

. "$HOME/.cargo/env"

# Created by `pipx` on 2024-12-24 22:42:06
export PATH="$PATH:/Users/hunter/.local/bin"
