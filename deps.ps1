# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force

### Package Providers
Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

choco install -y chocolatey-core.extension

# node-lts
choco install nodejs-lts                        --limit-output

# system and cli
choco install curl                              --limit-output
choco install nuget.commandline                 --limit-output
choco install webpi                             --limit-output
choco install git                               --limit-output
choco install python                            --limit-output
choco install ruby                              --limit-output
choco install sysinternals                      --limit-output

#fonts
choco install sourcecodepro                     --limit-output

# browsers
choco install Opera                             --limit-output; <# pin; evergreen #> choco pin add --name Opera               --limit-output

# dev tools and frameworks
choco install dotnet-sdk                        --limit-output
choco install neovim --pre                      --limit-output

choco install vscode                            --limit-output
choco install vscode-docker                     --limit-output

choco install postman                           --limit-output

choco install azurepowershell                   --limit-output
choco install microsoftazurestorageexplorer     --limit-output

choco install visualstudio2019professional      --limit-output

### Windows Features
Write-Host "Installing Windows Features..." -ForegroundColor "Yellow"
Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart | Out-Null

Refresh-Environment

gem pristine --all --env-shebang

### Node Packages
Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
if (which npm) {
    npm update npm
    npm install -g gulp
    npm install -g node-inspector
    npm install -g @angular/cli
    npm install -g @angular/language-server
}

