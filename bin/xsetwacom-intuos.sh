#!/bin/sh

# Don't put -KP_ADD to allow for repetition when keeping the button pressed down
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "3" "key +Control_L +KP_Add "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "2" "key +Control_L +KP_Subtract "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "8" "key +Control_L +Next -Next "
xsetwacom set "Wacom Intuos BT M Pad pad" "Button" "1" "key +Control_L +Prior -Prior "

