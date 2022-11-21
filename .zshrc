ZSH_INCLUDES="$HOME/.config/zsh/include.d"
if [ -d "$ZSH_INCLUDES" ]
then
	for include in $( find -L "$ZSH_INCLUDES" -not -name '.*' -type f | sort )
	do
		source "$include"
	done
fi
