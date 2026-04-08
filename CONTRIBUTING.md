# Contributing

## Prerequisites

- Git (required for cloning this repository and creating pull requests)

## Language file format

Translation files use the `*.aul2` format. Typical structure:

```text
; Lines starting with ';' are comments.

[ColorHalftone]  ; Script or plugin name (do not translate this line).
サイズ=Size      ; Each line is "JapaneseKey=TranslationValue".
ドットサイズ=Dot Size
回転=Rotate
...
```

## Procedure

Follow these steps to contribute translations or fixes.

### 1. Clone the repository

Clone the repository to your local machine:

```bash
git clone https://github.com/azurite581/aviutl2_translations_azurite.git
```

Repository layout:

```text
aviutl2-translations_azurite/
├─ tools/
│  └─ merge.ps1        # Script to merge language files into a single .aul2 file
└─ Translations/
    ├─ Template/           # Template files for each script/plugin
    │  ├─ ColorHalftone.aul2
    │  └─ ...
    ├─ English/
    │  ├─ ColorHalftone.aul2
    │  └─ ...
    └─ 简体中文/
        ├─ ColorHalftone.aul2
        └─ ...
```

### 2. Edit translation files

Guidelines:

- Keep the format `JapaneseKey=TranslationValue` for each line.
- Maintain consistent terminology across files.

#### A. Correcting translations

If you find an incorrect or awkward translation, edit the value. Example:

```text
# Incorrect: 六角形=Sixagon
# Correct:   六角形=Hexagon
```

- Optionally add your name to the `Translator(s)` field at the top of the file.
- Create a pull request with your change.

#### B. Adding a translation for a specific file

To add a translation for a given script/plugin:

1. Copy the template file from `Translations/Template` (e.g. `ImageCropExport.aul2`) to the target language folder (e.g. `Translations/简体中文`).
2. Translate the copied file (the template is in English by default).
3. Optionally add your name to `Translator(s)`.
4. Open a pull request with the new file.

#### C. Adding a new language (folder)

To add support for a new language:

1. Duplicate `Translations/Template` and rename the copy to the language name (e.g. `한국어`).
2. Translate files in the new folder as needed (translating every file is not required).
3. Optionally add translator credits in each file.
4. Open a pull request.

## Acknowledgements

Thank you for contributing! — your work improves this project for everyone.
