main:
    just css

adw_icon_theme_repo := "https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/raw/43/Adwaita/scalable"
adw_icon_download_dir := "./build/adw-icons"

adw-icons:
    mkdir -p {{adw_icon_download_dir}}
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/ui/window-close-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/ui/window-maximize-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/ui/window-minimize-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/actions/sidebar-show-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/actions/sidebar-show-right-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/actions/tab-new-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/actions/view-more-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/actions/go-down-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/status/folder-visiting-symbolic.svg"
    - wget -nc -P {{adw_icon_download_dir}} "{{adw_icon_theme_repo}}/places/folder-saved-search-symbolic.svg"

adw_icons_scss_output := "./generated/_adw_icons.scss"

adw-icons-scss:
    #!/usr/bin/env bash
    mkdir -p ./generated
    echo -e "// This file is generated; DO NOT EDIT.\n" > {{adw_icons_scss_output}}
    echo ":root {" >> {{adw_icons_scss_output}}
    SVG_FILES="{{adw_icon_download_dir}}/*.svg"
    for f in $SVG_FILES
    do
        NAME=${f##*/}
        NAME=${NAME%.svg}
        echo -e "    --adwaita-icon-${NAME}: url(\"data:image/svg+xml;base64,$(base64 -w 0 $f)\");" >> {{adw_icons_scss_output}}
    done
    echo "}" >> {{adw_icons_scss_output}}


css:
    sassc src/theme.scss theme.css
    printf '%s\n%s\n' "/* This file is generated; DO NOT EDIT. */" "$(cat theme.css)" > theme.css

preview:
    inkscape -h 1080 src/preview/theme-preview.svg -o generated/theme-preview.png
    inkscape -h 288 src/preview/theme-preview.svg -o generated/theme-store-preview.png
    inkscape -h 720 src/preview/compare-window-buttons.svg -o generated/compare-window-buttons.png
    inkscape -h 720 src/preview/compare-tabs.svg -o generated/compare-tabs.png
    inkscape -h 720 src/preview/compare-font.svg -o generated/compare-font.png
    inkscape -h 720 src/preview/compare-color.svg -o generated/compare-color.png
    inkscape -h 720 src/preview/compare-icons.svg -o generated/compare-icons.png

watch:
    watchexec -e scss -- bash -c "just css; just install"

install:
    #!/usr/bin/env bash
    if ! [[ -d "${OBSIDIAN_HOME}" ]]; then
        echo "failed to install: environment variable OBSIDIAN_HOME not set or does not exist"; exit 1
    fi
    if ! [ -d "${OBSIDIAN_HOME}/.obsidian" ]; then
        echo "failed to install: \$OBSIDIAN_HOME/.obsidian does not exist"; exit 1
    fi
    mkdir -p "${OBSIDIAN_HOME}/.obsidian/themes/Adwaita"
    cp manifest.json "${OBSIDIAN_HOME}/.obsidian/themes/Adwaita/manifest.json"
    cp theme.css "${OBSIDIAN_HOME}/.obsidian/themes/Adwaita/theme.css"
    echo "installed at ${OBSIDIAN_HOME}/.obsidian/themes/Adwaita"
