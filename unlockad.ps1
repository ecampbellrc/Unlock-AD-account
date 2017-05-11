Import-Module ActiveDirectory

Function Unlock-me {
    Param(
        $username
    )

    try {
    
        #Attempt to find the user in ActiveDirectory, Set the Password, and force user to change password at next logon
        $ADAccount = Get-ADUser -Identity $username
        unlock-adaccount -Identity $username

        #Report success to operator
        Write-Host "$($ADAccount.GivenName)'s account has been unlocked!" -ForegroundColor Green
    } catch [Microsoft.ActiveDirectory.Management.ADIdentityResolutionException] {
        #Attempt to find username in AD failed
        Write-Host "ERROR! $username NOT Found in Active Directory!" -ForegroundColor Red
    } catch [Exception] {
        #Unexpected Exception
        Write-Host "ERROR! $($Error[0].Exception)" -ForegroundColor Red
    }
}

#START SCRIPT
$continue = $true
while($continue) {
    # ----- replace testuser or uncomment lines 30-35 and comment out line 29  Unlock-me -username testuser -------
    Unlock-me -username testuser
    #Unlock-me -username (Read-Host "Enter Username")
    
    #Ask operator if they want to run script again
    #if((Read-Host "Repeat Script?") -eq "N") {
        $continue = $false
    # }
    
} 
