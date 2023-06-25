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


ln -s $(pwd)/.tmux.conf $HOME
ln -s $(pwd)/.vimrc $HOME

