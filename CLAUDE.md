# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project overview

This is a VS Code color theme extension called "textmate.rstheme" - a light
theme inspired by the TextMate (default) theme in RStudio IDE.
The theme provides syntax highlighting for 30+ programming languages and
file formats with a focus on R, R Markdown, and Quarto.

## Development commands

### Theme development

- `npm run build` - Build theme from YAML source files to JSON
- `npm run build:watch` - Build theme in watch mode (rebuilds on changes)
- `npm run prebuild` - TypeScript type checking only

### Testing and debugging

- Press `F5` in VS Code to open Extension Development Host window for testing
- Run `Developer: Inspect Editor Tokens and Scopes` from Command Palette to examine token scopes

## Architecture and key files

### Core Structure

- `package.json`: Extension manifest defining metadata, VS Code engine requirements, and theme contribution point
- `themes/textmate-rstheme-color-theme.json`: Generated theme definition file (do not edit directly)
- `src/theme/`: YAML source files for theme definition:
  - `base.yaml`: Core editor colors, bracket highlighting, line numbers
  - `ui.yaml`: UI components (buttons, inputs, dropdowns, badges)
  - `workbench.yaml`: Outer UI (title bar, activity bar, sidebar, lists, navigation)
  - `terminal.yaml`: Terminal color palette
  - `scm.yaml`: Git/SCM related colors (gutter, decorations, diff editor)
  - `tokens.yaml`: General syntax highlighting token rules
  - `languages.yaml`: Language-specific token rules (HTML, CSS, Python, etc.)
  - `markup.yaml`: Markup language token rules (Markdown, etc.)
  - `semantic.yaml`: Semantic token colors

### Build system

- `src/build.ts`: TypeScript build script that converts YAML files to JSON
- `tsconfig.json`: TypeScript configuration for the build system

### Testing

- `tests/`: Contains test fixtures for 30+ programming languages to verify syntax highlighting
  - Each test file demonstrates language-specific syntax features
  - Used during development to visually verify theme colors

### Development workflow

1. Modify YAML files in `src/theme/` for color changes
2. Run `npm run build` to generate JSON theme file
3. Changes auto-apply to Extension Development Host window
4. Use inspector tool to identify token scopes for targeted styling
5. Test against files in `tests/` directory

## Important notes

- Theme targets VS Code version ^1.13.0 or higher
- Base theme is "vs" (light theme)
- Semantic syntax highlighting is enabled
- Colors derived from RStudio IDE TextMate theme and GitHub Light Default theme
- **Always run `npm run build` after modifying YAML source files**
- The JSON theme file is generated and should not be edited directly
- YAML source files provide better maintainability and organization
- YAML keys must match VS Code's expected JSON structure (use quoted keys for complex paths)
