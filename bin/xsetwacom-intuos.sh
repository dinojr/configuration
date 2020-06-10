#!/usr/bin/env bash
sleep 2

exec > /tmp/red-wacom.log
exec 2>&1

# to allow root access to X
# export DISPLAY=:0
# export XAUTHORITY=/run/user/1000/gdm/Xauthority


# Don't put -KP_ADD to allow for repetition when keeping the button pressed down
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "3" "key +Control_L +KP_Add "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "2" "key +Control_L +KP_Subtract "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "8" "key +Control_L +Next -Next "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "1" "key +Control_L +Prior -Prior "
xsetwacom set "Wacom Intuos BT M Pen stylus" MapToOutput HDMI-2
