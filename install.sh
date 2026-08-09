#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_root="${XDG_CONFIG_HOME:-${HOME}/.config}"
nvim_dir="${repo_dir}/nvim"
brewfile="${repo_dir}/Brewfile"

link_config() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname -- "${target_path}")"

  if [[ -L "${target_path}" || -e "${target_path}" ]]; then
    if [[ "${target_path}" -ef "${source_path}" ]]; then
      echo "Already linked ${target_path}."
      return
    fi

    local backup_path="${target_path}.backup-$(date +%Y%m%d-%H%M%S)"
    echo "Moving ${target_path} to ${backup_path}."
    mv "${target_path}" "${backup_path}"
  fi

  ln -s "${source_path}" "${target_path}"
  echo "Linked ${target_path} -> ${source_path}."
}

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh and rerun this script." >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Xcode is not selected. Install Xcode, run xcode-select, and rerun this script." >&2
  exit 1
fi

echo "Installing missing command-line dependencies..."
brew bundle install --no-upgrade --file="${brewfile}"

if pipx list --short | awk '{ print $1 }' | grep -qx "pymobiledevice3"; then
  echo "pymobiledevice3 is already installed."
else
  echo "Installing pymobiledevice3..."
  pipx install pymobiledevice3
fi

if gh extension list | grep -qE '(^|[[:space:]])dlvhdr/gh-dash([[:space:]]|$)'; then
  echo "gh-dash is already installed."
else
  echo "Installing gh-dash..."
  gh extension install dlvhdr/gh-dash
fi

lazygit_config_dir="$(lazygit --print-config-dir)"

link_config "${nvim_dir}" "${config_root}/nvim"
link_config "${repo_dir}/configs/lazygit/config.yml" "${lazygit_config_dir}/config.yml"
link_config "${repo_dir}/configs/tuicr/config.toml" "${config_root}/tuicr/config.toml"
link_config "${repo_dir}/configs/gh-dash/config.yml" "${config_root}/gh-dash/config.yml"
link_config "${repo_dir}/configs/herdr/config.toml" "${config_root}/herdr/config.toml"

echo "Starting the Herdr background service..."
brew services start herdr

echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

echo
echo "Development environment installed. Open an Xcode project in Neovim and run :XcodebuildSetup."
