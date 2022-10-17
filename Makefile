# Everything not ./Makefile or ./bin/ or ./README.md or ./etc or ./LICENSE or
# ./root is assumed to be a directory containing dotfiles that needs to be moved
# to ~/.config/ There's a trick here: if you want to add another folder to be
# tracked, this rule handles it for you automatically
DOTFILES 		= $(shell find ./user -path ./user -prune -o -type d)
SYSTEM_DOTFILES = $(shell find ./etc -path ./etc -prune -o -type d)
ROOT_DOTFILES 	= $(shell find ./root -path ./root -prune -o -type d)

.PHONY: all
all: $(DOTFILES) bin

.PHONY: system
system: $(SYSTEM_DOTFILES)

.PHONY: superuser
superuser: $(ROOT_DOTFILES)

# $1 = directory to look in
# $2 = directory in which links should be made
define dynamically_link
	for file in $(shell find $(1) -type f); do \
		orig_file="$$file"; \
		file="$${file#*/}"; \
		mkdir --parents "$(2)"; \
		ln -sf "$$(realpath $$orig_file)" $(2)/$$file \
			&& echo "symlink $(2)/$${file} -> $${orig_file}"; \
	done
endef

# $1 = directory to look in
# $2 = directory in which links should be made
define statically_link
	for file in $(shell find $(1) -type f); do \
		orig_file="$$file"; \
		file="$${file#*/}"; \
		dest_dir="$(2)"; \
		mkdir --parents "$$dest_dir"; \
		cp -f "$$orig_file" "$$dest_dir/$$file" \
			&& echo "copied $${orig_file} -> $$dest_dir/$${file}"; \
	done
endef

.PHONY: $(DOTFILES)
$(DOTFILES):
	@if [[ $${EUID} == 0 ]]; then \
		echo "error: won't create regular dotfiles for root user"; \
		exit 1; \
	fi
	@dest_dir="$${XDG_CONFIG_HOME:-$$HOME/.config}"; \
		$(call dynamically_link,$@,$$dest_dir)

.PHONY: $(ROOT_DOTFILES)
$(ROOT_DOTFILES):
	@if [[ $${EUID} -ne 0 ]]; then \
		echo "error: needs to be ran as root"; \
		exit 1; \
	fi
	@dest_dir="/root/.config" ; \
		$(call dynamically_link,$@,$$dest_dir)

.PHONY: $(ETC_FILES)
$(ETC_FILES):
	@if [[ $${EUID} -ne 0 ]]; then \
		echo "error: needs to be ran as root"; \
		exit 1; \
	fi
	@dest_dir="/etc"; \
		$(call statically_link,$@,$$dest_dir)

# Make a soft link to files in `./bin` from `$HOME/bin`
.PHONY: bin
bin:
	@if [[ $${EUID} == 0 ]]; then \
		echo "error: won't create regular dotfiles for root user"; \
		exit 1; \
	fi
	@dest_dir="$$HOME"; \
		$(call dynamically_link,./bin,$$dest_dir)
