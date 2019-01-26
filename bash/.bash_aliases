# Update and upgrade
alias update='sudo apt-get update && sudo apt-get upgrade'

# Untar
alias untar='tar -zxvf '

# Clear screen
alias c='clear'

# Change directory and list it
alias cdl='cd $1 && ls'

# Function for quick switching between websites on the server
www() {
    if [ -z $1 ]; then
        cd /srv/www
    else
        cd /srv/www/"$1"/public_html
    fi
}

