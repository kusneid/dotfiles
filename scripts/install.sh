#!/bin/bash

CONFIG_DIR="/home/kusneid/.config"



echo "it's recommended to execute this shell script in tty and w/o hypr, dunst, rofi and waybar folders in ~/.config"


#echo "downloading packages:(YAY REQUIRED)"
#yay -S wlogout hyprlock hyprshot hyprland brightnessctl pamixer playerctl hypridle wl-clipboard cliphist hyprpaper waybar hyprlang hyprcursor dunst pavucontrol blueman pipewire-pulse kitty nemo firefox rofi-wayland network-manager-applet sddm layan-gtk-theme-git

DOTFILES_DIR="$(pwd)"

create_symlink() {
    src="$DOTFILES_DIR/$1"
    dest="$CONFIG_DIR/$1"

    if [ -e "$dest" ]; then
        echo "File $dest exists"
    else
        ln -sf "$src" "$dest"
        echo "symlink created $src -> $dest"
    fi
}

create_symlink2() {
    src="$DOTFILES_DIR/$1"
    mkdir $HOME/Documents
    dest="$HOME/Documents/$1"

    if [ -e "$dest" ]; then
        echo "File $dest exists"
    else
        ln -sf "$src" "$dest"
        echo "symlink created $src -> $dest"
    fi
}

files=("hypr" "dunst" "rofi" "waybar" "qt5ct" "qt6ct" "kitty" "gtk-3.0")

additional=("Wallpapers")

for file in "${files[@]}"; do
    create_symlink "$file"
done

for file in "${additional[@]}"; do
    create_symlink2 "$file"
done

#sudo systemctl enable --now bluetooth

echo "all done"
