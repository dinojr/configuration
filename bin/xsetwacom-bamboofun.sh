#!/bin/sh
# # Button < don't put -KP_ADD to allow for repetition when keeping the button pressed down
# xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "1" "key +Control_L +KP_Add "
# #Button FN2
# xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "3" "key +Control_L +Next -Next "
# #Button FN1
# xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "8" "key +Control_L +KP_Subtract "
# #Button >
# xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "9" "key +Control_L +Prior -Prior "

# Lateral parts of the ring
# Don't put -KP_ADD to allow for repetition when keeping the button pressed down
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "AbsWheelUp" "key +Control_L +KP_Add "
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "AbsWheelDown" "key +Control_L +KP_Subtract "
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "1" "key +Control_L +Next -Next "
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "Button" "8" "key +Control_L +Prior -Prior "


#up and down arrows on the ring
#put -Nex to only press once
# doesn't work, not sure what RelWheel is
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "RelWheelDown" "key +Control_L +Next -Next "
xsetwacom set "Wacom BambooFun 6x8 Pad pad" "RelWheelUp" "key +Control_L +Prior -Prior "
