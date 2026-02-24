#!/bin/sh source-this-script

# faichat	Include files and directories from standard input
#		in the AI chat.
faichat()
{
    linesToArgs --prefix --file= -- \
	aichat-wrapper {} "$@"
}
