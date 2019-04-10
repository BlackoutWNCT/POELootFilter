
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



## Things that need to be done:
##   
##   - Add the ability to remove existing files for custom sounds filter
##   - Add the ability to revert to non-custom sounds files
##   - Refactor to use many more variables rather than manually defining each path
##   - Add if statement to detect for existing loot filter files and for existing temp files
##   - 

New-Item -ItemType Directory C:\tmp\POELootFilter
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Invoke-WebRequest 'https://github.com/NeverSinkDev/NeverSink-Filter/archive/master.zip' -OutFile 'C:\tmp\POELootFilter\master.zip'
Expand-Archive C:\tmp\POELootFilter\master.zip -DestinationPath C:\tmp\POELootFilter\

Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\*.filter"

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
            9  =  Custom Sounds (For Streamers)

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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 0-SOFT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT.filter"
                                    $ErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 1-REGULAR.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR.filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 2-SEMI-STRICT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 3-STRICT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 4-VERY-STRICT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 5-UBER-STRICT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT.filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\NeverSink's filter - 6-UBER-PLUS-STRICT.filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 0-SOFT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 1-REGULAR (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 2-SEMI-STRICT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 3-STRICT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 4-VERY-STRICT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 5-UBER-STRICT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Azurite) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) AZURITE\NeverSink's filter - 6-UBER-PLUS-STRICT (Azurite) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 0-SOFT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 1-REGULAR (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 2-SEMI-STRICT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 3-STRICT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 4-VERY-STRICT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 5-UBER-STRICT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Blue) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) BLUE\NeverSink's filter - 6-UBER-PLUS-STRICT (Blue) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 0-SOFT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 1-REGULAR (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 2-SEMI-STRICT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 3-STRICT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 4-VERY-STRICT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 5-UBER-STRICT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Gaia) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) GAIA\NeverSink's filter - 6-UBER-PLUS-STRICT (Gaia) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 0-SOFT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 1-REGULAR (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 2-SEMI-STRICT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 3-STRICT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 4-VERY-STRICT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 5-UBER-STRICT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Purple) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) PURPLE\NeverSink's filter - 6-UBER-PLUS-STRICT (Purple) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 0-SOFT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 1-REGULAR (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 2-SEMI-STRICT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 3-STRICT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 4-VERY-STRICT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 5-UBER-STRICT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Slick) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) SLICK\NeverSink's filter - 6-UBER-PLUS-STRICT (Slick) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 0-SOFT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 1-REGULAR (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 2-SEMI-STRICT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 3-STRICT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 4-VERY-STRICT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 5-UBER-STRICT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VAAL\NeverSink's filter - 6-UBER-PLUS-STRICT (Vaal) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 6-UBER-PLUS-STRICT (Vaal) .filter"
                                    $BaseErrorCode = 0
                                }
                                } 

                }
                8 {
                           Do {
                            $BaseErrorCode = 1
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 0-SOFT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 1-REGULAR (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 2-SEMI-STRICT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 3-STRICT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 4-VERY-STRICT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 5-UBER-STRICT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (Velvet) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) VELVET\NeverSink's filter - 6-UBER-PLUS-STRICT (Velvet) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 0-SOFT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 0-SOFT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                2 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 1-REGULAR (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 1-REGULAR (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                3 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 2-SEMI-STRICT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 2-SEMI-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                4 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 3-STRICT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 3-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                5 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 4-VERY-STRICT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 4-VERY-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                6 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 5-UBER-STRICT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
                                    [string]$FilterName = "NeverSink's filter - 5-UBER-STRICT (CustomSounds) .filter"
                                    $BaseErrorCode = 0
                                }
                                7 {
                                    Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\(STYLE) CUSTOMSOUNDS\NeverSink's filter - 6-UBER-PLUS-STRICT (CustomSounds) .filter" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
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

Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\ADDITIONAL-FILES" -Recurse -Force
Remove-Item "C:\users\$env:UserName\Documents\my games\Path of Exile\LICENSE" -Force
Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\ADDITIONAL-FILES" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"
Copy-Item "C:\tmp\POELootFilter\NeverSink-Filter-master\LICENSE" -Destination "C:\users\$env:UserName\Documents\my games\Path of Exile\"

[int]$FilterLine = Get-Content "C:\Users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini" | Select-string -Pattern 'item_filter=' | select-object -ExpandProperty LineNumber
[int]$FilterLineLoaded = Get-Content "C:\Users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini" | Select-string -Pattern 'item_filter_loaded_successfully=' | select-object -ExpandProperty LineNumber
$ConfigFile = Get-Content "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"
$ConfigFile[$FilterLine - 1]="item_filter=$FilterName"
$ConfigFile[$FilterLineLoaded - 1]="item_filter_loaded_successfully=$FilterName"
$ConfigFile | Out-File "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"


#$ConfigFileFilterLoaded = Get-Content "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"
#$ConfigFileFilterLoaded[$FilterLineLoaded]="item_filter_loaded_successfully=$FilterName"
#$ConfigFileFilterLoaded | Out-File "C:\users\$env:UserName\Documents\my games\Path of Exile\production_Config.ini"

Remove-Item 'C:\tmp\POELootFilter' -Recurse -force