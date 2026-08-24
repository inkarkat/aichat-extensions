#!/bin/bash source-this-script

_aichat_wrapper_complete()
{
    local IFS=$'\n'
    typeset -a extensions=(); readarray -t extensions < <(compgen -A command -- 'aichat-')
    extensions=("${extensions[@]/#aichat-/}")

    if [ $COMP_CWORD -ge 2 ] && contains "${COMP_WORDS[1]}" "${extensions[@]}"; then
	local aichatExtension="_aichat_${COMP_WORDS[1]//-/_}_complete"
	# Completing an extension; delegate to its custom completion function (if
	# available)
	if type -t "$aichatExtension" >/dev/null; then
	    COMP_WORDS=("aichat-${COMP_WORDS[1]}" "${COMP_WORDS[@]:2}")
	    let COMP_CWORD-=1
	    "$aichatExtension" "${COMP_WORDS[0]}" "${COMP_WORDS[COMP_CWORD]}" "${COMP_WORDS[COMP_CWORD-1]}"
	    return $?
	fi
    fi
    unset IFS

    _aichat "$@"    # The original completion function.

    if [ $COMP_CWORD -eq 1 ]; then
	readarray -O ${#COMPREPLY[@]} -t COMPREPLY < <(
	    # Also offer extensions (aichat-extensionname, callable via my aichat wrapper
	    # function as aichat extensionname).
	    compgen -W "${extensions[*]}" -X "!${2}*"
	)
    fi
}
_aichat_complete()
{
    complete -o bashdefault -o default -o nosort -F _aichat_wrapper_complete "$@"
}
_aichat_complete aichat aichat-wrapper

_aichat_name_session_complete()
{
    local IFS=$'\n'
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"

    readarray -t COMPREPLY < <(command cd "${XDG_CONFIG_HOME:-${HOME}/.config}/aichat/sessions/_" 2>/dev/null && readarray -t files < <(find . -type f  -printf '%P\n') && compgen -W "${files[*]}" -- "$cur")
    [ ${#COMPREPLY[@]} -gt 0 ] && readarray -t COMPREPLY < <(printf "%q\n" "${COMPREPLY[@]}")
}
complete -F _aichat_name_session aichat-name-session
