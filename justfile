main:
    just css

css:
    sassc src/theme.scss theme.css
    printf '%s\n%s\n' "/* This file is generated; DO NOT EDIT. */" "$(cat theme.css)" > theme.css

preview:
    inkscape -h 1080 src/preview/theme-preview.svg -o generated/theme-preview.png
    inkscape -h 720 src/preview/compare-window-buttons.svg -o generated/compare-window-buttons.png
    inkscape -h 720 src/preview/compare-tabs.svg -o generated/compare-tabs.png
    inkscape -h 720 src/preview/compare-font.svg -o generated/compare-font.png
    inkscape -h 720 src/preview/compare-color.svg -o generated/compare-color.png
    inkscape -h 720 src/preview/compare-icons.svg -o generated/compare-icons.png

watch:
    watchexec -e scss -- bash -c "just css; just install"

install:
    #!/bin/bash
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
