# Ubuntu's default .bashrc aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable aliases when using sudo
alias sudo='sudo '

# Update and upgrade
alias update='sudo apt update && sudo apt upgrade'

# Clear screen
alias c='clear'

# Clear and return to home
alias cc='cd && c'

# Extract various archives
function extract(){
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
        	*.tar.gz)    tar xvzf $1    ;;
			*.tar.xz)	 tar xvJf $1	;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
        	*)           echo "Unable to extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Change directory and list it
function cdl() {
	cd "$@" && ls
}

# Create directory and open it
function mkc() {
	mkdir "$@" && cd "$@"
}

# Function for quick switching between websites on the server
function www() {
    if [ -z $1 ]; then
        cd /srv/www
    else 
    	cd /srv/www/$1/public_html
    fi
}

