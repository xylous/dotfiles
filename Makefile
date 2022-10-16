# Everything not ./Makefile or ./bin/ or ./README.md or ./etc or ./LICENSE or
# ./root is assumed to be a directory containing dotfiles that needs to be moved
# to ~/.config/ There's a trick here: if you want to add another folder to be
# tracked, this rule handles it for you automatically
DOTFILES = $(shell ls -I 'README.md' -I 'bin' -I 'Makefile' -I 'etc' -I 'LICENSE' -I 'root')
SYSTEM_DOTFILES = $(shell find ./etc -type d)
ROOT_DOTFILES = $(shell find ./root -path ./root -prune -o -type d)

.PHONY: all $(DOTFILES) $(SYSTEM_DOTFILES) $(ROOT_DOTFILES) bin system superuser
all: $(DOTFILES) bin

system: $(SYSTEM_DOTFILES)

superuser: $(ROOT_DOTFILES)

# You can build any DOTFILE by creating soft links in ~/.config/$@ to the files
# in ./$@
$(DOTFILES):
	@if [[ $${EUID} == 0 ]]; then \
		echo "error: won't create regular dotfiles for root user"; \
		exit 1; \
	fi
	@for file in $(shell find $@ -type f); do \
		file="$${file/user\//}" \
		dest_dir="$$(dirname $$XDG_CONFIG_HOME/$$file)"; \
		mkdir --parents "$$dest_dir"; \
		echo "creating a soft link at ~/.config/$${file} to $${file}..."; \
		ln -sf "$$(realpath ./user/$$file)" ~/.config/$$file; \
	done

# You can build any DOTFILE for the root user by creating soft links in
# /root/.config/$@ to the files in ./$@
$(ROOT_DOTFILES):
	@if [[ $${EUID} -ne 0 ]]; then \
		echo "error: needs to be ran as root"; \
		exit 1; \
	fi
	@for file in $(shell find $@ -type f); do \
		file="$${file/root\//}" \
		dest_dir="$$(dirname /root/.config/$$file)"; \
		mkdir --parents "$$dest_dir"; \
		echo "creating a soft link at /root/.config/$${file} to ./root/$${file}..."; \
		ln -sf "$$(realpath ./root/$$file)" /root/.config/$$file; \
	done

$(SYSTEM_DOTFILES):
	@if [[ $${EUID} -ne 0 ]]; then \
		echo "error: needs to be ran as root"; \
		exit 1; \
	fi
	@for file in $(shell find $@ -maxdepth 1 -type f); do \
		dest_dir="$$(dirname /$$file)"; \
		mkdir --parents "$$dest_dir"; \
		echo "copying ./$${file} to /$${file}"; \
		cp ./$$file /$$file; \
	done

# Make a soft link to files in `./bin` from `$HOME/bin`
bin:
	@if [[ $${EUID} == 0 ]]; then \
		echo "error: won't create regular dotfiles for root user"; \
		exit 1; \
	fi
	@[[ -d ~/bin ]] || mkdir ~/bin
	@for file in bin/*; do \
		echo "creating a soft link at ~/$${file} to $${file}..."; \
		ln -sf $$(realpath $$file) ~/$$file; \
	done
