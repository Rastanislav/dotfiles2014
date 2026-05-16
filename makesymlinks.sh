#!/usr/bin/env bash
# Create symlinks from ~/dotfiles2014 (or repo checkout) into $HOME.
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
olddir="${HOME}/dotfiles_old"
files="bashrc vimrc zshrc zpreztorc tmux.conf"

echo "Creating ${olddir} for backup of any existing dotfiles in ~"
mkdir -p "${olddir}"

for file in ${files}; do
  if [[ -e "${HOME}/.${file}" && ! -L "${HOME}/.${file}" ]]; then
    echo "Backing up ~/.${file} -> ${olddir}/"
    mv "${HOME}/.${file}" "${olddir}/"
  elif [[ -L "${HOME}/.${file}" ]]; then
    echo "Removing old symlink ~/.${file}"
    rm "${HOME}/.${file}"
  fi
  echo "Linking ${dir}/.${file} -> ~/.${file}"
  ln -sf "${dir}/.${file}" "${HOME}/.${file}"
done

if [[ -d "${HOME}/.vim" && ! -L "${HOME}/.vim" ]]; then
  echo "Backing up ~/.vim -> ${olddir}/vim"
  mv "${HOME}/.vim" "${olddir}/vim"
elif [[ -L "${HOME}/.vim" ]]; then
  rm "${HOME}/.vim"
fi
echo "Linking ${dir}/vim -> ~/.vim"
ln -sf "${dir}/vim" "${HOME}/.vim"

echo "Done. Install vim-plug, then in vim run :PlugInstall"
