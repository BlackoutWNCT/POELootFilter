
##############################################################################################################
##          // This Script is a work in progress and should be treated accordingly at all times \\          ##
##                                                                                                          ##
## Author: BlackoutWNCT                                                                                     ##
## Creation Date: 08/04/2019                                                                                ##
## Description: A script which downloads Neversink's latest POE loot filter from Github and installs only   ##
##              the filter that the user selects.                                                           ##
##                                                                                                          ##
##############################################################################################################
##
##  Changelog:
##
##      // Version 0.1
##          - Created switches for both Filter base type and for filter strictness levels
##          - Implemented download of loot filter files
##          - Implemented extraction and cleanup of loot filter files to tmp directory
##
##      // Version 0.2
##          - Added Copy of Additional Files Folder to POE Directory
##          - Added clean up of existing Additional Files folder to ensure all resources are up to date with newly applied filter.
##          - Added the ability to traverse back a menu
##          - Added the copying of the license file for the loot filter. While this seems trivial, I figured it'd be important to Neversink.
##
##      // Version 0.3
##          - Added updating of config file to apply selected loot filter.
##     
##      // Version 0.4
##          - Resolved an issue with option 1:1 which would exit the first level switch instead of the second level switch.
##
##      // Version 0.5
##          - Added new variables to make some of the code a little cleaner.
##          - Added some new functions to allow for some additional options and a nicer experience.
##          - Added an if statement to resolve the issue of the plain filter file not being contained within a folder from the zip
##          - Played around with a dick load of variables and make a bunch of them work. This was both entertaining and infuriating, and I'm not even sure they all work tbh. But no errors means ship it.

## Things that need to be done:
##   
##   - Add the ability to remove existing files for custom sounds filter
##   - Add the ability to revert to non-custom sounds files
##   - Refactor to use many more variables rather than manually defining each path
##       - This has been done to some extent, though still needs some work I feel. I'll look into this further later on.
##   - Add if statement to detect for existing loot filter files and for existing temp files
##   - Add an if statement to ask if old filter files should be removed
##
##
##
##

## This is a WIP, probably going to invoke a .net object or something to give a GUI selection, rather than leaving it purely to be input in a commandline
#$TempLocation = Read-Host -Prompt "Select location for temp files:"
##

$TempLocation = "C:\tmp\POELootFilter"
$TempFilterPath = "$TempLocation\NeverSink-Filter-master"
$FinalFilterPath = "C:\users\$env:UserName\Documents\my games\Path of Exile"

New-Item -ItemType Directory $TempLocation -ErrorAction SilentlyContinue
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Invoke-WebRequest 'https://github.com/NeverSinkDev/NeverSink-Filter/archive/master.zip' -OutFile "$TempLocation\master.zip"
Expand-Archive $TempLocation\master.zip -DestinationPath $TempLocation

## Old Content
#New-Item -ItemType Directory C:\tmp\POELootFilter
#Invoke-WebRequest 'https://github.com/NeverSinkDev/NeverSink-Filter/archive/master.zip' -OutFile 'C:\tmp\POELootFilter\master.zip'
#Expand-Archive C:\tmp\POELootFilter\master.zip -DestinationPath C:\tmp\POELootFilter\
##

## This is a testing block where I very much fail to make my if statement do the needful (I think I worked it out a bit later on, and changed some things, but it's not been tested yet, so not gonna use it yet)
#$ClearOldFiles = Do {Read-Host -Prompt "Would you like to clean up existing filter files? (This will clear any loot filter files currently in the loot filter folder. Use this option with caution.)"} until ( ($ClearOldFiles = "yes") -or ($ClearOldFiles = "no") )
#if { $ClearOldfiles = "yes" } ( Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\*.filter" ) -and ( $OldFilesCleared = Yes ) -else ( $OldFilesCleared = No ) endif
#$ClearOldFiles = Do {Read-Host -Prompt "Would you like to clean up existing filter files? (This will clear any loot filter files currently in the loot filter folder. Use this option with caution.)"} until ( ($ClearOldFiles = "yes") -or ($ClearOldFiles = "no") )
#if ( $ClearOldfiles -eq "yes" ) { Write-Host "Boop" }
#if ( $ClearOldfiles -eq "yes" ) { $OldFilesCleared = "Yes" } else { $OldFilesCleared = "No" }
#echo $OldFilesCleared
##

Remove-Item "$FinalFilterPath\*.filter"

