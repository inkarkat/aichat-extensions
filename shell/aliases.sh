#!/bin/sh source-this-script

# faichat	Include files and directories from standard input
#		in the AI chat.
faichat()
{
    linesToArgs --prefix --file= -- \
	aichat-wrapper {} "$@"
}

# aicode	AI chat that only outputs code.
alias aicode='aichat-wrapper --no-session --code'

# aititle	AI chat that summarized into a title.
alias aititle='aichat-wrapper --no-session --role %create-title%'

# Define shortcuts for all custom roles.
for _role in "${XDG_CONFIG_HOME:-${HOME}/.config}/aichat/roles"/*.md
do
    [ -r "$_role" ] || continue
    _role="${_role##*/}"; _role="${_role%.md}"
    alias "ai${_role}=aichat-wrapper --role $_role"
done
unset _role
