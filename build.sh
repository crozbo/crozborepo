#!/usr/bin/env bash
#
# Name: build.sh
# Descripiton: Rebuilding arch repo, db, files and signatures
# Author: crozbo


# protection for script errors
set -euo pipefail

#name of repo
repo="crozborepo"
# gpg key for sign db, gpg is in user gpg keyring
gpgkey="crozbo"


# TODO copy packages files and signatures to x86_64

# x86_64
echo "======================================"
echo "Building x86_64 repo database."
echo "======================================"

# cleaning
rm -fv $repo*

# update repo, add/remove packages from db and sign
# -n: add new packages not already in db
# -R: remove old packages files when update their entry
# -s: sings db
# -k <gpgkey>: spcified key to sing db
repo-add -n -R -v -s -k $gpgkey $repo.db.tar.gz *.pkg.tar.zst

# remove symlinks - not work wiht git
echo "Deleting symlinks."
rm -v $repo.db
rm -v $repo.db.sig
rm -v $repo.files
rm -v $repo.files.sig

# renaming tar.gz extension
echo "Renaming generated files"
mv -v $repo.db.tar.gz $repo.db
mv -v $repo.db.tar.gz.sig $repo.db.sig
mv -v $repo.files.tar.gz $repo.db.files
mv -v $repo.files.tar.gz.sig $repo.db.files.sig

echo "======================================"
echo "Repository updated."
echo "======================================"
