# Concatenate all *.aul2 files within the specified directory into a single file, sorted by filename in ascending order.
#
# Usage:
#   .\merge.ps1 -input_dir "path\to\input" -output "path\to\output"
#
# Parameters:
#   -input_dir: Directory containing the *.aul2 files to merge. Defaults to the current directory if not specified.
#   -output: Output file path (directory + filename). If directory doesn't exist it will be created.
#            If filename has no extension, `.aul2` will be appended.
#
# Usage example:
#   .\tools\merge.ps1 -input_dir ".\Translations\English" -output ".\out\English.azurite.aul2"

param(
    [string]$input_dir,
    [string]$output
)

if ([string]::IsNullOrWhiteSpace($input_dir)) {
    $input_dir = Convert-Path .
}

$files = Get-ChildItem -Path $input_dir -Filter *.aul2 -File
if (-not $files) {
    throw "No *.aul2 files found in input_dir '$input_dir'."
}

if ([string]::IsNullOrWhiteSpace($output)) {
    $out_candidate = Join-Path (Convert-Path .) 'out.aul2'
} else {
    $out_candidate = $output
}

if ($out_candidate.EndsWith('\') -or $out_candidate.EndsWith('/') -or (Test-Path -LiteralPath $out_candidate -PathType Container)) {
    $out_candidate = Join-Path $out_candidate 'merged.aul2'
}

if ([System.IO.Path]::GetExtension($out_candidate) -eq '') {
    $out_candidate = $out_candidate + '.aul2'
}

try {
    $out_path = [System.IO.Path]::GetFullPath($out_candidate)
} catch {
    throw "Invalid output path: $out_candidate"
}

$dir = Split-Path -Path $out_path -Parent
if ($dir) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

$files |
    Sort-Object Name |
    ForEach-Object {
        $text = Get-Content $_.FullName -Encoding utf8 -Raw
        $text = $text.TrimStart("`r", "`n").TrimEnd("`r", "`n")
        ";--------------------------------------------------------------;"
        "; " + $_.BaseName
        ";--------------------------------------------------------------;"
        $text
        if ($_ -ne $files[-1]) { "" }
    } |
    Set-Content -Path $out_path -Encoding utf8
