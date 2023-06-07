$profileDir = Split-Path -parent $profile
$componentDir = Join-Path $profileDir "components"
$roosterDir = Join-Path $profileDir "rooster"

New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
New-Item $componentDir -ItemType Directory -Force -ErrorAction SilentlyContinue
New-Item $roosterDir -ItemType Directory -Force -ErrorAction SilentlyContinue

Copy-Item -Path ./*.ps1 -Destination $profileDir -Exclude "bootstrap.ps1"
Copy-Item -Path ./components/** -Destination $componentDir -Include **
Copy-Item -Path ./home/** -Destination $home -Include **
Copy-Item -Path ./rooster/** -Destination $roosterDir -Include **

Remove-Variable componentDir
Remove-Variable profileDir
Remove-Variable roosterDir
