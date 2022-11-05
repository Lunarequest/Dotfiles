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

zi light-mode for z-shell/z-a-meta-plugins  @annexes \
 skip'zsh-fancy-completions' @z-shell \
 @zsh-users+fast \
 @ext-git \
 @rust-utils \
 @zsh-users+fast\
 @zsh-users \
 @fuzzy \
 @py-utils \
 skip'bat ripgrep' @console-tools
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
zi ice depth=1; zi light @romkatv
COMPLETION_WAITING_DOTS="true"

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
export CC=clang
export CXX=clang++
export COMMON_FLAGS="-O2 -flto=thin -fuse-ld=/usr/bin/ldd"


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
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# node stuff
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-; zprof > ~/zshprofile$(date +'%s')
fi