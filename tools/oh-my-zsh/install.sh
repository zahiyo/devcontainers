#!/bin/zsh

set -e

P10K_CONFIG_URI=$1

# Install Oh My Zsh!
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o - | zsh

# Import the powerlevel10k configuration
[ -n "${P10K_CONFIG_URI}" ] && curl -fsSL -o $HOME/.p10k.zsh ${P10K_CONFIG_URI}

# Install powerlevel10k theme
ZSH_CUSTOM_THEMES=~/.oh-my-zsh/custom/themes

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM_THEMES}/powerlevel10k/
echo "
# Enable powerlevel10k theme
source \"${ZSH_CUSTOM_THEMES}/powerlevel10k/powerlevel10k.zsh-theme\"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

# Disable zsh theme
sed -i s/^ZSH_THEME=".*"/ZSH_THEME=""/ ~/.zshrc
