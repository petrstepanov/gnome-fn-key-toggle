#!/bin/bash

FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

SHORTCUT=~/.local/share/applications/fn-toggle.desktop

# Reflect the icon depending on the curent value of the FNMODE
if [ $FNMODE = 0 ] || [ $FNMODE = 2 ]; then
    # Currently `fn` key is disabled or `F#` keys are on (same behavior)
    # Therefore, enable "special" keys
    # Delete line containing "Icon=" in `fn-toggle.desktop`
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-f" >> $SHORTCUT
else
    # Currently "FN" keys are on
    # Delete line containing "Icon=" in `fn-toggle.desktop`
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-special" >> $SHORTCUT
fi

# Update application menu list
xdg-desktop-menu forceupdate
