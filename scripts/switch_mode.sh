#!/bin/bash

QT5_DIR="$HOME/dotfiles/qt5ct"
QT6_DIR="$HOME/dotfiles/qt6ct"

QT5_CONF="$QT5_DIR/qt5ct.conf"
QT5_ALT_CONF="$QT5_DIR/qt5ct1.conf"

QT6_CONF="$QT6_DIR/qt6ct.conf"
QT6_ALT_CONF="$QT6_DIR/qt6ct1.conf"

blackwallpaper="/home/kusneid/Documents/Wallpapers/nathan-ansell-X-prib5n490-unsplash.jpg"
whitewallpaper="/home/kusneid/Documents/Wallpapers/nathan-ansell-X-prib5n490-unsplash.jpg"

if [ "$1" == "dark" ]; then
    gsettings set org.gnome.desktop.interface gtk-theme "'Adwaita-dark'"
    gsettings set org.gnome.desktop.interface color-scheme "'prefer-dark'"

    spicetify config color_scheme Catppuccin-Frappe
    spicetify apply

    if [ -f "$QT5_CONF.bak" ]; then
        mv "$QT5_CONF" "$QT5_ALT_CONF"
        mv "$QT5_CONF.bak" "$QT5_CONF"
    fi

    if [ -f "$QT6_CONF.bak" ]; then
        mv "$QT6_CONF" "$QT6_ALT_CONF"
        mv "$QT6_CONF.bak" "$QT6_CONF"
    fi

    sed -i 's/"workbench.colorTheme": "[^"]*"/"workbench.colorTheme": "Subaru (Dark)"/' ~/.config/Code/User/settings.json

    hyprctl hyprpaper preload "$blackwallpaper"

    hyprctl hyprpaper wallpaper "eDP-1,$blackwallpaper"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$blackwallpaper"


elif [ "$1" == "light" ]; then
    gsettings set org.gnome.desktop.interface gtk-theme "'Adwaita'"
    gsettings set org.gnome.desktop.interface color-scheme "'prefer-light'"

    spicetify config color_scheme Catppuccin-Latte
    spicetify apply


    if [ -f "$QT5_ALT_CONF" ]; then
        mv "$QT5_CONF" "$QT5_CONF.bak"
        mv "$QT5_ALT_CONF" "$QT5_CONF"
    fi

    if [ -f "$QT6_ALT_CONF" ]; then
        mv "$QT6_CONF" "$QT6_CONF.bak"
        mv "$QT6_ALT_CONF" "$QT6_CONF"
    fi

    sed -i 's/"workbench.colorTheme": "[^"]*"/"workbench.colorTheme": "Subaru (Light)"/' ~/.config/Code/User/settings.json

    hyprctl hyprpaper preload "$whitewallpaper"

    hyprctl hyprpaper wallpaper "eDP-1,$whitewallpaper"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$whitewallpaper"

else
    echo "Использование: $0 [dark|light]"
    exit 1
fi
