# Yay! High voltage and arrows!

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=""
#
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%} !%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓%{$reset_color%}"



ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"

#PROMPT="%{$fg[blue]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%0~%{$reset_color%}"$'\n'"➤%{$reset_color%} "
PROMPT="%{$fg[blue]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%0~"$'\n'"➤%{$reset_color%} "
RPROMPT='%{$reset_color%}$(git_prompt_info)'

