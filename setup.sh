#!/bin/bash
# A script to setup my zsh and neovim setups. Feel free to use it.

if [ "$SHELL" != "/bin/zsh" ]
then
	echo "You have to be using zsh before running this command"
	exit 1
fi

dir=$1
if [ ! -d "$dir" ]
then
	echo "Directory $dir does not exist."
	exit 1
fi


# Setup zsh.
cd "$dir" || exit 1

git clone https://github.com/vim345/oh-my-zsh.git

cd "oh-my-zsh/custom/" || exit 1

git clone https://github.com/vim345/themes.git

cd "plugins" || exit 1

git clone https://github.com/vim345/mhmdzsh.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

if grep -q "export ZSH=$dir/oh-my-zsh" ~/.zshrc
then
	echo "Not setting zsh env variables anymore."
else
	echo "export ZSH=$dir/oh-my-zsh" >> ~/.zshrc
	echo "source \$ZSH/base.sh" >> ~/.zshrc
fi

source ~/.zshrc

# Setup nvim environment now.
cd ~/.config/ || exit 1

git clone https://github.com/vim345/nvim.git
nvim +PlugInstall +qall


# Setup tmux
cd "$dir" || exit 1
git clone https://github.com/vim345/tmux.git
git clone https://github.com/tmux-plugins/tpm.git "tmux/plugins/tpm"

TMUX_FILE="$HOME/.tmux.conf"
if test -f "$TMUX_FILE"; then
	if grep -q "source $dir/tmux/tmux.conf" "$TMUX_FILE"
	then
		echo "Not setting tmux config anymore."
	else
		echo "source $dir/tmux/tmux.conf" >> "$TMUX_FILE"
	fi
else
	echo "source $dir/tmux/tmux.conf" > "$TMUX_FILE"
fi
