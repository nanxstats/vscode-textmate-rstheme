# Changelog

## 2026.1.0

### Improvements

- Restore extensions view action button colors after the CSS cascade fix
  ([microsoft/vscode#276781](https://github.com/microsoft/vscode/issues/276781))
  in VS Code 1.108 (#21).

### Maintenance

- Update development dependencies (`@types/node`) to the latest version (#20).

## 2025.12.0

### Maintenance

- Update development dependencies (`@types/node` and `yaml`) to the
  latest versions (#17).

## 2025.11.1

### Improvements

- Update terminal ANSI yellow colors to improve contrast and readability
  by replacing brown tones with olive yellow hues (thanks, @ZhimingYe, #13).

## 2025.11.0

### Maintenance

- Update development dependencies (`@types/node` and `typescript`) to the
  latest versions (#10).

## 2025.9.0

### Maintenance

- Update development dependencies (`@types/node`) to the latest version (#7).
- Replace `CLAUDE.md` with `AGENTS.md` (#6).

## 2025.8.0

### Improvements

- Replace manual JSON theme maintenance with a TypeScript build pipeline that
  generates the theme from YAML source files. This makes future theme updates
  much easier (#3).

## 2024.2.0

### Improvements

- Add syntax highlighting support and test fixture for Typst.

## 2023.4.0

### Improvements

- Add test fixture for BibTeX.

## 2023.1.5

### New features

- Add syntax highlighting support and test fixture for Sweave.

## 2023.1.4

### Improvements

- Add test fixture for Jupyter Notebook.

## 2023.1.3

### Improvements

- Add support and test fixtures for 8 more programming languages and file formats.
  Most of the test fixtures are from highlight.js demos.

## 2023.1.2

### New features

- Add syntax highlighting support and test fixture for SAS.

## 2023.1.1

### Improvements

- Enable [semantic syntax highlighting](https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide).
- Add `.vscode/launch.json` so that pressing `F5` works out of the box.
- Add installation guide section to `README.md`.

## 2023.1.0

### Improvements

- Add tests for 8 more programming languages and file formats.
- Update test file for Markdown.
- Add a reference link to the original Ace theme.

## 2022.12.0

### New features

- Initial release.
- Working code syntax highlighting and outer UI styling.
- Add test examples for 15 programming languages and file formats.
- Add a logo, a banner, and two screenshots.
- Add a contribution guide.
