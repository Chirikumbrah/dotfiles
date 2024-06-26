#!/bin/sh

THEME=gruvbox
IS_LIGHT=$(grep -q ${THEME}_light ~/.config/alacritty/alacritty.toml ; echo $?)

if [ "$IS_LIGHT" == 0 ]; then
	sed -i "" "s/${THEME}_light/${THEME}_dark/" ~/.config/alacritty/alacritty.toml
else
	sed -i "" "s/${THEME}_dark/${THEME}_light/" ~/.config/alacritty/alacritty.toml
fi
