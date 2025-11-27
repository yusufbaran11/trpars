#!/bin/bash

# YmY OS 43 Beta - Manual Build Script
# This script must be run with sudo/root privileges on a Fedora system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
YMY_VERSION="43-beta-1"
BUILD_DIR="/tmp/ymy-os-build"
RESULT_DIR="$(pwd)/result"
ISO_NAME="YmY-OS-${YMY_VERSION}-x86_64.iso"

echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     YmY OS 43 Beta Build Script      ║${NC}"
echo -e "${GREEN}║          YmY Studios                  ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}[ERROR]${NC} This script must be run as root (use sudo)"
    exit 1
fi

# Check if running on Fedora
if [ ! -f /etc/fedora-release ]; then
    echo -e "${RED}[ERROR]${NC} This script must be run on a Fedora system"
    exit 1
fi

echo -e "${YELLOW}[INFO]${NC} Checking and installing dependencies..."

# Install required packages
dnf install -y lorax anaconda createrepo_c git wget curl \
    syslinux grub2-efi-x64 grub2-efi-x64-modules \
    grub2-tools-extra dosfstools xorriso genisoimage

echo -e "${GREEN}[SUCCESS]${NC} Dependencies installed"

# Create build directories
echo -e "${YELLOW}[INFO]${NC} Creating build directories..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"/{work,result}
mkdir -p "$RESULT_DIR"

echo -e "${GREEN}[SUCCESS]${NC} Build directories created"

# Copy configuration files
echo -e "${YELLOW}[INFO]${NC} Copying configuration files..."
cp -r kickstart "$BUILD_DIR/"
cp -r branding "$BUILD_DIR/"
cp -r config "$BUILD_DIR/"

echo -e "${GREEN}[SUCCESS]${NC} Configuration files copied"

# Build ISO with Lorax
echo -e "${YELLOW}[INFO]${NC} Building ISO with Lorax (this may take a while)..."
cd "$BUILD_DIR"

lorax \
    --product="YmY OS" \
    --version="43" \
    --release="Beta" \
    --source=https://download.fedoraproject.org/pub/fedora/linux/releases/43/Everything/x86_64/os/ \
    --source=https://download.fedoraproject.org/pub/fedora/linux/updates/43/Everything/x86_64/ \
    --variant="Workstation" \
    --bugurl="https://github.com/yusufbaran11/ymy-os/issues" \
    --nomacboot \
    --buildarch=x86_64 \
    --volid="YmY-OS-43-Beta" \
    "$BUILD_DIR/result"

echo -e "${GREEN}[SUCCESS]${NC} Lorax build completed"

# Customize ISO
echo -e "${YELLOW}[INFO]${NC} Customizing ISO..."
cd "$BUILD_DIR/result"

# Add branding files
mkdir -p images/branding
if [ -d "$BUILD_DIR/branding" ]; then
    cp "$BUILD_DIR/branding"/*.png images/branding/ 2>/dev/null || true
fi

# Add kickstart file
if [ -f "$BUILD_DIR/kickstart/ymy-os.ks" ]; then
    cp "$BUILD_DIR/kickstart/ymy-os.ks" isolinux/ks.cfg
fi

echo -e "${GREEN}[SUCCESS]${NC} ISO customization completed"

# Generate ISO file
echo -e "${YELLOW}[INFO]${NC} Generating final ISO file..."
cd "$BUILD_DIR/result"

mkisofs \
    -o "$RESULT_DIR/$ISO_NAME" \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -eltorito-alt-boot \
    -e images/efiboot.img \
    -no-emul-boot \
    -R -J -v -T \
    -V "YmY-OS-43-Beta" \
    .

echo -e "${GREEN}[SUCCESS]${NC} ISO file generated"

# Generate checksums
echo -e "${YELLOW}[INFO]${NC} Generating checksums..."
cd "$RESULT_DIR"

sha256sum "$ISO_NAME" > "${ISO_NAME}.sha256sum"
md5sum "$ISO_NAME" > "${ISO_NAME}.md5sum"

echo -e "${GREEN}[SUCCESS]${NC} Checksums generated"

# Make ISO bootable with isohybrid (for USB boot)
echo -e "${YELLOW}[INFO]${NC} Making ISO hybrid bootable..."
isohybrid --uefi "$RESULT_DIR/$ISO_NAME" 2>/dev/null || echo -e "${YELLOW}[WARNING]${NC} isohybrid failed, ISO may not be hybrid bootable"

# Display results
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          Build Completed!             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo -e "ISO file: ${GREEN}$RESULT_DIR/$ISO_NAME${NC}"
echo -e "Size: $(du -h "$RESULT_DIR/$ISO_NAME" | cut -f1)"
echo ""
echo -e "Checksums:"
echo -e "  SHA256: ${GREEN}$(cat "$RESULT_DIR/${ISO_NAME}.sha256sum" | cut -d' ' -f1)${NC}"
echo -e "  MD5:    ${GREEN}$(cat "$RESULT_DIR/${ISO_NAME}.md5sum" | cut -d' ' -f1)${NC}"
echo ""
echo -e "${YELLOW}[INFO]${NC} You can now write this ISO to a USB drive using:"
echo -e "  dd if=$RESULT_DIR/$ISO_NAME of=/dev/sdX bs=4M status=progress"
echo -e "  ${RED}(Replace /dev/sdX with your USB device)${NC}"
echo ""
echo -e "${YELLOW}[INFO]${NC} Or use tools like Rufus, Etcher, or Fedora Media Writer"
echo ""

# Cleanup option
read -p "Do you want to clean up temporary build files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}[INFO]${NC} Cleaning up..."
    rm -rf "$BUILD_DIR"
    echo -e "${GREEN}[SUCCESS]${NC} Cleanup completed"
fi

echo -e "${GREEN}Build completed successfully!${NC}"
