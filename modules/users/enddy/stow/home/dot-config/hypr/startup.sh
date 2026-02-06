#!/usr/bin/env bash

# Wallpaper
swww init &
swww img ~/Wallpapers/retroCity1.png &

# network
nm-applet --indicator &

# bar
waybar &

hypridle &

dunst

