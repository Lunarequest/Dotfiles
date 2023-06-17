# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

local cs_ok='23a563e80249a866c7cba3ac44eaedb1ca38f20c35690fb764a7cb75e95d38be'
local cs_get=$(sha256sum <(curl -sL init.zshell.dev) | awk '{print $1}')
[[ $cs_ok == $cs_get ]] && { source <(curl -sL init.zshell.dev); zzinit; } || {
  typeset -A ZI
  ZI[BIN_DIR]="${HOME}/.zi/bin"
  source "${ZI[BIN_DIR]}/zi.zsh"
}
unset cs_ok cs_get

typeset -g HISTSIZE=290000 SAVEHIST=290000 HISTFILE=~/.zhistory


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export ZSH="~/.zsh"
export SSH_ASKPASS="$(which ksshaskpass)"
zi is-snippet wait lucid for \
  atload"unalias grv g" \
  OMZP::git \
  OMZP::archlinux \
    if'[[ -d ~/.nvm ]]' \
  OMZP::nvm \
    if'[[ -d ~/.ssh ]]' \
  OMZP::ssh-agent \
    if'[[ -d ~/.gnupg ]]' \
  OMZP::gpg-agent

zi pack for ls_colors
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
zi snippet OMZL::functions.zsh
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

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.zi/plugins/rust-toolchain/bin:$HOME/.local/bin"
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export CC=clang
export CXX=clang++
export LINKCC=clang
export COMMON_FLAGS="-march=tigerlake -mtune=tigerlake -O3 -pipe -fomit-frame-pointer -D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -fstack-clash-protection -fcf-protection"
export LDFLAGS="-fuse-ld=lld -Wl,-z,defs -Wl,-z,now -Wl,-z,relro"
export CFLAGS="${COMMON_FLAGS}"
export CXXFLAGS="${COMMON_FLAGS}"
export PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto=thin --enable-ipv6 --with-pkg-config=yes --with-system-expat --with-system-libmpdec"

# Example aliases

alias cls="clear"
alias ip="ip -c"
alias ls="exa --icons --color=auto"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias zshconfig="kate ~/.zshrc"
alias iosc="osc -A https://api.suse.de"
alias oscb="osc build --ccache"
alias oscsd="osc service runall download_files"

if [ "$TERM" = "xterm-kitty" ]; then 
  alias ssh="kitty +kitten ssh"
  alias diff="kitty +kitten diff"
fi
# node stuff
export PATH="$HOME/.yarn/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(rtx activate zsh)"

# Wasmer
export WASMER_DIR="/home/luna/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
