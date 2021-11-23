
clear;

pacman -S xf86-video-amdgpu;
pacman -S xorg pavucontrol;

echo 'Section "InputClass"
    Identifier "DELL0A79:00 06CB:CE26 Touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"

EndSection' >> /etc/X11/xorg.conf.d/30-touchpad.conf;

