# Everything not ./Makefile or ./bin/ or ./README.md is assumed to be a
# directory containing dotfiles that needs to be moved to ~/.config/
# There's a trick here: if you want to add another folder to be tracked, this
# rule handles it for you automatically
DOTFILES = $(shell ls -I 'README.md' -I 'bin' -I 'Makefile')

.PHONY: all $(DOTFILES) bin
all: $(DOTFILES) bin

# You can build any DOTFILE by creating soft links in ~/.config/$@ to the files
# in ./$@
$(DOTFILES):
	@for file in $(shell find $@ -type f); do \
		dest_dir="$$(dirname $$XDG_CONFIG_HOME/$$file)"; \
		[[ -d "$$dest_dir" ]] \
			|| (echo "Creating $$dest_dir" \
				&& mkdir --parents "$$dest_dir"); \
		echo "creating a soft link at ~/.config/$${file} to $${file}..."; \
		ln -sf "$$(realpath $$file)" $$XDG_CONFIG_HOME/$$file; \
	done

# Make a soft link to files in `./bin` from `$HOME/bin`
bin:
	@[[ -d ~/bin ]] || mkdir ~/bin
	@for file in bin/*; do \
		echo "creating a soft link at ~/$${file} to $${file}..."; \
		ln -sf $$(realpath $$file) ~/$$file; \
	done
