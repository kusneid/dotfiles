#!/bin/bash

CONFIG_DIR="$HOME/.config"

echo "downloading packages:(YAY REQUIRED)"

yay -S wlogout swaylock-effects 

sudo pacman -S dunst fish hyprland hypridle wl-clipboard cliphist hyprpaper rofi-wayland waybar ttf-jetbrains-mono hyprlang hyprcursor dunst pavucontrol blueman nm-connection-editor 

DOTFILES_DIR="$(pwd)" 

create_symlink() {
    src="$DOTFILES_DIR/$1"
    dest="$CONFIG_DIR/$1"

    if [ -e "$dest" ]; then
        echo "File $dest exists"
    else
        ln -s "$src" "$dest"
        echo "symlink created $src -> $dest"
    fi
}

create_symlink2() {
    src="$DOTFILES_DIR/$1"
    dest="$HOME/Documents/$1"

    if [ -e "$dest" ]; then
        echo "File $dest exists"
    else
        ln -s "$src" "$dest"
        echo "symlink created $src -> $dest"
    fi
}

files=("hypr" "dunst" "fish" "kitty" "rofi" "swaylock" "waybar")

additional=("Sounds" "Wallpapers")

for file in "${files[@]}"; do
    create_symlink "$file"
done

for file in "${additional[@]}"; do
    create_symlink2 "$file"
done

echo "all done"
