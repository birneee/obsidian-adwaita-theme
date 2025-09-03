ADW_ICON_THEME_REPO := "https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/raw/master/Adwaita"

# List of icons (repo paths)
ADW_ICONS := \
	/symbolic/ui/window-close-symbolic.svg \
	/symbolic/ui/window-maximize-symbolic.svg \
	/symbolic/ui/window-minimize-symbolic.svg \
	/symbolic/actions/sidebar-show-symbolic.svg \
	/symbolic/actions/sidebar-show-right-symbolic.svg \
	/symbolic/actions/tab-new-symbolic.svg \
	/symbolic/actions/view-more-symbolic.svg \
	/symbolic/actions/go-down-symbolic.svg \
	/symbolic/status/folder-visiting-symbolic.svg \
	/symbolic/places/folder-saved-search-symbolic.svg \
	/symbolic/mimetypes/x-office-document-symbolic.svg

# Filenames only (flat directory)
ADW_ICON_FILES := $(notdir $(ADW_ICONS))

theme.css: src/theme.scss generated/_adw_icons.scss
	sassc src/theme.scss theme.css
	printf '%s\n%s\n' "/* This file is generated; DO NOT EDIT. */" "$$(cat theme.css)" > theme.css

# Rule to download individual icons (flat structure)
build/adw-icons/%:
	mkdir -p ./build/adw-icons
	wget -nc -O $@ https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/raw/master/Adwaita/$(filter %/$*, $(ADW_ICONS))

# SCSS output depends on all icons
generated/_adw_icons.scss: $(ADW_ICON_FILES:%=build/adw-icons/%)
	mkdir -p $(dir $@)
	@echo "// This file is generated; DO NOT EDIT." > $@
	@echo ":root {" >> $@
	@for f in ./build/adw-icons/*.svg; do \
		NAME=$$(basename $$f .svg); \
		echo "    --adwaita-icon-$$NAME: url(\"data:image/svg+xml;base64,$$(base64 -w 0 $$f)\");" >> $@; \
		echo "add $$NAME to $@"; \
	done
	@echo "}" >> $@

.PHONY: watch
watch:
	watchexec -e scss -- bash -c "make; make install"

.PHONY: install
install: theme.css
	@if ! [ -d "$${OBSIDIAN_HOME}" ]; then \
		echo "failed to install: environment variable OBSIDIAN_HOME not set or does not exist"; exit 1; \
	fi
	@if ! [ -d "$${OBSIDIAN_HOME}/.obsidian" ]; then \
		echo "failed to install: $$OBSIDIAN_HOME/.obsidian does not exist"; exit 1; \
	fi
	mkdir -p "$${OBSIDIAN_HOME}/.obsidian/themes/Adwaita"
	cp manifest.json "$${OBSIDIAN_HOME}/.obsidian/themes/Adwaita/manifest.json"
	cp theme.css "$${OBSIDIAN_HOME}/.obsidian/themes/Adwaita/theme.css"
	@echo "installed at $${OBSIDIAN_HOME}/.obsidian/themes/Adwaita"

.PHONY: preview
preview:
	inkscape -h 1080 src/preview/theme-preview.svg -o generated/theme-preview.png
	inkscape -h 288 src/preview/theme-preview.svg -o generated/theme-store-preview.png
	inkscape -h 480 src/preview/compare-window-buttons.svg -o generated/compare-window-buttons.png
	inkscape -h 480 src/preview/compare-tabs.svg -o generated/compare-tabs.png
	inkscape -h 480 src/preview/compare-font.svg -o generated/compare-font.png
	inkscape -h 480 src/preview/compare-color.svg -o generated/compare-color.png
	inkscape -h 480 src/preview/compare-icons.svg -o generated/compare-icons.png
