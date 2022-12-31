# Contributing to vscode-textmate-rstheme

:+1::tada: First off, thanks for taking your time to contribute! :tada::+1:

The VS Code [color themes guide](https://code.visualstudio.com/docs/getstarted/themes)
is a good starting point to learn developing color theme extensions.

## Key files

- This folder contains all of the files necessary for the color theme extension.
- `package.json` - this is the manifest file that defines the location of the
  theme file and specifies the base theme of the theme.
- `themes/textmate-rstheme-color-theme.json` - the color theme definition file.

## Test and debug a development version

- Open the extension folder in VS Code.
- Press `F5` to open a new [Extension Development Host] window.
- In the [Extension Development Host] window, click the gear icon,
  select "Color Themes", pick the color theme.
- Open a file that has a language associated in the
  [Extension Development Host] window.
- Changes to the theme JSON file are automatically applied to the
  Extension Development Host window.
- The languages' configured grammar will tokenize the text and assign "scopes"
  to the tokens. To examine these scopes, run the
  `Developer: Inspect Editor Tokens and Scopes` command from the Command Palette
  (`Ctrl+Shift+P` or `Cmd+Shift+P` on Mac). Press `ESC` to quit inspecting.

## Install the extension locally

- [Install vsce](https://code.visualstudio.com/api/working-with-extensions/publishing-extension) from npm.
- Run `vsce package` in the folder. This will create a `.vsix` file in the folder.
- Run the command `Extensions: Install from VSIX...` from the Command Palette and select the `.vsix` file.
- Select the color theme from Color Themes.
