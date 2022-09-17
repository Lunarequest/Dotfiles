# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

local chsm_ok='7fab1ecb8d2ffbdb4aa98dd1e51cebaeaa4d8137e1de11938f3e0df24af262bb'
local chsm="$(command curl -fsL 'https://git.io/zi-loader' | sha256sum | awk '{print $1}')"
if [[ ${chsm_ok} == ${chsm} ]]; then
  source <(curl -sL https://git.io/zi-loader); zzinit
else
  print "network down";
  typeset -A ZI
  ZI[BIN_DIR]="${HOME}/.zi/bin"
  source "${ZI[BIN_DIR]}/zi.zsh"
fi

typeset -g HISTSIZE=290000 SAVEHIST=290000 HISTFILE=~/.zhistory

if type "any-nix-shell" > /dev/null; then
    any-nix-shell zsh --info-right | source /dev/stdin
fi

zi ice atinit'zmodload zsh/zprof'
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi
        
# Set compiler and compiler flags
export CC=clang
export CXX=clang++
export COMMON_FLAGS="-O2 -flto=thin -fuse-ld=/usr/bin/ldd"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export ZSH="~/.zsh"
export SSH_ASKPASS="$(which ksshaskpass)"
zi is-snippet wait lucid for \
  OMZP::{ssh-agent,gpg-agent,git}\
  if'[[ -f /etc/os-release ]] && source /etc/os-release && [[ "$ID" = arch ]]'\
    OMZP::archlinux\
  has'pip' \
    OMZP::pip \
  has'python' \
    OMZP::python

zi light-mode for z-shell/z-a-meta-plugins @annexes \
 @z-shell \
 @ext-git \
 @rust-utils \
 @zsh-users+fast\
 @fuzzy \
 @py-utils \
 skip'bat ripgrep' @console-tools
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
zi ice depth=1; zi light @romkatv
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zi light bilelmoussaoui/flatpak-zsh-completion
zi ice blockf
zi snippet OMZL::clipboard.zsh
zi snippet OMZL::termsupport.zsh
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# export GPG_TTY=$(tty) # hack to fix gpg issues
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export VISUAL=nvim
export EDITOR=nvim

export PATH="$PATH:/usr/local/bin"
if ! type "yarn" > /dev/null; then
  export PATH="$PATH:$HOME/.cargo/bin/:$HOME/.local/bin"
else
  export PATH="$PATH:$HOME/.cargo/bin/:$(yarn global bin):$HOME/.local/bin"
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

alias cls="clear"
alias kate='kstart5 kate'
alias ip="ip -c"
alias update_all="rpm-ostree update && flatpak update && rustup upgrade"
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# node stuff
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-; zprof > ~/zshprofile$(date +'%s')
fi