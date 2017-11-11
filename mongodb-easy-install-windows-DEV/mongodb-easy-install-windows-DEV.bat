@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM :: Simple batch file to help setup MongoDB
REM :: By Kingsley Chimezie - 08/Nov/2017
REM :: License: MIT

REM :: Initialise variables
(
    SET mongodbDIR=!cd!
    SET mongoExists=!mongodbDIR!\bin\mongo.exe
    SET miscDIRname=MISC
    SET miscDIR=!mongodbDIR!\MISC
    SET dataDIRname=data
    SET dataDIR=!mongodbDIR!\data
    SET dbDIRname=db
    SET dbDIR=!dataDIR!\db
    SET logDIRname=log
    SET logDIR=!dataDIR!\log
    SET mongodbMSI=mongodb.msi
    SET msiLogFile=MSI-log.txt
    SET restartMessage=* PC Restart Recommended *
    SET endOfProgramMessage=END OF PROGRAM, PRESS ANY KEY TO QUIT...
    SET mongoConfigFile=mongod.cfg
    SET bitbucketRepo=https://goo.gl/GjscTi
    SET githubRepo=https://goo.gl/LHF5aB
)
REM echo TEST ZONE ------------------------
REM ECHO !mongodbDIR!
REM ECHO !mongoExists!
REM ECHO !miscDIRname!
REM ECHO !miscDIR!
REM ECHO !dataDIRname!
REM ECHO !dataDIR!
REM ECHO !dbDIRname!
REM ECHO !dbDIR!
REM ECHO !logDIRname!
REM ECHO !logDIR!
REM echo TEST ZONE ------------------------
REM PAUSE

REM :: Start of Program
IF EXIST !mongodbDIR! (
    CALL :Header & cd !mongodbDIR!

    :: Check if mongodb is already installed in directory
    IF EXIST !mongoExists! (
        CALL :UninstallOrExit
    )
    CALL :MongoSetup        REM :: Must be before InstallMongo due to MISC
    CALL :InstallMongo
    CALL :MongoPathSetup
    ECHO !restartMessage!
    CALL :EOP

) ELSE (
    ECHO Unknown Directory Error...
    CALL :EOP
)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS
:UninstallOrExit REM :: UNINSTALL MONGO OR EXIT PROGRAM
(
    SET confirm=0
    CALL :Header
    SET /p "confirm=MongoDB is already installed, Would you like uninstall? (Y/N): "
    IF !confirm!==Y GOTO :UninstallMongo
    IF !confirm!==y GOTO :UninstallMongo
    IF !confirm!==N CALL :EOP
    IF !confirm!==n CALL :EOP
    GOTO :UninstallOrExit           REM :: any input other than: y Y n N
    EXIT /B 0
)
:UninstallMongo REM :: MONGO UNINSTALLATION
(
        ECHO. & ECHO. & cd !mongodbDIR!
        ECHO Uninstalling MongoDB from: !mongodbDIR! & ECHO. & ECHO.
        
        REM :: Uninstall MongoDB
        msiexec.exe /x !mongodbMSI! UNINSTALLLOCATION=!mongodbDIR! ADDLOCAL="All" /passive /norestart

        REM :: MongoDB still exists or not after uninstallation?
        IF EXIST !mongoExists! (
            ECHO UNSUCCESSFUL UNINSTALLATION 
            ECHO.
        )
        IF NOT EXIST !mongoExists! (
            ECHO SUCCESSFUL UNINSTALLATION 
            ECHO.
            ECHO !restartMessage!
        ) 
    )
    CALL :EOP
    EXIT /B 0
)

:MongoSetup REM :: MONGO SETUP
(
    ECHO ENVIRONMENT STATUS & ECHO.
    REM :: Setting up MongoDB environment.
    (
        :DIR1 REM :: create MISC directory (\MISC)
        IF NOT EXIST !miscDIR! (
            cd !mongodbDIR!
            mkdir !miscDIRname!
            ECHO CREATED:   !miscDIR!
            GOTO :DIR2
        )
        ECHO EXISTS:    !miscDIR!

        :DIR2 REM :: create data directory (\data)
        IF NOT EXIST !dataDIR! (
            cd !mongodbDIR!
            mkdir !dataDIRname!
            ECHO CREATED:   !dataDIR!
            GOTO :DIR3 
        )
        ECHO EXISTS:    !dataDIR!

        :DIR3 REM :: create db directory (\data\db)
        IF NOT EXIST !dbDIR! (
            cd !dataDIR!
            mkdir !dbDIRname!
            ECHO CREATED:   !dbDIR!
            GOTO :DIR4 
        )
        ECHO EXISTS:    !dbDIR!
        
        :DIR4 REM :: create log directory (\data\log)
        IF NOT EXIST !logDIR! (
            cd !dataDIR!
            mkdir !logDIRname!
            ECHO CREATED:   !logDIR!
            EXIT /B 0 REM :: EXIT Function MongoSetup
        )
        ECHO EXISTS:    !logDIR!
    )
    EXIT /B 0
)
       
:InstallMongo REM :: MONGO INSTALLTION
(
    ECHO. & ECHO. & cd !mongodbDIR!        
    
    REM :: var "mongodbMSI" exists
    IF EXIST !mongodbMSI! (
        ECHO Installing MongoDB in: !mongodbDIR! & ECHO. & ECHO.
        
        REM :: Install MongoDB and msilog.txt
        msiexec.exe /i !mongodbMSI! /l*v !miscDIR!\!msiLogFile! INSTALLLOCATION=!mongodbDIR! ADDLOCAL="All" /passive /norestart
        
        REM :: MongoDB still exists or not after installation?
        IF EXIST !mongoExists! (
            ECHO SUCCESSFUL INSTALLATION 
            ECHO.
        )
        IF NOT EXIST !mongoExists! (
            ECHO UNSUCCESSFUL INSTALLATION 
            ECHO.
        ) 
    )ELSE ( REM :: var "mongodbMSI" does not exists
        ECHO ERROR - MISSING OR INVALID INSTALLER FILE: & ECHO.
        ECHO 1. Download MongoDB to the same location as this program:
        ECHO    !mongodbDIR! & ECHO.
        ECHO 2. The downloaded file name and extension must be:  "!mongodbMSI!"
        CALL :EOP
    )
)

:MongoPathSetup REM :: MONGO PATH SETUP
(
    ECHO ACCESSED MongoPathSetup
)

:EOP REM :: End of Program
(
    ECHO.
    ECHO -----------------------------------------------------------
    ECHO !endOfProgramMessage! & PAUSE >nul & EXIT
)

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
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: FUNCTIONS
