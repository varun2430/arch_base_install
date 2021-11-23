
echo "Script started: ";

read -p "Automatically select the fastest mirrors? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Selecting the fastest mirrors"
  reflector -c India --sort rate --save /etc/pacman.d/mirrorlist
fi

pacman -Syy;
pacman -Sy archlinux-keyring;

loadkeys us;
timedatectl set-ntp true;

lsblk;

echo "Enter the drive: ";
read drive;
gdisk $drive;

clear;
lsblk;

echo "Enter EFI partition: ";
read efipartition;
mkfs.vfat -F 32 $efipartition;

echo "Enter the linux partition: ";
read partition;
mkfs.ext4 $partition;

mount $partition /mnt;
mkdir -p /mnt/boot/efi;
mount $efipartition /mnt/boot/efi;

pacstrap /mnt base linux linux-firmware nvim amd-ucode;

genfstab -U /mnt >> /mnt/etc/fstab;

arch-chroot /mnt;

sed '1,/^#part2$/d' arch_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit 

#part2

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
echo "127.0.0.1	localhost" >> /etc/hosts;
echo "::1		localhost" >> /etc/hosts;
echo "127.0.1.1	$hostname.localdomain	$hostname" >> /etc/hosts;

passwd;

pacman -S grub efibootmgr networkmanager wpa_supplicant dialog mtools dosfstools base-devel \
	linux-headers bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth git \
	reflector xdg-utils xdg-user-dirs;

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB;
grub-mkconfig -o /boot/grub/grub.cfg;

systemctl enable NetworkManager;
systemctl enable bluetooth;

EDITOR=nvim visudo;

useradd -m -G wheel $username;
passwd $username;

exit

