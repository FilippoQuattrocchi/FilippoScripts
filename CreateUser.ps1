$user = "Name"
New-LocalUser -Name $user -PasswordNeverExpires -NoPassword
Add-LocalGroupMember -Group "Users" -Member $user 