#!/bin/bash

choice=$(echo -e "⏻ Выключение\n Перезагрузка\n󰤄 Сон\n󰋊 Гибернация\n Отмена" | wofi --dmenu --prompt "Действие:" --width 200 --height 180)

case "$choice" in
    "⏻ Выключение")
        systemctl poweroff
        ;;
    " Перезагрузка")
        systemctl reboot
        ;;
    "󰤄 Сон")
        systemctl suspend
        ;;
    "󰋊 Гибернация")
        systemctl hibernate
        ;;
    " Отмена")
        exit 0
        ;;
    *)
        exit 0
        ;;
esac
