#!/bin/sh


TMUX_CONF=$HOME/.tmux.conf
if [ -f "$TMUX_CONF"  ]; then
	    echo "$TMUX_CONF exists."
	    echo "Removing ${HOME}/.tmux.conf"
			rm $HOME/.tmux.conf
fi

echo ""
VIMRC=$HOME/.vimrc
if [ -f "$VIMRC"  ]; then
	    echo "$VIMRC exists."
	    echo "Removing ${HOME}/.vimrc"
			rm $HOME/.vimrc
fi

ALACRITTY=$HOME/.config/alacritty/alacritty.yml
if [ -f "$ALACRITTY"  ]; then
	    echo "$ALACRITTY exists."
	    echo "Removing ${ALACRITTY}"
			rm $ALACRITTY
fi


ln -s $(pwd)/.tmux.conf $HOME
ln -s $(pwd)/.vimrc $HOME
mkdir -p $HOME/.config/alacritty && cp $(pwd)/alacritty.yml $ALACRITTY
