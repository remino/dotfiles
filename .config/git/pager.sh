#!/bin/sh

if command -v diff-so-fancy > /dev/null 2>&1; then
	exec diff-so-fancy | less -RFX --tabs=2
else
	exec less -RFX
fi
