main:
    just css

css:
    sassc src/adwaita.scss adwaita.css
    printf '%s\n%s\n' "/* This file is generated; DO NOT EDIT. */" "$(cat adwaita.css)" > adwaita.css

preview:
    inkscape -h 1080 src/preview/theme-preview.svg -o generated/theme-preview.png
    inkscape -h 720 src/preview/compare-window-buttons.svg -o generated/compare-window-buttons.png
    inkscape -h 720 src/preview/compare-tabs.svg -o generated/compare-tabs.png
    inkscape -h 720 src/preview/compare-font.svg -o generated/compare-font.png
    inkscape -h 720 src/preview/compare-color.svg -o generated/compare-color.png
    inkscape -h 720 src/preview/compare-icons.svg -o generated/compare-icons.png

watch:
    watchexec -e scss -- just css

