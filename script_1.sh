
echo "Script started: ";

pacman -Sy archlinux-keyring;

loadkeys us;
timedatectl set-ntp true;

pacman -Syy;

clear;
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

pacstrap /mnt base linux linux-firmware neovim amd-ucode;

genfstab -U /mnt >> /mnt/etc/fstab;

cp arch_base_install/script_2.sh /mnt/script_2.sh;
chmod +x /mnt/script_2.sh;
arch-chroot /mnt ./script_2.sh;

exit 

