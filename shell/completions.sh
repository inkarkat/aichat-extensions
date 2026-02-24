#!/bin/bash source-this-script

_aichatEx()
{
    local IFS=$'\n'
    typeset -a aliases=(); readarray -t aliases < <(compgen -A command -- 'aichat-')
    aliases=("${aliases[@]/#aichat-/}")

    if [ $COMP_CWORD -ge 2 ] && contains "${COMP_WORDS[1]}" "${aliases[@]}"; then
	local aichatAlias="_aichat_${COMP_WORDS[1]//-/_}"
	# Completing an alias; delegate to its custom completion function (if
	# available)
	if type -t "$aichatAlias" >/dev/null; then
	    COMP_WORDS=("aichat-${COMP_WORDS[1]}" "${COMP_WORDS[@]:2}")
	    let COMP_CWORD-=1
	    "$aichatAlias" "${COMP_WORDS[0]}" "${COMP_WORDS[COMP_CWORD]}" "${COMP_WORDS[COMP_CWORD-1]}"
	    return $?
	fi
    fi
    unset IFS

    _aichat "$@"

    if [ $COMP_CWORD -eq 1 ]; then
	readarray -O ${#COMPREPLY[@]} -t COMPREPLY < <(
	    # Also offer aliases (aichat-aliasname, callable via my aichat wrapper
	    # function as aichat aliasname).
	    compgen -W "${aliases[*]}" -X "!${2}*"
	)
    fi
}
complete -o bashdefault -o default -o nosort -F _aichatEx aichat
