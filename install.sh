#!/bin/bash

# EXP-LINK v3.0 Installation Script
# Author: xspeen
# Repository: https://github.com/xspeen/EXP-LINK-UNSHACKLED.git

echo -e "\033[1;31m"
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                                                                   ║"
echo "║  ███████╗██╗  ██╗██████╗     ██╗     ██╗███╗   ██╗██╗  ██╗       ║"
echo "║  ██╔════╝╚██╗██╔╝██╔══██╗    ██║     ██║████╗  ██║██║ ██╔╝       ║"
echo "║  █████╗   ╚███╔╝ ██████╔╝    ██║     ██║██╔██╗ ██║█████╔╝        ║"
echo "║  ██╔══╝   ██╔██╗ ██╔═══╝     ██║     ██║██║╚██╗██║██╔═██╗        ║"
echo "║  ███████╗██╔╝ ██╗██║         ███████╗██║██║ ╚████║██║  ██╗       ║"
echo "║  ╚══════╝╚═╝  ╚═╝╚═╝         ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝       ║"
echo "║                                                                   ║"
echo "║              [ INSTALLATION SCRIPT - v3.0.UNSHACKLED ]           ║"
echo "║                                                                   ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo -e "\033[0m"

# Detect OS
OS="$(uname -s)"
ARCH="$(uname -m)"

echo -e "\033[1;36m[+] Detected System: $OS ($ARCH)\033[0m"
echo -e "\033[1;36m[+] Repository: https://github.com/xspeen/EXP-LINK-UNSHACKLED\033[0m"

# Check for Python3
echo -e "\033[1;33m[~] Checking Python3 installation...\033[0m"
if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "\033[1;32m[✓] $PYTHON_VERSION\033[0m"
else
    echo -e "\033[1;31m[!] Python3 not found! Installing...\033[0m"
    
    if [[ "$OS" == "Linux" ]]; then
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install python3 python3-pip -y
        elif command -v pkg &>/dev/null; then
            # Termux
            pkg update && pkg install python python-pip -y
        elif command -v dnf &>/dev/null; then
            sudo dnf install python3 python3-pip -y
        elif command -v pacman &>/dev/null; then
            sudo pacman -S python python-pip --noconfirm
        else
            echo -e "\033[1;31m[!] Could not install Python3. Please install manually.\033[0m"
            exit 1
        fi
    elif [[ "$OS" == "Darwin" ]]; then
        if command -v brew &>/dev/null; then
            brew install python3
        else
            echo -e "\033[1;31m[!] Please install Homebrew and Python3 manually\033[0m"
            exit 1
        fi
    elif [[ "$OS" == "MINGW"* ]] || [[ "$OS" == "CYGWIN"* ]]; then
        echo -e "\033[1;31m[!] On Windows, please install Python3 from python.org\033[0m"
        exit 1
    fi
fi

# Check for pip3
echo -e "\n\033[1;33m[~] Checking pip3...\033[0m"
if command -v pip3 &>/dev/null; then
    echo -e "\033[1;32m[✓] pip3 is available\033[0m"
else
    echo -e "\033[1;31m[!] pip3 not found! Installing...\033[0m"
    python3 -m ensurepip --upgrade
fi

# Upgrade pip
echo -e "\n\033[1;33m[~] Upgrading pip...\033[0m"
python3 -m pip install --upgrade pip

# Install FFmpeg (optional but recommended)
echo -e "\n\033[1;33m[~] Checking FFmpeg...\033[0m"
if command -v ffmpeg &>/dev/null; then
    echo -e "\033[1;32m[✓] FFmpeg is available\033[0m"
else
    echo -e "\033[1;31m[!] FFmpeg not found! Installing...\033[0m"
    
    if [[ "$OS" == "Linux" ]]; then
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install ffmpeg -y
        elif command -v pkg &>/dev/null; then
            pkg install ffmpeg -y
        elif command -v dnf &>/dev/null; then
            sudo dnf install ffmpeg -y
        elif command -v pacman &>/dev/null; then
            sudo pacman -S ffmpeg --noconfirm
        else
            echo -e "\033[1;33m[~] Please install FFmpeg manually for better performance\033[0m"
        fi
    elif [[ "$OS" == "Darwin" ]]; then
        if command -v brew &>/dev/null; then
            brew install ffmpeg
        else
            echo -e "\033[1;33m[~] Please install FFmpeg manually: brew install ffmpeg\033[0m"
        fi
    elif [[ "$OS" == "MINGW"* ]] || [[ "$OS" == "CYGWIN"* ]]; then
        echo -e "\033[1;33m[~] Please install FFmpeg from https://ffmpeg.org/download.html\033[0m"
    fi
fi

# Install Python dependencies
echo -e "\n\033[1;33m[~] Installing Python dependencies...\033[0m"
python3 -m pip install --upgrade --no-cache-dir \
    yt-dlp \
    requests \
    browser-cookie3 \
    mutagen \
    pycryptodomex \
    websockets \
    urllib3

# Install yt-dlp from master for latest features
echo -e "\n\033[1;33m[~] Installing latest yt-dlp from master...\033[0m"
python3 -m pip install https://github.com/yt-dlp/yt-dlp/archive/master.tar.gz --upgrade --no-cache-dir

# Make script executable
echo -e "\n\033[1;33m[~] Setting up exp-link command...\033[0m"
chmod +x exp-link.py

# Create symlink or alias
if [[ "$OS" == "Linux" ]] || [[ "$OS" == "Darwin" ]]; then
    # Copy to /usr/local/bin for system-wide access
    if [ -d "/usr/local/bin" ]; then
        sudo cp exp-link.py /usr/local/bin/exp-link
        sudo chmod +x /usr/local/bin/exp-link
        echo -e "\033[1;32m[✓] Installed to /usr/local/bin/exp-link\033[0m"
        
        # Also create with repository name
        sudo cp exp-link.py /usr/local/bin/exp-link-unshackled
        sudo chmod +x /usr/local/bin/exp-link-unshackled
        echo -e "\033[1;32m[✓] Installed to /usr/local/bin/exp-link-unshackled\033[0m"
    else
        echo -e "\033[1;33m[~] Add alias to your shell: alias exp-link='python3 $(pwd)/exp-link.py'\033[0m"
    fi
elif [[ "$OS" == "MINGW"* ]] || [[ "$OS" == "CYGWIN"* ]]; then
    echo -e "\033[1;33m[~] On Windows, you can run: python exp-link.py\033[0m"
fi

# Create desktop shortcut (optional)
if [[ "$OS" == "Linux" ]]; then
    if [ -d "$HOME/.local/share/applications" ]; then
        cat > "$HOME/.local/share/applications/exp-link.desktop" << EOF
[Desktop Entry]
Name=EXP-LINK v3.0 UNSHACKLED
Comment=Universal Media Downloader - NO LIMITS
Exec=$PWD/exp-link.py
Icon=$PWD/icon.png
Terminal=true
Type=Application
Categories=Network;AudioVideo;
Keywords=downloader;video;youtube;instagram;tiktok;
EOF
        chmod +x "$HOME/.local/share/applications/exp-link.desktop"
        echo -e "\033[1;32m[✓] Desktop shortcut created\033[0m"
    fi
fi

# Create download directory
mkdir -p "$HOME/Downloads/EXP-LINK_Videos"
echo -e "\033[1;32m[✓] Download directory: $HOME/Downloads/EXP-LINK_Videos\033[0m"

# Create configuration directory
mkdir -p "$HOME/.config/exp-link"
if [ ! -f "$HOME/.config/exp-link/config.json" ]; then
    echo '{"download_path": "$HOME/Downloads/EXP-LINK_Videos", "theme": "dark"}' > "$HOME/.config/exp-link/config.json"
    echo -e "\033[1;32m[✓] Configuration created\033[0m"
fi

echo -e "\n\033[1;32m" + "="*70 + "\033[0m"
echo -e "\033[1;32m[✓] INSTALLATION COMPLETE!\033[0m"
echo -e "\033[1;36m"
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                      HOW TO USE EXP-LINK                         ║"
echo "╠═══════════════════════════════════════════════════════════════════╣"
echo "║                                                                   ║"
echo "║  • Interactive mode:                                              ║"
echo "║    $ exp-link                                                    ║"
echo "║                                                                   ║"
echo "║  • Direct download:                                               ║"
echo "║    $ exp-link https://youtube.com/watch?v=...                   ║"
echo "║    $ exp-link https://instagram.com/p/...                       ║"
echo "║    $ exp-link https://tiktok.com/@user/video/...                ║"
echo "║                                                                   ║"
echo "║  • Batch download from file:                                      ║"
echo "║    $ exp-link --batch urls.txt                                   ║"
echo "║                                                                   ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo -e "\033[0m"

echo -e "\033[1;33mSupported platforms:\033[0m"
echo "  • YouTube (including Shorts & age-restricted)"
echo "  • Instagram (including private profiles)"
echo "  • TikTok (no watermark)"
echo "  • Pinterest (private boards)"
echo "  • Twitter/X (private tweets)"
echo "  • Facebook (private videos)"
echo "  • Reddit, Twitch, Vimeo, Dailymotion"
echo "  • And 100+ more platforms"

# Test installation
echo -e "\n\033[1;33m[~] Testing yt-dlp installation...\033[0m"
YTD_VERSION=$(python3 -m yt_dlp --version 2>/dev/null)
if [ $? -eq 0 ]; then
    echo -e "\033[1;32m[✓] yt-dlp version: $YTD_VERSION\033[0m"
else
    echo -e "\033[1;31m[!] yt-dlp installation failed. Try running: python3 -m pip install --upgrade yt-dlp\033[0m"
fi

# Quick test with example
echo -e "\n\033[1;33m[~] Testing with a sample URL...\033[0m"
python3 exp-link.py --test 2>/dev/null
if [ $? -eq 0 ]; then
    echo -e "\033[1;32m[✓] EXP-LINK is working properly!\033[0m"
else
    echo -e "\033[1;33m[~] Test skipped (no network or test failed)\033[0m"
fi

echo -e "\n\033[1;31m[!] LEGAL NOTICE: Use responsibly and respect content creators' rights\033[0m"
echo -e "\033[1;32m[+] Made by: xspeen 🔓\033[0m"
echo -e "\033[1;32m[+] Repository: https://github.com/xspeen/EXP-LINK-UNSHACKLED\033[0m"
echo -e "\033[1;32m[+] UNSHACKLED - Breaking Digital Chains\033[0m"
