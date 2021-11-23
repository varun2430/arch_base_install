
clear;

echo "load-module module-switch-on-connect" >> /etc/pulse/default.pa;

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/g' /etc/default/grub;
sed -i 's/loglevel=3 quiet/loglevel=3 quiet acpi_backlight=vendor/g' /etc/default/grub;
grub-mkconfig -o /boot/grub/grub.cfg;

pacman -S xf86-video-amdgpu;
pacman -S xorg pavucontrol;

echo 'Section "InputClass"
    Identifier "DELL0A79:00 06CB:CE26 Touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"

EndSection' >> /etc/X11/xorg.conf.d/30-touchpad.conf;

