# Installation

<!--toc:start-->

- [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Shell](#shell)
  - [Install](#install)
  - [Spotify](#spotify)
  - [Battery notifications](#battery-notifications)
  - [Greeter](#greeter)
  - [GTK](#gtk)
  <!--toc:end-->

## Yay

```kitty
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Dependencies

```kitty
yay -Syu alacritty autorandr bat beautyline catppuccin-cursors-mocha \
catppuccin-gtk-theme-mocha dunst ripgrep feh fzf ghc ghcup-hs-bin git \
haskell-utf8-string haskell-x11 kitty lazygit libnotify lxappearance \
nerd-fonts-git nodejs polybar picom playerctl python-pip rofi stack starship \
ttf-font-awesome ttf-material-icons-git unclutter xcape xdo xorg-xinit \
xorg-xmessage xorg-xsetroot zoxide network-manager-applet acpi betterlockscreen \
xf86-video-intel brave-bin discord ranger vim git imagemagick vi sddm \
thunar spotify
```

## Shell

```kitty
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S spaceship-prompt
```

## Install

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
pip install dbus-python
git clone https://github.com/catppuccin/spicetify.git
cd spicetify

cp -r catppuccin-* ~/.config/spicetify/Themes/
cp js/* ~/.config/spicetify/Extensions/

spicetify config current_theme catppuccin-mocha
spicetify config color_scheme lavender
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify config extensions catppuccin-mocha.js

spicetify update
spicetify apply
```

## Battery notifications

```kitty
systemctl --user enable batterymon.service
```

## Greeter

```kitty
cp Dotfiles/usr/share/* -r /usr/share/
sudo systemctl enable sddm.service
```

## GTK

```kitty
# Select Catppuccin in lxappearance
lxappearance
```

## Bat

```kitty
bat --cache build
```
