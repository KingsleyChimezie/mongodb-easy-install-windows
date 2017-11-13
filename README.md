# mongodb-easy-install-windows #
MongoDB installation and environment setup on Windows OS (Windows 7 and above), using a batch (.bat) script.


## __Prerequisites__ ##
* OS - Windows 7 and above
* Internet access
* MongoDB installer file
* mongodb-easy-install-windows tool



## __Instructions__ ##
1. ### Create a folder path of your choice, on your PC, where you want to install & setup MongoDB ###

        Example:    "C:\myMongoDB"


2. ### Download MongoDB installer file (.msi), to the folder you just created ###

        Example:    "C:\myMongoDB\downloaded-mongodb-installer.msi"
    
    MongoDB Download link: 
            
        https://www.mongodb.com/download-center?jmp=nav#community   


3. ### Download "mongodb-easy-install-windows.bat" tool, to the created folder from step 1.   

        Example:    "C:\myMongoDB\mongodb-easy-install-windows.bat"

* The "mongodb-easy-install-windows.bat" tool can be downloaded from "src" folder in the __BitBucket__ and __GithHub__ repositories, or from __GitHubGist__ (See links below) 
    
        - BitBucket repository (master branch):    https://goo.gl/2U17Bq  
        - GitHub repository (master branch):       https://goo.gl/JSpvQp  
        - GitHubGist:                              https://goo.gl/JRgGcm


4. ### Rename MongoDB installer file (from step 2) in the created folder to - __mongodb__ ###

        Example:
                Original    "C:\myMongoDB\downloaded-mongodb-installer.msi"
                Renamed     "C:\myMongoDB\mongodb.msi"


5. ### Run (double click) the "mongodb-easy-install-windows.bat" tool.
* You can rename the "mongodb-easy-install-windows.bat" to whatever you like - this will not cause error.



## __License__ ##
* MIT - Copyright (c) 2017 Kingsley Chimezie



## __Versions__ ##
| Version No.   	| Release Date 	|
|---------------	|--------------	|
| 1.0 (current) 	| 2017-11-12   	|



## __Author(s)__ ##
| Name              	| Contribution                                   	| Website                  	|
|-------------------	|------------------------------------------------	|--------------------------	|
| Kingsley Chimezie 	| Initial development and repository management  	| http://www.kingsley.tech 	|



## __Acknowledgments__ ##
* NULL



## __References__ ##

### Key References: ###
* Install MongoDB Community Edition on Windows   
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

* MongoDB Core Reference (v3.4 used for project)  
https://docs.mongodb.com/v3.4/reference/program/mongod/
https://docs.mongodb.com/manual/reference/configuration-options/


### Other References: ###

#### 2017-11-12 ####
1. wikiHow to Delay a Batch File   
https://www.wikihow.com/Delay-a-Batch-File

1. Batch file to get specific installed software along with version  
https://stackoverflow.com/questions/1482739/batch-file-to-get-specific-installed-software-along-with-version

#### 2017-11-10 ####
1. How to Create and Delete Files and Directories from Windows Command Prompt   
https://www.wikihow.com/Create-and-Delete-Files-and-Directories-from-Windows-Command-Prompt

1. Long commands split over multiple lines in Windows Vista batch (.bat) file  
https://stackoverflow.com/questions/69068/long-commands-split-over-multiple-lines-in-windows-vista-batch-bat-file

#### 2017-11-08 ####
1. The Silent Install options for the Windows installer (msiexec)   
http://www.silentinstall.org/msiexec

1. Take Command / TCC Help v. 21   
https://jpsoft.com/help/rem.htm