<#
.SYNOPSIS
 Script That create a scheduled task that run the First_Script.ps1, disable it after $waitSeconds and print the current tasks in a specific format

.DESCRIPTION
 Create Task-Scheduler that run the First_Script.ps1, disable it after $waitSeconds and print the current tasks in a specific format
 for more information about the Task-Scheduler visit https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/?view=windowsserver2019-ps.

.PARAMETER TaskName
 Name of the Scheduled Task
 Example:Start_Powershell

.PARAMETER waitSeconds
 The number of seconds to wait until we disable the task
#>
param ([Parameter(Mandatory=$true)][String]$TaskName,[Parameter(Mandatory=$true)][int]$waitSeconds)


Function Create-Task 
{
   <#
     .SYNOPSIS
      Create Scheduled Task
     
     .DESCRIPTION
      Create Scheduled Task that his action is run powershell with First_Script.ps1.
      The task will run Every 1 minutes for a day.

     .EXAMPLE
     
    $action = New-ScheduledTaskAction -Execute "{exe file path}" -Argument "if argument needed"
    $trigger = New-ScheduledTaskTrigger "config the trigger"
    
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName

   #>  
    
   
    
    $action = New-ScheduledTaskAction -Execute "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" -Argument "C:\Users\ido\Desktop\PowerShell_Scripts\First_Script.ps1"
    $trigger = New-ScheduledTaskTrigger -Once -At 3am -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-TimeSpan -Days 1)
    
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName
    
   
     
}


Function Change-TaskStatus
{   <#
     .SYNOPSIS
      Change Task Status
     
     .DESCRIPTION
      wait a $waitSeconds and change the task status.

     .EXAMPLE
      Disabled -> Ready
      Ready -> Disabled

     
   #>  
    
    
    Start-Sleep -s $waitSeconds
    $status = (Get-ScheduledTask | Where TaskName -eq $TaskName).State
    
    if($status -eq 'Disabled'){
        Enable-ScheduledTask -TaskName $TaskName    
    }

    if($status -eq 'Ready'){
        Disable-ScheduledTask -TaskName $TaskName
       
    }
}
                 




Function Get-AllTasks {
 <#
     .SYNOPSIS
      Get All Tasks
     
     .DESCRIPTION
      Get list of all tasks 

     
   #>  

 $Tasks = Get-ScheduledTask  | Get-ScheduledTaskInfo  | Select TaskName
 
 Foreach($i in $Tasks.Taskname)
 {
    echo $i
 }
 
}


echo "Creating a new task with the name : $Taskname."
echo "Task will run for $waitSeconds Seconds."
Create-Task

echo "Stopping task $TaskName after $waitSeconds."
Change-TaskStatus
echo "All Tasks:"
Get-AllTasks
