#=============================
# @author: Shashank Singh
# Theme: Tokyonight
#=============================

# ========================
# General Configuration
# ========================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Standard prompt
PS1='[\u@\h \W]\$ '

# ========================
# Aliases
# ========================

# Tools & scripts
alias grep='grep --color=auto'
alias v=/usr/bin/nvim
alias sv='sudo /usr/bin/nvim'
alias config='/usr/bin/git --git-dir=$HOME/Workspace/Repos/DotFiles --work-tree=$HOME'
alias inscrybe='~/Workspace/Repos/Projects/Scripts/inscrybe.sh'
alias st='speedtest++ --progress=yes'
alias run='~/Workspace/Repos/Projects/Scripts/run.sh'
alias anaconda='source ~/.conda.bashrc'

# Navigating backwards
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Replace `ls` with `eza`
alias ls='eza --icons'
alias ll='eza -l --git --icons'
alias la='eza -la --git --icons'
alias lt='eza -la --git --icons --tree'

# ========================
# Initializing Programs
# ========================

# Initialize starship prompt for bash
eval "$(starship init bash)"

export PATH=$PATH:/home/honey/.spicetify

# ========================
# Environment Variables
# ========================

# Java (JDK 21 LTS)
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Gradle
export GRADLE_HOME=/usr/share/java/gradle
export PATH=$GRADLE_HOME/bin:$PATH

# Default editor
export EDITOR=/usr/bin/nvim

# SSH Authentication Socket
export SSH_AUTH_SOCK=/run/user/1000/gcr/ssh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
