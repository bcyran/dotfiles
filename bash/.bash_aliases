# Change directory and list it
function cdls() {
	cd "$@" && ls;
}

# Shortcut for cdls
alias cdl='cdls'
