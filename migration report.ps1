Get-MigrationUser -ResultSize unlimited |  % { Get-MigrationUserStatistics -Identity $_.identity | select Identity,BatchId,status,LastSuccessfulSyncTime,ErrorType,SyncedItemCount,SkippedItemCount,DataConsistencyScore,DataConsistencyScoringFactors,HasUnapprovedSkippedItems,error} | Export-Csv .\mig.csv -nti -Encoding utf8


Get-MsolUser -All | select userprincipalname,displayname,department,@{name="licenses";expression={$_.licenses.accountskuid -join ";"}} | Export-Csv -nti -Encoding utf8 ./users.csv


