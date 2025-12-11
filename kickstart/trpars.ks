# TRPars 26.0 Beta Kickstart
# Fedora 43 - Cinnamon Desktop

lang tr_TR.UTF-8
keyboard --xlayouts=tr
network --bootproto=dhcp --onboot=on --hostname=trpars
zerombr
clearpart --all
autopart --type=lvm
bootloader --location=mbr --timeout=5
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-43&arch=x86_64
timezone Europe/Istanbul
rootpw --lock
user --name=trpars --groups=wheel --plaintext --password=trpars123
firewall --enabled
selinux --enforcing

%packages
# Core packages
@core
@standard
kernel-devel

# Desktop Environment - Cinnamon
@cinnamon-desktop-environment
cinnamon
cinnamon-core
cinnamon-extensions
cinnamon-themes
cinnamon-settings-daemon
muffin
nemo
nemo-extensions

# Turkish language support
langpacks-tr
hunspell-tr
google-noto-sans-turkish-fonts

# Utilities
nautilus
file-roller
gnome-terminal
tilix
gedit
mousepad

# System tools (GUI)
gnome-control-center
system-config-printer
networkmanager
network-manager-applet
nm-connection-editor

# Media support
gstreamer1-plugins-good
gstreamer1-plugins-ugly
gstreamer1-plugins-bad-freeworld

# Fonts
liberation-fonts
dejavu-fonts

# Development (optional)
git
git-gui
geany

# Remove unnecessary
-@office
-@games
-evolution
-evolution-data-server

%end

%post
# TRPars Setup
echo "=== TRPars 26.0 Beta ===" >> /var/log/trpars-build.log

# Create beginner's guide
mkdir -p /usr/share/doc/trpars
cat > /usr/share/doc/trpars/BASLAYANLAR.md << 'EOF'
# TRPars Linux 26.0 Beta - Başlangıç Rehberi

## Hoşgeldiniz! 👋

Bu rehber Linux'a yeni geçen kullanıcılar için hazırlanmıştır.

### Temel İşlemler

#### Dosya Yönetici
- Masaüstündeki klasöre tıklayın
- Dosyalarınızı buradan düzenleyebilirsiniz

#### Uygulamalar
- Masaüstü menüsüne sağ tıklayın
- İstediğiniz uygulamayı seçin

#### Sistem Ayarları
- Panel menüsünden "Ayarlar" seçin
- WiFi, ses, ekran ayarlarını yapabilirsiniz

#### Yazılım Yükleme
- Menüden "Yazılım" açın
- Aradığınız programı bulup yükleyin

### Sık Sorulan Sorular

**S: Şifre nasıl değiştirim?**
A: Ayarlar > Kullanıcılar > Parolanızı değiştir

**S: İnternet bağlantısı kuramıyorum?**
A: Sağ üst köşedeki ağ simgesine tıklayın

**S: Program nasıl kaldırırım?**
A: Yazılım Manager'dan programı bulup "Kaldır"a tıklayın

EOF

# Set keyboard layout
localectl set-x11-keymap tr

# Create welcome message
cat > /etc/motd << 'EOF'
╔════════════════════════════════════════╗
║     TRPars Linux 26.0 Beta             ║
║  Linux Yeni Başlayanlar İçin           ║
║                                        ║
║  Hoşgeldiniz!                          ║
╚════════════════════════════════════════╝
EOF

# Update system
dnf update -y

%end

%post --logfile=/root/trpars-post.log
# Additional setup
echo "alias ll='ls -lah'" >> /etc/skel/.bashrc
echo "alias update='sudo dnf update -y'" >> /etc/skel/.bashrc
%end
