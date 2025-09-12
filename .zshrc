#CASE_SENSITIVE="false"

# You may need to manually set your language environment
#export LANG=en_US.UTF-8

#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
export EDITOR='nvim'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -v # vim mode
bindkey '^K' up-line-or-history # Ctrl + K → up in history
bindkey '^J' down-line-or-history # Ctrl + J → down in history
bindkey '^H' autosuggest-accept # Ctrl + H → accept autosuggestion
bindkey '^D' down-line-or-history # Ctrl + D → next command
bindkey '^F' up-line-or-history # Ctrl + F → previous command

# Aliases
alias "cd"="z"
alias "l"="eza --icons -lha"
alias "ls"="eza --icons -g"
alias "la"="eza --icons -la"
alias "ll"="eza --icons -l"
#alias "cat"="bat"
alias "vi"="nvim"
alias "nixc"="sudoedit /etc/nixos/configuration.nix"
alias "nixr"="sudo nixos-rebuild switch"
alias "zshrc"="nvim ~/.zshrc"

export KEYTIMEOUT=1
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# _fix_cursor() {
#    echo -ne '\e[5 q'
# }
# precmd_functions+=(_fix_cursor)

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

path+=('/home/nixxer/.config/emacs/bin')
export PATH
