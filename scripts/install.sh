#!/bin/bash

CONFIG_DIR="~/.config"

echo "It's recommended to execute this shell script in tty and without hypr, dunst, rofi, and waybar folders in ~/.config"

create_symlink() {
    src="$DOTFILES_DIR/$1"
    dest="$CONFIG_DIR/$1"

    if [ -e "$dest" ]; then
        echo "Removing existing file/directory: $dest"
        rm -rf "$dest"
    fi

    ln -s "$src" "$dest"
    echo "Symlink created: $src -> $dest"
}

create_symlink2() {
    src="$DOTFILES_DIR/$1"
    dest="$HOME/Documents/$1"

    mkdir -p "$HOME/Documents"

    if [ -e "$dest" ]; then
        echo "Removing existing file/directory: $dest"
        rm -rf "$dest"
    fi

    ln -s "$src" "$dest"
    echo "Symlink created: $src -> $dest"
}

DOTFILES_DIR="$(pwd)"

files=("hypr" "dunst" "rofi" "waybar" "qt5ct" "qt6ct" "kitty" "gtk-3.0")

additional=("Wallpapers")

for file in "${files[@]}"; do
    create_symlink "$file"
done

for file in "${additional[@]}"; do
    create_symlink2 "$file"
done

echo "All done!"
