# TRPars 26.0 Beta Kickstart Configuration
# Fedora 43 Based - Linux Yeni Başlayanlar İçin

# System language and keyboard
lang tr_TR.UTF-8
keyboard --xlayouts=tr

# Network configuration
network --bootproto=dhcp --onboot=on --hostname=trpars

# Partition information
zerombr
clearpart --all
autopart --type=lvm

# Boot loader configuration
bootloader --location=mbr --timeout=5

# Installation medium
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

# System timezone (--isUtc removed - deprecated)
timezone Europe/Istanbul

# Root password (locked)
rootpw --lock

# Default user
user --name=trpars --groups=wheel --plaintext --password=trpars123

# Firewall and SELinux
firewall --enabled
selinux --enforcing

# Disable unnecessary services
services --disabled=avahi-daemon,cups

%packages
# Desktop Environment - Cinnamon
@cinnamon-desktop-environment
cinnamon-extensions
cinnamon-themes
cinnamon-core

# Core packages
@core
@standard
kernel-devel

# Utilities for beginners
nautilus
nemo
file-roller
gnome-terminal
tilix

# System tools (GUI based)
gnome-control-center
cinnamon-settings
system-config-printer
software-properties-gtk

# Turkish language support
langpacks-tr
hunspell-tr

# Network tools
networkmanager
network-manager-applet
nm-connection-editor

# Office and productivity (optional, light weight)
gedit
mousepad

# Media support
gstreamer1-plugins-good
gstreamer1-plugins-ugly
gstreamer1-plugins-bad-freeworld

# Fonts
liberation-fonts
dejavu-fonts
google-noto-sans-turkish-fonts

# Development tools (optional, for curious users)
git
git-gui
geany

# Remove unnecessary packages
-@office
-@games
-evolution
-evolution-data-server

%end

%post
# TRPars Customizations
echo "=== TRPars 26.0 Beta Setup ===" >> /var/log/trpars-build.log

# Update system
dnf update -y

# Create TRPars welcome screen
mkdir -p /etc/skel/.config/cinnamon

# Set default theme to modern one
cat > /etc/skel/.config/cinnamon/cinnamon.json << 'EOF'
{
  "theme": "Mint-Y-Darker",
  "icon-theme": "Mint-Y",
  "cursor-theme": "Adwaita",
  "desktop": {
    "show-desktop-icons": true,
    "show-file-manager-icons": true
  }
}
EOF

# Create beginner's guide
mkdir -p /usr/share/doc/trpars
cat > /usr/share/doc/trpars/BASLAYANLAR.md << 'EOF'
# TRPars Linux 26.0 Beta - Başlangıç Rehberi

## Hoşgeldiniz! 👋

Bu rehber Linux'a yeni geçen kullanıcılar için hazırlanmıştır.

### Temel İşlemler

#### Dosya Yönetici
- İlk satırdaki menüden "Dosya Yöneticisi" seçin
- Dosyalarınızı buradan düzenleyebilirsiniz

#### Uygulamalar Açma
- Masaüstü menüsüne sağ tıklayın
- İstediğiniz uygulamayı seçin

#### Sistem Ayarları
- Panel menüsünden "Ayarlar" seçin
- Wifi, ses, ekran ayarlarını yapabilirsiniz

#### Yazılım Yükleme
- Menüden "Yazılım" (Software Manager) açın
- Aradığınız programı bulup yükleyin

### Sık Sorulan Sorular

**S: Şifre yaptığım yer neresi?**
A: Ayarlar > Kullanıcılar > Parolanızı değiştir

**S: İnternet bağlantısı kuramıyorum?**
A: Sağ üst köşedeki ağ simgesine tıklayın

**S: Program nasıl kaldırırım?**
A: Yazılım Manager'dan aradığınız programı bulup "Kaldır"a tıklayın

EOF

# Create desktop shortcut for help
cat > /usr/share/applications/trpars-help.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=TRPars Başlangıç Rehberi
Name[tr]=TRPars Başlangıç Rehberi
Comment=Linux'a yeni başlayanlar için rehber
Comment[tr]=Linux'a yeni başlayanlar için rehber
Exec=gedit /usr/share/doc/trpars/BASLAYANLAR.md
Icon=system-help
Categories=System;Documentation;
Terminal=false
EOF

# Create motd
cat > /etc/motd << 'EOF'
╔════════════════════════════════════════╗
║     TRPars Linux 26.0 Beta             ║
║  Linux Yeni Başlayanlar İçin           ║
║                                        ║"
║  Hoşgeldiniz! Linux yolculuğunuzda     ║
║  başarılar dileriz.                    ║
╚════════════════════════════════════════╝
EOF

# Set keyboard layout permanently
localectl set-x11-keymap tr

%end

%post --logfile=/root/trpars-post.log
# Additional user-friendly setup

# Create helpful aliases for command line (if needed)
echo "alias ll='ls -lah'" >> /etc/skel/.bashrc
echo "alias update='sudo dnf update -y'" >> /etc/skel/.bashrc

# Set up help documentation
mkdir -p /usr/share/doc/trpars/docs
cat > /usr/share/doc/trpars/docs/SISTEM-AYARLARI.txt << 'EOF'
TRPars Sistem Ayarları

1. WIFI BAĞLANTISI
   - Sağ üst köşedeki ağ simgesine tıklayın
   - Ağı seçin ve şifre girin

2. SES AYARLARI
   - Sağ üst köşedeki ses simgesine tıklayın
   - Ses seviyesini ayarlayın

3. EKRAN AYARLARI
   - Ayarlar > Ekran > Çözünürlük
   - İstediğiniz çözünürlüğü seçin

4. YAZICI KURULUMU
   - Ayarlar > Yazıcılar
   - Yazıcınızı ekleyin

5. BLUETOOTH
   - Ayarlar > Bluetooth
   - Cihazınızı eşleştirin
EOF

%end
