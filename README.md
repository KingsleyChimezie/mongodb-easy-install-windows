# mongodb-easy-install-windows #

> ## Version 1.0 ##

### Automatically install, configure and set up a MongoDB environment on Windows OS (Windows 7 and above) machine. Using the "mongodb-easy-install-windows" batch (.bat) script. ##



## __Prerequisites__ ##
* OS - Windows 7 and above
* Internet access
* MongoDB installer file
* mongodb-easy-install-windows tool



## __Instructions__ ##
### 1. Create a folder path of your choice, on your PC, where you want to install and setup MongoDB ###

        Example:    "C:\myMongoDB"


### 2. Download the latest MongoDB installer file (.msi), to the folder you just created ###

        Example:    "C:\myMongoDB\downloaded-mongodb-installer.msi"
    
* MongoDB installer file Download link: 
            
        https://www.mongodb.com/download-center?jmp=nav#community   

* __N.B. It is recommended that you do not remove the MongoDB installer from the created folder even after installation__

### 3. Download "mongodb-easy-install-windows.bat" tool, to the created folder from step 1.   

        Example:    "C:\myMongoDB\mongodb-easy-install-windows.bat"

* The latest "mongodb-easy-install-windows.bat" tool can be downloaded from the ___"master"___ branch ___"src"___ folder - within the __BitBucket__ OR __GithHub__ repository.   
OR   
Independently from __GitHubGist__  
(See links below) 
    
        - BitBucket repository (master branch):    https://goo.gl/2U17Bq  
        - GitHub repository (master branch):       https://goo.gl/JSpvQp  
        - GitHubGist:                              https://goo.gl/JRgGcm


### 4. Rename the MongoDB installer file (from step 2) in the created folder to - __mongodb__ ###

        Example:
                Original path:    "C:\myMongoDB\downloaded-mongodb-installer.msi"
                Renamed path:     "C:\myMongoDB\mongodb.msi"


### 5. Run (double click) the "mongodb-easy-install-windows.bat" tool.
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
* Install MongoDB Community Edition on Windows   
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

* MongoDB Core Reference (v3.4 used for project)  
https://docs.mongodb.com/v3.4/reference/program/mongod/
https://docs.mongodb.com/manual/reference/configuration-options/