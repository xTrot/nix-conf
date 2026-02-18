#!/usr/bin/env bash

# Wallpaper
nohup sh swww-daemon &
WALL_DIR="/home/enddy/Wallpaper"
random_wallpaper="$(find $WALL_DIR -type f -print0 | shuf -z -n 1 | xargs -0 echo)"
# echo "WALL_DIR: $WALL_DIR" > ~/chosen_wall.txt
# echo "find: $(find $WALL_DIR -type f -print0)" >> ~/chosen_wall.txt
# echo "shuf: $(find $WALL_DIR -type f -print0 | shuf -z -n 1)" >> ~/chosen_wall.txt
echo "Chosen: $random_wallpaper" > ~/chosen_wall.txt
sleep 1
swww img $random_wallpaper

# network
nm-applet --indicator &

# bar
waybar &

hypridle &

dunst

