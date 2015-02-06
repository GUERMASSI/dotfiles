export WORKON_HOME=/home/giovanni/Projets/python_envs
source /etc/bash_completion
# source /home/giovanni/.bash_completion.d/python-argcomplete.sh
shopt -s histappend
export HISTSIZE=10000
PROMPT_COMMAND='history -a; history -n'

if [ "$TERM" != "dumb" ]; then
    [ -e "$HOME/.dir_colors" ] &&
    DIR_COLORS="$HOME/.dir_colors" [ -e "$DIR_COLORS" ] ||
    DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
    alias ls='ls --color=auto'
fi

alias la='ls -Fa'
alias ll='ls -Fls'
alias cdve='cd $VIRTUAL_ENV'
alias ag="LESS='FSRX' ag --pager less"
# Apply latest patch in ~/tmp/
alias hgpl="ls -d -t ~/tmp/* | grep .*diff | head -n 1;ls -d -t ~/tmp/* | grep .*diff | head -n 1 | xargs cat | hg patch --no-commit -"

DEFAULT="[37;1m"
PINK="[35;1m"
GREEN="[32;1m"
ORANGE="[33;1m"
BLUE="[36;1m"
RED="[31;1m"
BOLD="[1m"
OFF="[m"

hg_ps1_1() {
    hg prompt "{branch}" 2> /dev/null
}
hg_ps1_2() {
    hg prompt "{status}" 2> /dev/null
}

export PS1='\[\e${BOLD}\e${RED}\]\w \[\e${GREEN}\]$(hg_ps1_1) \[\e${BLUE}\]$(hg_ps1_2)\[\e${DEFAULT}\e${OFF}\]\n\[\e${BOLD}\e${PINK}\]\u\[\e${DEFAULT}\e${OFF}\]@\[\e${BOLD}\e${ORANGE}\]\h\[\e${DEFAULT}\e${OFF}\] \[\e${BOLD}\e${RED}\]$ \[\e${DEFAULT}\e${OFF}\] '
export EDITOR=vim

set -o vi
source ~/.fzf.bash
