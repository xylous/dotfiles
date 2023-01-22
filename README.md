# xylous' dotfiles

This repository contains most of my dotfiles. Enjoy.

## Directory structure

- `user`: configuration files destined for the user
- `bin`: binaries for the user
- `root`: configuration files destined for root
- `etc`: configuration files destined for `/etc`
- `template`: a README template and various license templates; not actually
    built

## Building dotfiles

The `Makefile` in this repository can be used to make all or just some dotfiles.

**WARNING**: it ***will*** overwrite already existing files. By default, it uses
soft links.

You can run `make` without arguments, in which case it builds all dotfiles, or
with a single argument: the name of a file/directory to build. There are some
specific targets, like `all`, `bin`, `system`, and `superuser` - the first builds
all dotfiles for a given user, the second builds `~/bin`, the third builds
`/etc` (statically linked), and the last builds `/root`. Note how the last two
need to be ran as root.
