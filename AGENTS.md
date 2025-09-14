# AGENTS.md

## Project overview

This repository contains a VS Code color theme extension named "textmate.rstheme" - a light theme inspired by the TextMate (default) theme in RStudio IDE. It offers syntax highlighting for 30+ languages and formats, with emphasis on R, R Markdown, and Quarto.

## Source of truth vs. generated files

- Edit only the YAML source files in `src/theme/`.
- Run the build to generate the theme JSON at `themes/textmate-rstheme-color-theme.json`.
- Do not edit `themes/textmate-rstheme-color-theme.json` directly (it is generated).
- The build system is implemented in `src/build.ts` (TypeScript via `ts-node`).

## Commands

- `npm run prebuild` - TypeScript type-check of the build system (no emit)
- `npm run build` - Build YAML sources into the JSON theme
- `npm run build:watch` - Build in watch mode (rebuilds on changes)

## Repository structure

- `package.json` - Extension manifest (do not change identifiers unless explicitly requested)
- `src/build.ts` - Build script converting YAML -> JSON (change only if build behavior must be adjusted)
- `src/theme/` - Authoritative theme sources:
  - `base.yaml` - Core editor colors, bracket highlighting, line numbers
  - `ui.yaml` - UI components (buttons, inputs, dropdowns, badges)
  - `workbench.yaml` - Outer UI (title bar, activity bar, sidebar, lists, navigation)
  - `terminal.yaml` - Terminal color palette
  - `scm.yaml` - Git/SCM colors (gutter, decorations, diff editor)
  - `tokens.yaml` - General syntax token rules
  - `languages.yaml` - Language-specific token rules (HTML, CSS, Python, etc.)
  - `markup.yaml` - Markup token rules (Markdown, etc.)
  - `semantic.yaml` - Semantic token colors
- `themes/textmate-rstheme-color-theme.json` - Generated JSON theme (do not edit)
- `tests/` - Language fixtures for visual verification during development

## Guardrails for agents

- Prefer minimal, surgical diffs scoped to the request.
- Do not edit generated files; modify YAML sources and rebuild.
- Preserve extension identifiers and metadata in `package.json`:
  - `name`: `textmate-rstheme`
  - `displayName`: `textmate.rstheme`
  - `contributes.themes[0].label`: `textmate.rstheme`
  - `contributes.themes[0].uiTheme`: `vs`
  - `contributes.themes[0].path`: `./themes/textmate-rstheme-color-theme.json`
- Avoid adding or changing dependencies unless explicitly requested.
- Keep style consistent; do not mass-reformat unrelated files.
- YAML:
  - Quote keys containing dots (e.g., `"editorBracketHighlight.foreground1"`).
  - Maintain indentation; avoid duplicate keys; keep arrays ordered and stable.
  - Token entries follow `{ name, scope, settings }`; `scope` may be a string or array.
- Do not raise VS Code engine requirements (`engines.vscode`) without approval.

## Typical tasks and where to change things

- Adjust core editor visuals -> `src/theme/base.yaml`
- Tweak workbench/UI colors -> `src/theme/ui.yaml`, `src/theme/workbench.yaml`
- Update terminal palette -> `src/theme/terminal.yaml`
- Update Git/SCM colors -> `src/theme/scm.yaml`
- Modify general token colors -> `src/theme/tokens.yaml`
- Add/adjust language-specific tokens -> `src/theme/languages.yaml`
- Update Markdown/markup tokens -> `src/theme/markup.yaml`
- Add/modify semantic token colors -> `src/theme/semantic.yaml` (semantic highlighting is enabled)

### Example: adding a new token color

Add to `src/theme/tokens.yaml` (or a language-specific section):

```yaml
tokenColors:
  - name: Function Calls
    scope:
      - meta.function-call
      - variable.function
    settings:
      foreground: '#123456'
```

Then run `npm run build` to regenerate the JSON theme.

## Build, test, and debug

1. Run `npm run prebuild` to type-check the build script.
2. Run `npm run build` (or `npm run build:watch`) after YAML changes.
3. For manual visual testing, use VS Code:
   - Press `F5` to open an Extension Development Host.
   - Select the theme and open files from `tests/`.
   - Use `Developer: Inspect Editor Tokens and Scopes` to examine scopes.

## Verification checklist (before submitting changes)

- Build succeeds with no TypeScript or runtime errors.
- `themes/textmate-rstheme-color-theme.json` is regenerated and valid JSON.
- No direct edits to generated JSON; YAML sources remain the truth.
- Theme identifiers and `package.json` metadata are unchanged unless requested.
- Changes are narrowly scoped and consistent with existing color philosophy
  (inspired by RStudio TextMate and GitHub Light Default).

## Additional notes

- Target VS Code `^1.13.0`; base theme is `vs` (light).
- Semantic highlighting is enabled.
- YAML keys must match VS Code's expected JSON structure; quote complex paths.
- If in doubt about correct token scopes, rely on the Inspector tool.

## Scope of changes

Unless explicitly requested, do not:

- Bump versions, change licensing, or alter publishing metadata.
- Rename the theme, change its label, or move theme paths.
- Introduce new build tooling or external services.
- Remove files from `tests/` or change their content semantics.
