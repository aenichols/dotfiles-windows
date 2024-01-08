# Array to store all networks
$networks = @()

# Get the list of all wireless profiles
$wlanProfiles = (netsh wlan show profiles) | Select-String -Pattern "All User Profile\s*:\s*(.*)$" | ForEach-Object{$_.Matches.Groups[1].Value}

# For each profile
foreach ($wlanProfile in $wlanProfiles)
{
    $network = New-Object PSObject -Property @{
        "SSID" = $wlanProfile
        "Password" = $null
    }

    # Get the password/key of the wireless profile
    $key = (netsh wlan show profile name=$wlanProfile key=clear) | Select-String -Pattern 'Key Content\s*:\s*(.*)'

    if ($key)
    {
        $network.Password = $key.Matches.Groups[1].Value
    }
    else
    {
        $network.Password = ""
    }

    # Add network to array
    $networks += $network
}

# Print headers with color
Write-Host ("")
Write-Host ("{0,-25} {1,-50}" -f "SSID", "Password") -ForegroundColor Cyan
Write-Host ("{0,-25} {1,-50}" -f "----", "--------") -ForegroundColor White
Write-Host ("")

# Print all networks in the desired order with color
foreach ($network in $networks) {
    Write-Host ("{0,-25} {1,-50}" -f $network.SSID, $network.Password) -ForegroundColor Yellow
}
Write-Host ("")
