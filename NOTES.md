# NOTES:
    The following notes are notes that were writen for myself as a reference point to my discoveries or useful information.

> ## 2017-11-11 
* Discovered that tabs / white spaces within variables are affective. Caused problems with a directory link. Issue resolved after discovery
   
> ## 2017-11-10   
* CALL command has a return - it will return a function as long as there is no EXIT command within the function. 

* EXIT will terminate the script, EXIT /B 0 is the added to close off the function.

* GOTO command will go to a function and not return to where it was initiated.

> ## 2017-11-08
NB
- mongodb.msi and the batch files must be in the same directory as the copied path.
- it installed funny when tested with user's directory: " C:\Users\username\ "

Recommended Installation locations:  
1. Root location of a drive - e.g. C:\ D:\ K:\ etc...


### Not working:
- Doesn't install on Google drive
- It won't work when .msi and .bat files in different folders to the coppied path

### Working:
- the installation msi filename can be changed
- code works with path stored as a variable   
    "msiexec.exe /i mongodb.msi INSTALLLOCATION=!ChosenPath! ADDLOCAL="all" /passive /norestart"
- installs msiexec.exe on Different drives
- leaves .msi and .bat file when uninstalling
- Installed and uninstalled on DropBox
- Installed and uninstalled on Network Drive

> ## References

### 2017-11-08
1. The Silent Install options for the Windows installer (msiexec)   
http://www.silentinstall.org/msiexec

2. Install MongoDB Community Edition on Windows   
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

3. Take Command / TCC Help v. 21   
https://jpsoft.com/help/rem.htm