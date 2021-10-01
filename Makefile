# Everything not ./Makefile or ./bin/ or ./README.md ./etc is assumed to be a
# directory containing dotfiles that needs to be moved to ~/.config/
# There's a trick here: if you want to add another folder to be tracked, this
# rule handles it for you automatically
DOTFILES = $(shell ls -I 'README.md' -I 'bin' -I 'Makefile' -I 'etc')
SYSTEM_DOTFILES = $(shell find etc -type d)

.PHONY: all $(DOTFILES) $(SYSTEM_DOTFILES) bin system
all: $(DOTFILES) bin

system: $(SYSTEM_DOTFILES)

# You can build any DOTFILE by creating soft links in ~/.config/$@ to the files
# in ./$@
$(DOTFILES):
	@for file in $(shell find $@ -type f); do \
		dest_dir="$$(dirname $$XDG_CONFIG_HOME/$$file)"; \
		mkdir --parents "$$dest_dir"; \
		echo "creating a soft link at ~/.config/$${file} to $${file}..."; \
		ln -sf "$$(realpath $$file)" ~/.config/$$file; \
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
	@[[ -d ~/bin ]] || mkdir ~/bin
	@for file in bin/*; do \
		echo "creating a soft link at ~/$${file} to $${file}..."; \
		ln -sf $$(realpath $$file) ~/$$file; \
	done
