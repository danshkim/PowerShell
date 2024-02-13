$groups= @()
$errMember = @()
$errOwner = @()

$csv | % {
    $group = $null 
    Write-Host $_.displayname-f y
    # $group=New-Team -MailNickName $_.alias -DisplayName $_.displayname -Visibility private
    # $groups += $group
    $group = Get-Team -MailNickName $_.Alias
    # $team_member = Get-TeamUser -GroupId $_.GroupId


    if($_.members){

        $_.members -split ";" | % {

            if($_ -ne ""){
                Write-Host "Add member",$_
                try {
                    Add-TeamUser -groupid $group.GroupId -User (get-recipient $_).PrimarySmtpAddress -Role Member -ErrorAction Stop 
                }
                catch {

                    $errMember += $_
                }
        }
        }
    }

    if($_.owners){
    $_.owners -split ";" | % {
        Write-Host "Add owner",$_

        if($_ -ne ""){
        try {
            Add-TeamUser -groupid $group.GroupId -User (get-recipient $_).PrimarySmtpAddress -Role Owner  -ErrorAction Stop 
        }
        catch {
            $errOwner += $_
        }
    }
    }
}

}