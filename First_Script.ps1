
<#
.SYNOPSIS
 Make a Nodepad File and run 

.DESCRIPTION
 The Script Make a Nodepad File ,Write "I love the bootcamp!" and Start it

#>

Out-File -FilePath "C:\Users\ido\Desktop\Text4.txt" -InputObject "I love the bootcamp!" | Start-Process "C:\Users\ido\Desktop\Text4.txt"
