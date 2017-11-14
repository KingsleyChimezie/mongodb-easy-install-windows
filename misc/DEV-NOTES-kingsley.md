# DEVELOPMENT NOTES - by Kingsley Chimezie #
## The following notes are notes that were writen for myself as a reference point to my discoveries or useful information. ##


## 2017-11-12 ##
* EXIT /B 0 must be added to end of any function if you wish to return back to caller.   

* N.B. - Functions and statements (IF, FOR, ELSE) don't work when bracket is right next to name on a new line.

* __REF: "Batch file to get specific installed software along with version"__     
    * __Names and versions software installed on system (All):__   
    wmic product get Name, Version

    * __Names and versions software installed on system (Vendor specific):__  
    wmic product where "Vendor like '%MongoDB%'" get Name, Version

    * __Names and versions software installed on system (Name specific):__  
    wmic product where "Name like '%Mongodb%'" get Name, Version  

    __Answered by user "Helen" on Stackoverflow__
 

## 2017-11-11 ##
* Checks for valid .msi installer file path when (valid = "mongodb.msi"):
    1. The program initially starts
    1. Trying to install MongoDB
    1. The Trying to uninstall MongoDB


* Can't create a function within IF statement - caused Issues. 

* .msi Installer must be left in the directory - if removed, the bath file cannot uninstall mongodb

* Discovered that tabs / white spaces within variables are affective. Caused problems with a directory link. Issue resolved after discovery


## 2017-11-10 ## 
* CALL command has a return - it will return a function as long as there is no EXIT command within the function. 

* EXIT will terminate the script, EXIT /B 0 is the added to close off the function.

* GOTO command will go to a function and not return to where it was initiated.


## 2017-11-08 ##
- mongodb.msi and the batch files must be in the same directory as the copied path.
- it installed funny when tested with user's directory: " C:\Users\username\ "

Recommended Installation locations:  
1. Root location of a drive - e.g. C:\ D:\ K:\ etc...


### Not working: ###
- Doesn't install on Google drive
- It won't work when .msi and .bat files in different folders to the coppied path

### Working: ###
- the installation msi filename can be changed
- code works with path stored as a variable   
    "msiexec.exe /i mongodb.msi INSTALLLOCATION=!ChosenPath! ADDLOCAL="all" /passive /norestart"
- installs msiexec.exe on Different drives
- leaves .msi and .bat file when uninstalling
- Installed and uninstalled on DropBox
- Installed and uninstalled on Network Drive


## References ##

### __Key References:__ ###
* Install MongoDB Community Edition on Windows   
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

* MongoDB Core Reference (v3.4 used for project)  
https://docs.mongodb.com/v3.4/reference/program/mongod/
https://docs.mongodb.com/manual/reference/configuration-options/


### __Other References:__ ###

### 2017-11-12
1. wikiHow to Delay a Batch File   
https://www.wikihow.com/Delay-a-Batch-File

1. Batch file to get specific installed software along with version  
https://stackoverflow.com/questions/1482739/batch-file-to-get-specific-installed-software-along-with-version

### 2017-11-10
1. How to Create and Delete Files and Directories from Windows Command Prompt   
https://www.wikihow.com/Create-and-Delete-Files-and-Directories-from-Windows-Command-Prompt

1. Long commands split over multiple lines in Windows Vista batch (.bat) file
https://stackoverflow.com/questions/69068/long-commands-split-over-multiple-lines-in-windows-vista-batch-bat-file

### 2017-11-08
1. The Silent Install options for the Windows installer (msiexec)   
http://www.silentinstall.org/msiexec

1. Take Command / TCC Help v. 21   
https://jpsoft.com/help/rem.htm