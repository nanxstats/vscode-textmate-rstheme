# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project overview

This is a VS Code color theme extension called "textmate.rstheme" - a light
theme inspired by the TextMate (default) theme in RStudio IDE.
The theme provides syntax highlighting for 30+ programming languages and
file formats with a focus on R, R Markdown, and Quarto.

## Development commands

### Testing and debugging

- Press `F5` in VS Code to open Extension Development Host window for testing
- Run `Developer: Inspect Editor Tokens and Scopes` from Command Palette to examine token scopes

### Building and packaging

- `vsce package` - Create a .vsix file for local installation
- After packaging, use `Extensions: Install from VSIX...` command to install locally

## Architecture and key files

### Core Structure

- `package.json`: Extension manifest defining metadata, VS Code engine requirements, and theme contribution point
- `themes/textmate-rstheme-color-theme.json`: Main theme definition file containing all color mappings for:
  - Editor colors (background, foreground, brackets, line numbers)
  - UI components (buttons, inputs, dropdowns, badges)
  - Outer UI (title bar, activity bar, sidebar, lists)
  - Syntax highlighting token rules

### Testing

- `tests/`: Contains test fixtures for 30+ languages to verify syntax highlighting
  - Each test file demonstrates language-specific syntax features
  - Used during development to visually verify theme colors

### Development workflow

1. Modify `themes/textmate-rstheme-color-theme.json` for color changes
2. Changes auto-apply to Extension Development Host window
3. Use inspector tool to identify token scopes for targeted styling
4. Test against files in `tests/` directory

## Important notes

- Theme targets VS Code version ^1.13.0 or higher
- Base theme is "vs" (light theme)
- Semantic syntax highlighting is enabled
- Colors derived from RStudio IDE TextMate theme and GitHub Light Default theme
