English | [简体中文](./README.zh-CN.md)

# gallery.yazi

A terminal image gallery for [Yazi](https://github.com/sxyazi/yazi).

`gallery.yazi` opens a grid-based image browser inside the same terminal session as Yazi. It is built for fast folder browsing, lightweight image review, and selection workflows without replacing Yazi's preview pane and without jumping into a separate GUI app.

## Highlights

- Terminal-native thumbnail grid
- `vim`-style navigation with `hjkl`, `gg`, and `G`
- Mark images with `Space`
- Filter to marked images with `m`
- Single-image view with metadata
- Sync marked images and cursor position back to Yazi on exit

## What It Does

- Opens a thumbnail grid inside the terminal with `\g`
- Browses the current folder or the hovered folder
- Starts near the hovered image when possible
- Supports both arrow keys and `vim`-style navigation
- Lets you mark images with `Space`
- Syncs marked images back to Yazi when you exit
- Supports a marked-only filter for quick review passes
- Includes an in-terminal single-image view with metadata

## Requirements

- Linux or macOS
- [Yazi](https://github.com/sxyazi/yazi)
- A terminal that supports the Kitty graphics protocol
  - [Ghostty](https://ghostty.org/), [kitty](https://sw.kovidgoyal.net/kitty/), and [WezTerm](https://wezfurlong.org/wezterm/) work
  - Works over SSH as long as the local terminal supports the protocol; does not work inside `tmux` or `screen`
    - Over SSH the plugin streams image data inline (`GALLERY_TRANSMIT=direct`, auto-detected); locally it hands the terminal a file path (`GALLERY_TRANSMIT=file`)
  - WezTerm, iTerm2 and other terminals that speak the iTerm2 inline-image protocol are also supported. The plugin asks the terminal which it is at startup; force it with `GALLERY_PROTOCOL=kitty` or `GALLERY_PROTOCOL=iterm2`
- `python3`
- One image backend, tried in this order:
  - ImageMagick 7 (`magick`) or ImageMagick 6 (`convert` + `identify`)
  - [Pillow](https://pypi.org/project/Pillow/) (`pip install pillow`; add `pillow-heif` for HEIC/AVIF)
  - `sips` (macOS only)

## Installation

Clone the repository into your Yazi plugins directory:

```sh
git clone git@github.com:FMVPJet/gallery.yazi.git \
  ~/.config/yazi/plugins/gallery.yazi
```

Or place the plugin manually in:

```sh
~/.config/yazi/plugins/gallery.yazi
```

Add this key binding to your `~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = [ "\\", "g" ]
run  = [
  "plugin gallery -- prepare_selection",
  "shell '~/.config/yazi/plugins/gallery.yazi/gallery.sh %h' --block",
  "plugin gallery -- apply_selection"
]
desc = "Gallery"
```

## Quick Start

1. Open a folder with images in Yazi.
2. Press `\g`.
3. Move with arrow keys or `hjkl`.
4. Mark images with `Space`.
5. Press `q` to return to Yazi with your selection preserved.

## Usage

### Open

- Press `\g` in Yazi
- If the hovered item is a folder, the gallery opens that folder
- If the hovered item is an image, the gallery opens the current folder and starts near that image
- If you already selected images with `Space` in the same folder, the gallery starts in `Selection` mode

### Grid Navigation

- `Left` / `Right` / `Up` / `Down`: move selection
- `h` / `j` / `k` / `l`: move selection with `vim` keys
- `gg`: jump to the first image
- `G`: jump to the last image
- `n`: jump forward by one screen
- `p` or `Backspace`: jump backward by one screen
- `q` or `Esc`: quit and return to Yazi

### Marking and Filtering

- `Space`: mark or unmark the current image
- `m`: toggle a marked-only filter when marked images exist
- Exiting the gallery writes the marked set back to Yazi
- Exiting the gallery also restores your Yazi cursor to the image you were last focused on

### Single-Image View

- `Enter`: open the current image in a larger in-terminal view
- `Left` / `Right` or `h` / `l`: move between images
- `Space`: mark or unmark the current image
- `Enter`, `Esc`, or `q`: return to the grid

The single-image footer shows:

- current mode
- current position
- marked state
- dimensions
- file size
- file format
- modified time

## Interaction Model

- `Directory` mode means the gallery is browsing the full image set for the current target folder
- `Selection` mode means the gallery is browsing only the images that were already selected in Yazi for that folder
- The grid scrolls continuously as you move; it is not locked to fixed pages

## Limitations

- Linux and macOS only (needs a POSIX shell and a Kitty-graphics terminal)
- Requires a Kitty-graphics-compatible terminal for rendering
- Current scope is intentionally local and terminal-based
- This plugin is optimized for image review, not file editing or metadata editing

## Suggested GitHub Extras

- Add a screenshot or GIF to show the grid and single-image view
- Add repository topics such as `yazi`, `yazi-plugin`, `terminal`, `gallery`, and `macos`

## Repository Notes

- The current implementation is terminal-first
- The gallery is designed to stay inside the same terminal session as Yazi
- The plugin favors low-dependency workflows and uses whichever image backend is already installed

## License

[MIT](./LICENSE)
