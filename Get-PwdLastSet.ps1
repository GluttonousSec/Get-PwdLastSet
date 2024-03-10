# Check if Active Directory module is installed
if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    # Install Active Directory module in the current user scope
    Install-Module -Name ActiveDirectory -Scope CurrentUser -Force
}

# Import Active Directory module
Import-Module ActiveDirectory

# Get all users from Active Directory
$users = Get-ADUser -Filter * -Properties PasswordLastSet

# Initialize an array to store user information
$userInfo = @()

# Iterate through each user to extract username and password last set timestamp
foreach ($user in $users) {
    $userInfo += [PSCustomObject]@{
        Username = $user.SamAccountName
        LastPasswordChange = $user.PasswordLastSet
    }
}

# Export user information to CSV
$userInfo | Export-Csv -Path "User_Password_Last_Change.csv" -NoTypeInformation
