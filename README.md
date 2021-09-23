This script allows you to run a script on remote servers using the Invoke-Command powershell command and a foreach loop including a try/catch. Its really that simple :) 

Follow the the steps below to use it!
1. Make the directory C:\temp\ 
2. Paste the files: PS-remoting-script.ps1, servers.txt and your own script with the name script.ps1
3. Run the script with a user that can A. has enough permissions to run scripts with the used modules on the local pc and the remote pc B. is allowed to use ps-remoting
4. Run the script :)

Example for a Azure ARC deployment script:
![example image](https://user-images.githubusercontent.com/23695684/134479261-908c20fc-4175-401d-a3b7-11089da5aaf3.png)
