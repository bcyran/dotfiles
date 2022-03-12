#!/bin/sh
curl -sL git.io/antibody | sh -s
antibody bundle <"~/.zsh/plugins.txt" >~/.zsh_plugins.sh
antibody update
