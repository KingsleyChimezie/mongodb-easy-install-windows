@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM :: Simple batch file to help setup MongoDB
REM :: By Kingsley Chimezie - 08/Nov/2017
REM :: License: MIT

REM :: Initialise variables
(
    SET mongodbROOT=!cd!
    SET mongoEXEpath=!mongodbROOT!\bin\mongo.exe
    SET mongodEXEpath=!mongodbROOT!\bin\mongod.exe
    SET binDIRpath=!mongodbROOT!\bin
    SET mongodbMSI=mongodb.msi
    SET mongodbMSIpath=!mongodbROOT!\!mongodbMSI!
    REM :: CREATED DIRs
    SET miscDIRname=MISC
    SET miscDIRpath=!mongodbROOT!\MISC
    SET dataDIRname=data
    SET dataDIRpath=!mongodbROOT!\data
    SET dbDIRname=db
    SET dbDIRpath=!dataDIRpath!\db
    SET logDIRname=log
    SET logDIRpath=!dataDIRpath!\log
    REM :: CREATED FILES
    SET msiTXT=msi.txt
    SET msiTXTpath=!miscDIRpath!\!msiTXT!
    SET mongodLOG=mongod.log
    SET mongodLOGpath=!logDIRpath!\!mongodLOG!
    SET mongodCFG=mongod.cfg
    SET mongodCFGpath=!miscDIRpath!\!mongodCFG!
    REM :: MISC
    SET mongodbPublisherName=MongoDB
    SET restartMessage=* PC Restart Recommended *
    SET waitTime=2
    SET endOfProgramMessage=END OF PROGRAM, PRESS ANY KEY TO QUIT...
    SET runMongodbBAT=mongodb-easy-run.bat
    SET bitbucketRepo=https://goo.gl/GjscTi
    SET githubRepo=https://goo.gl/LHF5aB
)

REM echo TEST ZONE ------------------------ & echo.

REM echo TEST ZONE ------------------------ & echo.
REM PAUSE

REM :: START OF PROGRAM
CALL :Header
IF EXIST !mongodbROOT! (
    cd !mongodbROOT!

    REM :: Check if mongodb is already installed in directory
    IF EXIST !mongoEXEpath! (
        CALL :UninstallOrExit
    )

    REM :: "mongodb.msi" installer does not exists
    IF NOT EXIST !mongodbMSIpath! (
        CALL :NoInstaller
    )
    
    REM :: CORE FUNCTIONS
    (   
        CALL :CreateDIRS        REM :: Must be before InstallMongo due to MISC dir
        CALL :InstallMongo
        CALL :SetupMongo
        CALL :StartMongo
        CALL :Completed
    )
    ECHO !restartMessage!
    CALL :EOP
    
) ELSE (
    CLS & ECHO. Unknown Directory Error...
    CALL :EOP
)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Core
:CreateDIRS REM :: DIRECTORIES
(
    cd !mongodbROOT!
    ECHO. & ECHO * DIRECTORIES STATUS * & ECHO.
    REM :: Setting up MongoDB environment.
    (
        :DIR1 REM :: create MISC directory (\MISC)
        IF NOT EXIST !miscDIRpath! (
            cd !mongodbROOT!
            mkdir !miscDIRname!
            ECHO DIRECTORY CREATED:   !miscDIRpath!
            GOTO :DIR2
        )
        ECHO DIRECTORY EXISTS:    !miscDIRpath!

        :DIR2 REM :: create data directory (\data)
        IF NOT EXIST !dataDIRpath! (
            cd !mongodbROOT!
            mkdir !dataDIRname!
            ECHO DIRECTORY CREATED:   !dataDIRpath!
            GOTO :DIR3 
        )
        ECHO DIRECTORY EXISTS:    !dataDIRpath!

        :DIR3 REM :: create db directory (\data\db)
        IF NOT EXIST !dbDIRpath! (
            cd !dataDIRpath!
            mkdir !dbDIRname!
            ECHO DIRECTORY CREATED:   !dbDIRpath!
            GOTO :DIR4 
        )
        ECHO DIRECTORY EXISTS:    !dbDIRpath!
        
        :DIR4 REM :: create log directory (\data\log)
        IF NOT EXIST !logDIRpath! (
            cd !dataDIRpath!
            mkdir !logDIRname!
            ECHO DIRECTORY CREATED:   !logDIRpath!
            ECHO. & ECHO.
            EXIT /B 0 REM :: EXIT Function MongoSetup
        )
        ECHO DIRECTORY EXISTS:    !logDIRpath!
    )
    ECHO. & ECHO.
    EXIT /B 0
)


