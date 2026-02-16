#!/bin/sh source-this-script

aichat()
{
    # Create an unnamed session by default, unless a session name is passed or
    # the user (or the built-in completion) just queries something.
    containsGlob '--session|-s|--list-*|--version|-V' "$@" || set -- --session temp "$@"
    command aichat "$@"
}
