# aichat CLI extensions

_Additions and tweaks to the aichat CLI._

These are some personal aliases, shortcuts, and extensions that make (my) work with the [all-in-one LLM CLI tool](https://github.com/sigoden/aichat) command-line utility `aichat` easier and faster. Some of them may be specific to my environment and workflow, but maybe someone finds a valuable nugget in there.

### Installation

Download all / some selected extensions (note that some have dependencies, though) and put them somewhere in your `PATH`, or just add the `./bin` subdirectory to `PATH`. You can then invoke them via `aichat-SUBCOMMAND`.

It is recommended to also use the (Bash, but should also work in Korn shell and Dash) shell functions (e.g. in your `.bashrc`) found at [shell/wrappers.sh](shell/wrappers.sh) to transparently invoke the extensions in the same way as the built-in aichat commands, via `aichat SUBCOMMAND`.

* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/bash/completions.sh](shell/bash/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [shell/wrappers.sh](shell/wrappers.sh) script (meant to be sourced in `.bashrc`) defines Bash wrappers around provided commands (for additional features in the current shell).
