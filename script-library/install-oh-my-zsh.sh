#!/bin/zsh
#
# Install Oh My ZSH
# Optionally, download a custom powerlevel10k config file

set -eo pipefail

readonly P10K_CONFIG_URI=$1

# Download Oh My Zsh! installer and run it
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o - | zsh

# (Optional) Import a powerlevel10k configuration
if [[ -n "${P10K_CONFIG_URI:-}" ]]; then
  echo "Downloading p10k configuration from ${P10K_CONFIG_URI}"
  curl -fsSL ${P10K_CONFIG_URI} -o "${HOME}/.p10k.zsh"
fi

# Define custom themes directory
readonly ZSH_CUSTOM_THEMES="${HOME}/.oh-my-zsh/custom/themes"

# Clone powerlevel10k git repo to ZSH_CUSTOM_THEMES
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM_THEMES}/powerlevel10k/"

# Enable powerlevel10k in .zshrc
echo """
# Enable powerlevel10k theme
source \"${ZSH_CUSTOM_THEMES}/powerlevel10k/powerlevel10k.zsh-theme\"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh""" >> ~/.zshrc

# Disable default zsh theme
sed -i s/^ZSH_THEME=".*"/ZSH_THEME=""/ ~/.zshrc
