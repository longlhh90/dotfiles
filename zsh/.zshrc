# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/go/bin:$HOME/go/bin:/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:$PATH

### ZSH HOME
export ZSH=$HOME/.config/zsh

### ---- history config -------------------------------------
export HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS


# plugins=(
#   git 
#   zsh-autosuggestions 
#   zsh-syntax-highlighting
#   vi-mode
# )

# Init Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

source $ZSH/.zsh_aliases
source $ZSH/.zsh_functions
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath=($ZSH/plugins/zsh-completions/src $fpath)

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

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

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lukas/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lukas/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lukas/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lukas/google-cloud-sdk/completion.zsh.inc'; fi


### configure go environment ###
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
if [ ! -f "$HOME/go/bin/gofumpt" ]; then
    go install mvdan.cc/gofumpt@latest
fi
if [ ! -f "$HOME/go/bin/revive" ]; then
    go install github.com/mgechev/revive@latest
fi

### end config go ###

# configure rust environment
#
# - rust-analyzer
#
source $HOME/.cargo/env
if ! command -v rust-analyzer &> /dev/null
then
  brew install rust-analyzer
fi
if ! cargo audit --version &> /dev/null; then
  cargo install cargo-audit --features=fix
fi
if ! cargo nextest --version &> /dev/null; then
  cargo install cargo-nextest
fi
if ! cargo fmt --version &> /dev/null; then
  rustup component add rustfmt
fi
if ! cargo clippy --version &> /dev/null; then
  rustup component add clippy
fi
if ! ls ~/.cargo/bin | grep 'cargo-upgrade' &> /dev/null; then
  cargo install cargo-edit
fi

function rust_update_tools {
  brew_update # called because of rust-analyzer
  rustup self update
  rustup update stable
  rustup component add rustfmt
  rustup component add clippy
  cargo install cargo-audit --features=fix
  cargo install cargo-nextest
  cargo install cargo-edit
  rustup update
}
