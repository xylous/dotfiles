# Everything not ./Makefile or ./bin/ is assumed to be a directory containing
# dotfiles that shall be moved to ~/.config
# There's a trick here: if you want to add another folder to be tracked, this
# rule handles it for you automatically
DOTFILES = $(shell ls | grep -v -e 'bin' -e 'Makefile')

.PHONY: all $(DOTFILES) bin
all: $(DOTFILES) bin

# You can build any DOTFILE by creating soft links in ~/.config/$@ to the files
# in ./$@
$(DOTFILES):
	@[[ -d "$$XDG_CONFIG_HOME/$@" ]] \
		|| (echo "Creating $$XDG_CONFIG_HOME/$@..." \
			&& mkdir "$$XDG_CONFIG_HOME/$@")
	@for file in $(shell ls -A $@); do \
		echo "creating a soft link at ~/.config/$@/$${file} to $@/$${file}..."; \
		ln -sf "$$(realpath $@/$$file)" $$XDG_CONFIG_HOME/$@/$$file; \
	done

# Make a soft link to files in `./bin` from `$HOME/bin`
bin:
	@[[ -d ~/bin ]] || mkdir ~/bin
	@for file in bin/*; do \
		echo "creating a soft link at ~/$${file} to $${file}..."; \
		ln -sf $$(realpath $$file) ~/$$file; \
	done
