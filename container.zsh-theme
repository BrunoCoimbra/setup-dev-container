PROMPT='%(?:[:%{$fg[red]%}[%{$reset_color%})%n@%m %c%(?:]%#:%{$fg[red]%}]%#%{$reset_color%}) '
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}•%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

unset LSCOLORS
zstyle ':completion:*' list-colors
