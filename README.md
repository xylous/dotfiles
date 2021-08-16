# xylous' dotfiles

This repository contains most of my dotfiles. Enjoy.

## Building dotfiles

The `Makefile` in this repository can be used to make all or just some dotfiles.

**WARNING**: it ***will*** overwrite already existing files. By default, it uses
soft links.

You can run `make` without arguments, in which case it builds all dotfiles, or
with a single argument: the name of a file/directory to build.