Do {
        Do {
            Write-Host "
            Select Loot Filter Base

            Loot Filter Base List
            ---------------------------------------------
            1  =  Default
            2  =  Azurite
            3  =  Blue
            4  =  Gaia
            5  =  Purple
            6  =  Slick
            7  =  Vaal
            8  =  Velvet
            9  =  Custom Sounds (For Streamers) (This option needs some work, so best to avoid using for now)

            0  =  Exit Without Applying Filter
            ---------------------------------------------
            
            "
            [int]$FilterBase = read-host -prompt "Select Value (1 - 9) & Press Enter"
            } until ( ($FilterBase -ge 0) -and ($FilterBase -le 9))

            Switch ($FilterBase) {
                0 {
                $BaseErrorCode = 0
                }
                1 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = $null
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT.filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR.filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                2 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) AZURITE"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                3 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) BLUE"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                4 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) GAIA"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                5 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) PURPLE"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                6 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) SLICK"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $StrictErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                                } 
                7 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) VAAL"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                } 

                }
                8 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) VELVET"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                }
                9 {
                           Do {
                            $BaseErrorCode = 1
                            $BaseFilterFolder = "(STYLE) CUSTOMSOUNDS"
                            Write-Host "
                            Select Loot Filter Strictness

                            Loot Filter Strictness List
                            ---------------------------------------------
                            1  =  Soft
                            2  =  Regular
                            3  =  Semi Strict
                            4  =  Strict
                            5  =  Very Strict
                            6  =  Uber Strict
                            7  =  Uber Plus Strict

                            8  =  Return to Previous Menu
                            0  =  Exit Without Applying Filter
                            ---------------------------------------------
                
                            "
                            [int]$FilterStrictness = read-host -prompt "Select Value (1 - 8) & Press Enter"
                            } until ( ($FilterStrictness -ge 0) -and ($FilterStrictness -le 8) -or ($StrictErrorCode = 0) )

                            Switch ($FilterStrictness) {
                                0 {
                                    $BaseErrorCode = 0
                                }
                                1 {
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                
                                5 {
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                8 {
                                    $StrictErrorCode = 0
                                }
                                } 

                }
                  }
                
    } Until ($BaseErrorCode -eq 0)



$InstallPath = "$FinalFilterPath\$FilterName"
if ($BaseFilterFolder -eq $null) { $SourcePath = "$TempFilterPath\$FilterName" } else { $SourcePath = "$TempFilterPath\$BaseFilterFolder\$FilterName" }
# "{ $SourcePath = "$TempFilterPath$BaseFilterFolder\$FilterName" }" Needs to not have a "\" between "$TempFilterPath" and "$BaseFilterFolder" and I cannot for the fucking life of me work out why.

Copy-Item $SourcePath -Destination $InstallPath

Remove-Item "$FinalFilterPath\ADDITIONAL-FILES" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$FinalFilterPath\LICENSE" -Force -ErrorAction SilentlyContinue
Copy-Item "$TempFilterPath\ADDITIONAL-FILES" -Recurse -Destination "$FinalFilterPath" 
Copy-Item "$TempFilterPath\LICENSE" -Destination "$FinalFilterPath"

##Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\ADDITIONAL-FILES" -Recurse -Force
##Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\LICENSE" -Force
##Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\ADDITIONAL-FILES" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
##Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\LICENSE" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"


##Copy-Item "$TempFilterPath\NeverSink-Filter-master\LICENSE" -Destination "$InstallPath"
##Copy-Item "$TempFilterPath\NeverSink-Filter-master\ADDITIONAL-FILES" -Destination "$InstallPath"

## Testing this line now:
#Copy-Item $SourcePath -Destination $InstallPath


[int]$FilterLine = Get-Content "$FinalFilterPath\production_Config.ini" | Select-string -Pattern 'item_filter=' | select-object -ExpandProperty LineNumber
[int]$FilterLineLoaded = Get-Content "$FinalFilterPath\production_Config.ini" | Select-string -Pattern 'item_filter_loaded_successfully=' | select-object -ExpandProperty LineNumber
$ConfigFile = Get-Content "$FinalFilterPath\production_Config.ini"
$ConfigFile[$FilterLine - 1]="item_filter=$FilterName"
$ConfigFile[$FilterLineLoaded - 1]="item_filter_loaded_successfully=$FilterName"
$ConfigFile | Out-File "$FinalFilterPath\production_Config.ini"

##[int]$FilterLine = Get-Content "C:\Users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini" | Select-string -Pattern 'item_filter=' | select-object -ExpandProperty LineNumber
##[int]$FilterLineLoaded = Get-Content "C:\Users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini" | Select-string -Pattern 'item_filter_loaded_successfully=' | select-object -ExpandProperty LineNumber
##$ConfigFile = Get-Content "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"
##$ConfigFile[$FilterLine - 1]="item_filter=$FilterName"
##$ConfigFile[$FilterLineLoaded - 1]="item_filter_loaded_successfully=$FilterName"
##$ConfigFile | Out-File "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"

Remove-Item "$TempFilterPath" -Recurse -force