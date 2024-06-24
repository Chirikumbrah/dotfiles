#!/bin/sh

IS_LIGHT=$(grep -q solarized_light ~/.config/alacritty/alacritty.toml ; echo $?)

echo $IS_LIGHT

if [ "$IS_LIGHT" == 0 ]; then
	sed -i "" "s/solarized_light/solarized_dark/" ~/.config/alacritty/alacritty.toml
else
	sed -i "" "s/solarized_dark/solarized_light/" ~/.config/alacritty/alacritty.toml
fi
