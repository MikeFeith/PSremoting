#This script runs a ps1 script in the path C:\temp\script.ps1 against the servers in the path C:\temp\servers.txt using Remote Powershell
#  _____                _           _   _              
# / ____|              | |         | | | |          _  
#| |     _ __ ___  __ _| |_ ___  __| | | |__  _   _(_) 
#| |    | '__/ _ \/ _` | __/ _ \/ _` | | '_ \| | | |   
#| |____| | |  __/ (_| | ||  __/ (_| | | |_) | |_| |_  
# \_____|_|_ \___|\__,_|\__\___|\__,_| |_.__/ \__, (_) 
#|  \/  (_) |        |  ____| (_) | | |        __/ |   
#| \  / |_| | _____  | |__ ___ _| |_| |__     |___/    
#| |\/| | | |/ / _ \ |  __/ _ \ | __| '_ \             
#| |  | | |   <  __/ | | |  __/ | |_| | | |            
#|_|  |_|_|_|\_\___| |_|  \___|_|\__|_| |_|            
                                                     
                                                     
#Defining global variables
# use the hostnames for the servers in the serverlist, like srv01. You can also use FQDN or just ip adresses, however hostnames provide a nicer output in the results.txt
$serverlist = Get-Content "C:\temp\servers.txt"
# the script below will be deployed to the servers in the list above
$script = Get-Content "C:\temp\script.ps1"


#Creating a local result.txt file to mark if it the invoke-command was succesful or if it failed
if((Get-Item -Path "C:\temp\result.txt" -ErrorAction SilentlyContinue)) {
    Write-Host "Not creatting a new results file"
    Add-Content -Path "C:\temp\result.txt" -Value "////SCRIPT HAS BEEN RESTARTED\\\\"
} 
else {
    Write-Host "New results file created"
    New-Item "C:\temp\result.txt" | Out-Null
}


#Foreach server in serverlist, invoke-command with a 10sec timer.
foreach ($server in $serverlist) {
    Start-Sleep -s 10
    try {
        Invoke-Command -FilePath "C:\temp\script.ps1" -ComputerName $server 
        Add-Content -Path "C:\temp\result.txt" -Value "Success $server"
    }
    catch {
        Echo "Something went wrong, check if PS remote is enabled on the following host $server" 
        Add-Content -Path "C:\temp\result.txt" -Value "Fail $server"
    }
}
Write-Host "Script is done!"