:InstallMongo REM :: MONGO INSTALLTION
(
    cd !mongodbROOT!        
    ECHO * INSTALLING MONGO * & ECHO.

    REM :: "mongodb.msi" installer does not exists
    IF NOT EXIST !mongodbMSI! (
        CALL :NoInstaller
    )

    ECHO Installing MongoDB in:
    ECHO !mongodbROOT! 
    ECHO.
    
    REM :: Install MongoDB and msi.txt
    msiexec.exe /i !mongodbMSI! /l*v !msiTXTpath! INSTALLLOCATION=!mongodbROOT! ADDLOCAL="All" /passive /norestart
    
    CALL :Wait
    REM :: MongoDB exists or not after installation?
    IF EXIST !mongoEXEpath! (
        ECHO * Successful Installation * & ECHO. & ECHO.
    )
    IF NOT EXIST !mongoEXEpath! (
        ECHO * Unsuccessful Installation * & ECHO. & ECHO.
        CALL :IsMongoAvailiable
    )
    REM :: msi.txt exists after installation?
    IF EXIST !msiTXTpath! (
        ECHO MSI Log File Created: 
        ECHO !msiTXTpath!
        ECHO.
    )
    EXIT /B 0
)


:SetupMongo REM :: SETUP MONGODB
(   
    cd !miscDIRpath!
    ECHO. & ECHO * SETTING UP MONGO * & ECHO.
    CALL :Wait 
    (REM :: Mongo Configuration
        
        (REM :: Create Config file
            echo systemLog:
            echo     destination: file
            echo     path: !mongodLOGpath!
            echo     logAppend: true
            echo storage:
            echo     dbPath: !dbDIRpath!
            echo     directoryPerDB: true
            echo net:
            echo     bindIp: 127.0.0.1
            echo     port: 27017
        ) > !mongodCFG!

        REM :: Config file exist
        IF EXIST !mongodCFG! (
            ECHO Mongo Config File Created: 
            ECHO !mongodCFGpath!
            ECHO.
        ) ELSE (
            ECHO Could Not Create Mongo Config File Created:
            ECHO !mongodCFGpath!
            ECHO Setting up basic environment instead...
            "!mongodEXEpath!" --dbpath "!dbDIRpath!"
            ECHO.
            CALL :EOP
        )

    )

    REM :: MongoDB Service Setup
    (
        cd !binDIRpath!

        REM :: Start the MongoDB service
        ECHO. & ECHO MongoDB Service Setup
        ECHO -----------------------------------------------------------
        CALL :Wait
        REM :: Delete previous
        ECHO Deleting Any Previous MongoDB Service: & ECHO.
        REM sc.exe delete MongoDB
        sc.exe delete MongoDB binPath= "\"!mongodEXEpath!\" --service --config=\"!mongodCFGpath!\"" DisplayName= "MongoDB" start= "auto"
        ECHO.
        ECHO.
        REM  :: Create New
        ECHO Creating New MongoDB Service: & ECHO.
        sc.exe create MongoDB binPath= "\"!mongodEXEpath!\" --service --config=\"!mongodCFGpath!\"" DisplayName= "MongoDB" start= "auto" 
        ECHO ----------------------------------------------------------- & ECHO.
        CALL :Wait
    )
    EXIT /B 0
)

:StartMongo
(
    cd !binDIRpath! & ECHO. & ECHO.
    net start !mongodbPublisherName!
    timeout /t 5 > nul
    
    CALL :Header
    mongo
    CALL :Header
    
    net stop !mongodbPublisherName!
    CALL :Wait
    EXIT /B 0
)

