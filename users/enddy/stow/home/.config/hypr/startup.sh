#!/usr/bin/env bash

# Wallpaper
swww init &
swww img ~/Wallpapers/gruvbox-mountain-village.png &

# network
nm-applet --indicator &

# bar
waybar &

dunst
