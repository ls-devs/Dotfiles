# Installation

## Dependencies

```kitty
yay -Syu alacritty autorandr bat beautyline catppuccin-cursors-mocha catppuccin-gtk-theme-mocha dunst ripgrep feh fzf ghc ghcup-hs-bin git haskell-utf8-string haskell-x11 kitty lazygit libnotify lxappearance nerd-fonts-git nodejs polybar picom playerctl python-pip rofi stack starship ttf-font-awesome ttf-material-icons-git unclutter xcape xdo xorg-xinit xorg-xmessage xorg-xsetroot zoxide network-manager-applet acpi betterlockscreen lightdm lightdm-webkit2-greeter ligthm-webkit-theme-aether xf86-video-intel brave-bin discord ranger vim git
```

## Shell

```kitty
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S spaceship-prompt
```

## Process

```kitty
git clone https://github.com/ls-devs/Dotfiles

mkdir -p ~/.config
cd Dotfiles && cp * -r ~/.config

cd ~/.config/xmonad/
git clone https://github.com/xmonad/xmonad.git
git clone https://github.com/xmonad/xmonad-contrib.git

stack init
stack install
sudo ln -s ~/.local/bin/xmonad /usr/bin
xmonad --recompile && xmonad --restart

cd ~/.config/x
mv xorg.conf /etc/X11/
mv xorg.cond.d /etc/X11/
mv .xinitrc ~/
mv .Xmodmap ~/

cd && rm -r ~/.config/x

cd ~/.config/zsh
mv .zsh -r ~/
mv .zshrc ~/
cd && rm -r ~/.config/zsh
```

## Spotify

```kitty
flatpak install flathub com.spotify.Client
flatpak run com.spotify.Client
pip install dbus-python
```

## Battery notifications

```kitty
systemctl --user enable batterymon.service
```
