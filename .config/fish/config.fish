if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
alias ls="lsd"
alias nv="nvim"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
