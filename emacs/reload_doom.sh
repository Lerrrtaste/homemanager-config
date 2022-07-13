#!bin/sh
DOOM="$HOME/.emacs.d"
if [ ! -d "$DOOM" ]; then
	git clone https://github.com/hlissner/doom-emacs.git $DOOM
        echo "INSTALLING DOOM!!!"
	$DOOM/bin/doom install
fi

$DOOM/bin/doom sync
