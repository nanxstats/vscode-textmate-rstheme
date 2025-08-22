#!/usr/bin/env node

import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'yaml';

interface TokenColor {
  name: string;
  scope: string | string[];
  settings: {
    foreground?: string;
    fontStyle?: string;
  };
}

interface ThemeDefinition {
  name: string;
  colors: { [key: string]: string };
  tokenColors: TokenColor[];
  semanticHighlighting?: boolean;
  semanticTokenColors?: { [key: string]: string };
}

function loadYamlFile(filePath: string): any {
  const content = fs.readFileSync(filePath, 'utf8');
  return yaml.parse(content);
}

function flattenObject(obj: any, prefix: string = '', result: { [key: string]: string } = {}): { [key: string]: string } {
  for (const [key, value] of Object.entries(obj)) {
    const newKey = prefix ? `${prefix}.${key}` : key;

    if (value && typeof value === 'object' && !Array.isArray(value)) {
      flattenObject(value, newKey, result);
    } else if (typeof value === 'string') {
      result[newKey] = value;
    }
  }

  return result;
}

function collectTokenColors(data: any): TokenColor[] {
  const tokens: TokenColor[] = [];

  function findTokenArrays(obj: any): void {
    if (Array.isArray(obj)) {
      if (obj.length > 0 && obj[0].name && obj[0].scope && obj[0].settings) {
        tokens.push(...obj);
      }
    } else if (obj && typeof obj === 'object') {
      Object.values(obj).forEach(findTokenArrays);
    }
  }

  findTokenArrays(data);
  return tokens;
}

function buildTheme(): ThemeDefinition {
  const themePath = path.join(__dirname, 'theme');
  const yamlFiles = fs.readdirSync(themePath).filter(file => file.endsWith('.yaml'));

  let themeName = 'textmate.rstheme';
  const allColors: { [key: string]: string } = {};
  const allTokens: TokenColor[] = [];
  let semanticTokenColors: { [key: string]: string } = {};

  for (const file of yamlFiles) {
    const data = loadYamlFile(path.join(themePath, file));

    if (data.name) {
      themeName = data.name;
    }

    if (data.semanticTokenColors) {
      Object.assign(semanticTokenColors, data.semanticTokenColors);
    }

    const flattenedColors = flattenObject(data);
    // Filter out non-color properties like 'name'
    for (const [key, value] of Object.entries(flattenedColors)) {
      if (key !== 'name' && !key.startsWith('semanticTokenColors')) {
        allColors[key] = value;
      }
    }

    const tokens = collectTokenColors(data);
    allTokens.push(...tokens);
  }

  return {
    name: themeName,
    colors: allColors,
    tokenColors: allTokens,
    semanticHighlighting: true,
    semanticTokenColors
  };
}

function writeTheme(theme: ThemeDefinition, outputPath: string): void {
  const jsonContent = JSON.stringify(theme, null, '\t');
  fs.writeFileSync(outputPath, jsonContent);
  console.log(`Theme built successfully: ${outputPath}`);
}

function main(): void {
  try {
    const theme = buildTheme();
    const outputPath = path.join(__dirname, '..', 'themes', 'textmate-rstheme-color-theme.json');
    writeTheme(theme, outputPath);
  } catch (error) {
    console.error('Error building theme:', error);
    process.exit(1);
  }
}

if (require.main === module) {
  main();
}

export { buildTheme, writeTheme };
