#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="${HOME}/.config/nvim"
brewfile="${repo_dir}/Brewfile"

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

mkdir -p "$(dirname -- "${config_dir}")"

if [[ -L "${config_dir}" || -e "${config_dir}" ]]; then
  if [[ "${config_dir}" -ef "${repo_dir}" ]]; then
    echo "Neovim already uses ${repo_dir}."
  else
    backup_dir="${config_dir}.backup-$(date +%Y%m%d-%H%M%S)"
    echo "Moving the existing Neovim configuration to ${backup_dir}."
    mv "${config_dir}" "${backup_dir}"
    ln -s "${repo_dir}" "${config_dir}"
    echo "Linked ${config_dir} -> ${repo_dir}."
  fi
else
  ln -s "${repo_dir}" "${config_dir}"
  echo "Linked ${config_dir} -> ${repo_dir}."
fi

echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

echo
echo "Installation complete. Open an Xcode project in Neovim and run :XcodebuildSetup."
