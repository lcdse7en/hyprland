#!/usr/bin/bash

#********************************************
# Author      : lcdse7en                    *
# E-mail      : 2353442022@qq.com           *
# Create_Time : 2023-12-09 17:20:37         *
# Description :                             *
#********************************************

# source /etc/profile.d/import_shell_libs.sh

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
SKYBLUE=$(printf '\033[36m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

hypr_ver="hyprv4"
downloadDir="$HOME/Downloads"
baseDir="$HOME/.config"
hyprDir="$baseDir/hypr"
hyprconf="hyprland.conf"
waybarDir="$baseDir/waybar"

Clone_hypr() {
    cd "$downloadDir" || exit
    if [[ ! -d "$downloadDir/$hypr_ver" ]]; then
        git clone https://github.com/soldoestech/$hypr_ver.git
    fi
}

Install_hypr() {
    printf "${YELLOW}%s"
    read -r -p "Have you want to install hyprland? [y/N]" -e answer
    printf "${RESET}%s"

    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        echo "Hyprland is not installed"
    else
        printf "${SKYBLUE}%Installing hyprland ...%s${RESET}\n"
        cd "$downloadDir/$hypr_ver" || exit
        chmode +x set-hypr
        sh set-hypr
    fi
}

Hypr_config() {
    hyprDir="$baseDir/hypr"
    if [[ ! -d "$hyprDir" ]]; then
        mkdir -p "$hyprDir"
    fi

    cd "$hyprDir" || exit
    printf "${SKYBLUE}%s"
    printf "*%.0s" {1..22}
    printf "${RESET}%s"

    printf " hyprland.conf "

    printf "${SKYBLUE}%s"
    printf "*%.0s" {1..23}
    printf "${RESET}%s\n"

    sudo tee -a "$hyprDir/$hyprconf" <<-EOF
		# See https://wiki.hyprland.org/Configuring/keywords/ for more
		#autogenerate=1
		monitor=,preferred,auto,auto

		#Execute your favorite apps at launch
		exec-once = waybar &
		exec-once = fcitx5 -d

		\$mainMod = SUPER

		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind = \$mainMod SHIFT, Q, exit
		bind = \$mainMod, Q, killactive
		bind = \$mainMod, space, exec, kitty
		bind = \$mainMod, R, exec, wofi --show drun

		# Move focus
		bind = \$mainMod, H, movefocus, l
		bind = \$mainMod, L, movefocus, r
		bind = \$mainMod, J, movefocus, d
		bind = \$mainMod, K, movefocus, u

		# Switch workspaces with mainMod + [0-9]
		bind = \$mainMod, 1, workspace, 1
		bind = \$mainMod, 2, workspace, 2
		bind = \$mainMod, 3, workspace, 3
		bind = \$mainMod, 4, workspace, 4
		bind = \$mainMod, 5, workspace, 5
		bind = \$mainMod, 6, workspace, 6
		bind = \$mainMod, 7, workspace, 7
		bind = \$mainMod, 8, workspace, 8
		bind = \$mainMod, 8, workspace, 9

		# Move active window to a workspace with mainMod + SHIFT + [0-9]
		bind = \$mainMod SHIFT, 1, movetoworkspace, 1
		bind = \$mainMod SHIFT, 2, movetoworkspace, 2
		bind = \$mainMod SHIFT, 3, movetoworkspace, 3
		bind = \$mainMod SHIFT, 4, movetoworkspace, 4
		bind = \$mainMod SHIFT, 5, movetoworkspace, 5
		bind = \$mainMod SHIFT, 6, movetoworkspace, 6
		bind = \$mainMod SHIFT, 7, movetoworkspace, 7
		bind = \$mainMod SHIFT, 8, movetoworkspace, 8
		bind = \$mainMod SHIFT, 8, movetoworkspace, 9
		EOF

    printf "${SKYBLUE}%s"
    printf "*%.0s" {1..60}
    printf "${RESET}%s\n"
    printf "${GREEN}The profile is generated for you -> $hyprDir/$hyprconf%s${RESET}\n"
}

main() {
    # Clone_hypr
    # Install_hypr
    Hypr_config
}

main