:Completed
(
    cd !miscDIRpath!
    CALL :Header
    
    (REM :: Create Run file
        echo @ECHO OFF
        echo SETLOCAL EnableDelayedExpansion
        echo cd !binDIRpath!
        echo ECHO ----------------------------------------------------------- 
        echo ECHO By Kingsley Chimezie - 08/Nov/2017                         
        echo ECHO License: MIT                                               
        echo ECHO -----------------------------------------------------------
        echo ECHO.
        echo net start !mongodbPublisherName!
        echo ECHO.
        echo mongo
        echo ECHO.
        echo net stop !mongodbPublisherName!
    ) > !runMongodbBAT!

    REM :: Open repositories
    (
        ECHO BitBucket  Repository:     !bitbucketRepo!
        ECHO GitHub     Repository:     !githubRepo!
        ECHO. & timeout /t 10
        START !bitbucketRepo!
        START !githubRepo!
    )
    EXIT /B 0
)
:: END ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Core


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Secondary
:UninstallOrExit REM :: UNINSTALL MONGO OR EXIT PROGRAM
(
    cd !mongodbROOT!

    REM :: "mongodb.msi" installer does not exists
    IF NOT EXIST !mongodbMSI! (
        CALL :NoInstaller
    )
    
    SET confirm=0
    SET /p "confirm=MongoDB is already installed, Would you like uninstall? (Y/N): "
    ECHO.
    IF !confirm!==Y CALL :Header & GOTO :UninstallMongo
    IF !confirm!==y CALL :Header & GOTO :UninstallMongo
    IF !confirm!==N CALL :EOP
    IF !confirm!==n CALL :EOP
    GOTO :UninstallOrExit           REM :: any input other than: y Y n N

    :UninstallMongo REM :: MONGO UNINSTALLATION
    (
        cd !mongodbROOT!
        ECHO. & ECHO * UNINSTALLING MONGO * & ECHO.
        ECHO Uninstalling MongoDB from:
        ECHO !mongodbROOT! 
        ECHO.
        
        REM :: Uninstall MongoDB
        msiexec.exe /x !mongodbMSI! UNINSTALLLOCATION=!mongodbROOT! ADDLOCAL="All" /passive /norestart

        CALL :Wait
        REM :: MongoDB still exists or not after uninstallation?
        IF EXIST !mongoEXEpath! (
            ECHO * Unsuccessful Unstallation * & ECHO. & ECHO.
            CALL :IsMongoAvailiable
        )
        IF NOT EXIST !mongoEXEpath! (
            ECHO * Successful Unstallation * & ECHO. & ECHO.
            ECHO !restartMessage!
        ) 
        CALL :EOP
    )
)
:: END ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Secondary


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Checks, Warnings & Errors
:NoInstaller REM :: "mongodb.msi" installer does not exists
(
    ECHO ERROR - MISSING OR INVALID INSTALLER FILE & ECHO.
    ECHO 1. Download MongoDB to the same location as this program:
    ECHO    !mongodbROOT! & ECHO.
    ECHO 2. The downloaded file name and extension must be:  "!mongodbMSI!"
    CALL :EOP
    EXIT /B 0
)

:IsMongoAvailiable REM :: Call due to Unsuccessful installation or uninstallion
(
    REM :: Checks System programs for MongoDB
    ECHO Checking If "!mongodbPublisherName!" Is Available On This PC... & ECHO.
    ECHO ----------------------------------------------------------- 
    wmic product where "Vendor like '!mongodbPublisherName!'" get Name, Version
    ECHO.
    ECHO To Resolve Unsuccessful Installation OR Uninstallion, Please Try:
    ECHO.
    ECHO 1.     Uninstall "!mongodbPublisherName!" From Windows Control Panel and Retry this program
    ECHO.
    ECHO 2.     Delete OR Re-add "!mongodbPublisherName!" bin Directory and Retry this program:
    ECHO.
    ECHO        !mongodbROOT!\bin
    ECHO ----------------------------------------------------------- & ECHO.
    CALL :Wait
    EXIT /B 0
)
:: END ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Checks, Warnings & Errors


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Displays & Exit
:Header REM :: Header information - clears screen (new screen)
(
    CLS
    ECHO ----------------------------------------------------------- 
    ECHO Simple batch file to help setup MongoDB                    & ECHO.
    ECHO By Kingsley Chimezie - 08/Nov/2017                         & ECHO.
    ECHO License: MIT
    ECHO -----------------------------------------------------------& ECHO.
    EXIT /B 0
)

:Wait REM :: Creates a halt of display - define to variable
(
    ECHO %time% > NUL & timeout !waitTime! > NUL & echo %time% > NUL
    EXIT /B 0
)

:EOP REM :: End of Program
(
    ECHO.
    ECHO -----------------------------------------------------------
    ECHO !endOfProgramMessage! & PAUSE >nul & EXIT
)
:: END ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS: Displays & Exit

