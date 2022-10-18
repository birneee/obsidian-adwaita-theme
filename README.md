# Obsidian Adwaita Theme

This is an [Obisidian](https://obsidian.md/) theme in the style of [Gnome](https://www.gnome.org/) [Adwaita](https://en.wikipedia.org/wiki/Adwaita_(design_language)). The goal of this project is to make Obsidian look more native on Gnome Desktop Environments like on [Ubuntu](https://ubuntu.com/) or [Fedora](https://getfedora.org/). 

![](generated/theme-preview.png)

## Features 

<table>
<tr>
<td>

### Window Buttons
<img src="generated/compare-window-buttons.png">

### Tabs
<img src="generated/compare-tabs.png">

### Icons
<img src="generated/compare-icons.png">

### Dark and Light Theme
Change under `Settings > Options > Appearance > Base color scheme`.

</td>
<td>

### Colors
<img src="generated/compare-color.png">

### Font
<img src="generated/compare-font.png">

### Style Settings Plugin Support
For customization see [Style Settings](#style-settings).

### TBD Rounded Window Corners
As a workaround use the [Rounded Window Corners](https://extensions.gnome.org/extension/5237/rounded-window-corners/) Gnome Extension.

</td>
</tr>
</table>

## Installation

1. Copy `adwaita.css` to your `.obsidian/snippets` folder
2. In Obsidian go to `Settings > 
Options > Appearance > CSS snippets` and enable the `adwaita` snippet
3. Optionally install the [Obsidian Style Settings Plugin](https://github.com/mgmeyers/obsidian-style-settings) for customization. Adjust under `Settings > Community Plugins > Style Settings > Adwaita`

## Build

- Install [just](https://github.com/casey/just) and [sassc](https://github.com/sass/sassc)
- Run `just`

## Style Settings
Requires the [Obsidian Style Settings Plugin](https://github.com/mgmeyers/obsidian-style-settings).
Adjust under `Settings > Community Plugins > Style Settings > Adwaita`.

![](src/preview/style-settings.png)

## Contribution
Feel free to create Issues and Pull Requests.
