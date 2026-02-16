#!/bin/sh source-this-script

aichat()
{
    aichat-wrapper "$@"
}

# faichat	Include files and directories from standard input
#		in the AI chat.
faichat()
{
    linesToArgs --prefix --file= -- \
	aichat-wrapper {} "$@"
}
