# mongodb-easy-install-windows

Automatically install, configure and set up a MongoDB environment on Windows OS (Windows 7 and above) machine. Using the "mongodb-easy-install-windows" batch (.bat) script.



## Prerequisites
* OS - Windows 7 and above
* Internet access
* MongoDB installer file
* mongodb-easy-install-windows tool



## Instructions

### YouTube Videos
| Description                                                                                                 | Link                         |
|-------------------------------------------------------------------------------------------------------------|------------------------------|
| MongoDB Easy Installation and Setup in 1 MINUTE! Free Tool for Windows - Part 1 - (Quick Demo)              | https://youtu.be/p2Tp9f4_MQk |
| MongoDB Easy Installation and Setup in 1 MINUTE! Free Tool for Windows - Part 2 - (Full Demo Walkthrough)   |                              |
| MongoDB Easy Installation and Setup in 1 MINUTE! Free Tool for Windows - Part 3 - (Source Code Walkthrough) |                              |

### Written Guide
1. Create a folder path of your choice, on your PC, where you want to install and setup MongoDB. Example:  
***"C:\myMongoDB"***


2. Download the latest MongoDB installer file (.msi), to the folder you just created. Example:  
***"C:\myMongoDB\downloaded-mongodb-installer.msi"***

- MongoDB installer file Download link:  
https://www.mongodb.com/download-center?jmp=nav#community   

- **N.B. It is recommended that you do not remove the MongoDB installer from the created folder even after installation.**


3. Download "mongodb-easy-install-windows.bat" tool, to the created folder from step 1. Example:  
***"C:\myMongoDB\mongodb-easy-install-windows.bat"***

- The latest "mongodb-easy-install-windows.bat" tool can be downloaded from the any of the below locations:
- BitBucket repository (master branch):    https://goo.gl/MC7zDD  
- GitHub repository (master branch):       https://goo.gl/JSpvQp  
- GitHubGist:                              https://goo.gl/JRgGcm


4. Rename the MongoDB installer file (from step 2) in the created folder to - **mongodb**. Example:
- Original path:    ***"C:\myMongoDB\downloaded-mongodb-installer.msi"***
- Renamed path:     ***"C:\myMongoDB\mongodb.msi"***


5. Run the "mongodb-easy-install-windows.bat" tool as Administrator. The Batch script will now automatically install, configure and set up MongoDB. If everything is successful, you should now be within the MongoDB Shell.


**N.B.**
- To add custom configurations, you may edit the **"config.cfg"** generated by "mongodb-easy-install-windows.bat". Example:  
***"C:\myMongoDB\MISC\config.cfg"***

- To instantly access the MongoDB Shell at anytime, run the **"mongodb-easy-run.bat"** file generated by "mongodb-easy-install-windows.bat". Example:  
***"C:\myMongoDB\MISC\mongodb-easy-run.bat"***

- You can rename the "mongodb-easy-install-windows.bat" to whatever you like.   



## License
- MIT - Copyright (c) 2017 Kingsley Chimezie



## Versions
- [Click here](https://bitbucket.org/kingsleymedia-team/mongodb-easy-install-windows/src/master/src)



## Project People
| Name                	|  Title              	|  Authority Level      | Website                  	|
|-------------------	| -------------------	| -------------------	|--------------------------	|
| Kingsley Chimezie 	|  Author +        	|  Admin +        	| http://www.kingsley.tech 	|

[Click here for **title** and **authority level** definitions.](https://bitbucket.org/kingsleymedia-team/kmp-repo-template/src/master/copy-this-and-use-as-repo/assets/title.md)



## Acknowledgments
 NULL



## References
1. Install MongoDB Community Edition on Windows   
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

2. MongoDB Core Reference (v3.4 used for project)  
https://docs.mongodb.com/v3.4/reference/program/mongod/
https://docs.mongodb.com/manual/reference/configuration-options/