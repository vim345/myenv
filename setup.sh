#!/bin/bash
# A script to setup my zsh and neovim setups. Feel free to use it.

dir=$1
if [ ! -d "$dir" ]
then
	echo "Directory $dir does not exist."
	exit 1
fi

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