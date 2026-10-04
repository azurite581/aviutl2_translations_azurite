param(
  [Parameter(Mandatory)][string]$Src,
  [Parameter(Mandatory)][string]$Dst,
  [Parameter(Mandatory)][string]$SemVer
)
$ErrorActionPreference = 'Stop'

$lines  = Get-Content $Src -Encoding UTF8
$header = "## [$SemVer]"

$start = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
  if ($lines[$i].StartsWith($header)) { $start = $i; break }
}
if ($start -lt 0) { throw "Version not found: $SemVer" }

$end = $lines.Count
for ($i = $start + 1; $i -lt $lines.Count; $i++) {
  if ($lines[$i].StartsWith('## [')) { $end = $i; break }
}

$body = @()
if ($end - $start - 1 -gt 0) { $body = $lines[($start + 1)..($end - 1)] }

$skip = 0
while ($skip -lt $body.Count -and [string]::IsNullOrWhiteSpace($body[$skip])) { $skip++ }

$last = $body.Count - 1
while ($last -ge $skip -and [string]::IsNullOrWhiteSpace($body[$last])) { $last-- }

if ($skip -le $last) { $body = $body[$skip..$last] } else { $body = @() }

$text = ($body -join "`n") + "`n"
[System.IO.File]::WriteAllText(
  (Join-Path (Get-Location) $Dst),
  $text,
  (New-Object System.Text.UTF8Encoding($false))
)
