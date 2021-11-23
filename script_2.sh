clear;

echo "Username: ";
read username;
echo "Hostname: ";
read hostname;

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime;
hwclock --systohc;

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen;
locale-gen;
echo "LANG=en_US.UTF-8" > /etc/locale.conf;
echo "KEYMAP=us" > /etc/vconsole.conf;

echo $hostname > /etc/hostname;
echo "127.0.0.1 localhost" >> /etc/hosts;
echo "::1               localhost" >> /etc/hosts;
echo "127.0.1.1 $hostname.localdomain   $hostname" >> /etc/hosts;

clear;
passwd;

clear;
pacman -S grub efibootmgr networkmanager mtools dosfstools base-devel;

clear;
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB;
grub-mkconfig -o /boot/grub/grub.cfg;

systemctl enable NetworkManager;

EDITOR=nvim visudo;

clear;
useradd -m -G wheel $username;
passwd $username;

exit

