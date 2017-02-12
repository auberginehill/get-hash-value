<#
Get-HashValue.ps1
#>


[CmdletBinding()]
Param (
    [Parameter(ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName=$true,
    Mandatory=$true,
      HelpMessage="`r`nWhich file would you like to target? `r`n`r`nPlease enter a valid system filename ('FullPath'), which preferably includes the path to the file as well (a full path name of a file such as C:\Windows\explorer.exe). `r`n`r`nNotes:`r`n`t- If no path is defined, the current directory gets searched for the filename. `r`n`t- If the full filename or the directory name includes space characters, `r`n`t   please enclose the whole inputted string in quotation marks (single or double). `r`n`t- To stop entering new values, please press [Enter] at an empty input row (and the script will run). `r`n`t- To exit this script, please press [Ctrl] + C`r`n")]
    [ValidateNotNullOrEmpty()]
    [Alias("FilenameWithPathName","FullPath","Source","File")]
    [string[]]$FilePath,
    [Alias("ReportPath")]
    [string]$Output = "$env:temp",
    [ValidateSet("MD5","SHA1","SHA256","SHA384","SHA512","MACTripleDES","RIPEMD160")]
    [Alias("Type","Hash","HashType","Version","Algo")]
    [string[]]$Algorithm
)




Begin {


    # Establish some common variables
    $txt_filename = "hash_values.txt"
    $separator = "---------------------"
    $ErrorActionPreference = "Stop"
    $computer = $env:COMPUTERNAME
    $empty_line = ""
    $files = @()
    $results = @()
    $skipped = @()
    $skipped_path_names = @()
    $num_invalid_paths = 0


    # Test if the Output-path ("ReportPath") exists
    If ((Test-Path $Output) -eq $false) {

        $invalid_output_path_was_found = $true

        # Display an error message in console
        $empty_line | Out-String
        Write-Warning "'$Output' doesn't seem to be a valid path name."
        $empty_line | Out-String
        Write-Verbose "Please consider checking that the Output ('ReportPath') location '$Output', where the resulting text file is ought to be written, was typed correctly and that it is a valid file system path, which points to a directory. If the path name includes space characters, please enclose the path name in quotation marks (single or double)." -verbose
        $empty_line | Out-String
        $skip_text = "Couldn't find -Output folder '$Output'..."
        Write-Output $skip_text
        $empty_line | Out-String
        Exit
        Return

    } Else {

        # Resolve the Output-path ("ReportPath") (if the Output-path is specified as relative)
        $real_output_path = Resolve-Path -Path $Output
        $txt_file = "$real_output_path\$txt_filename"

    } # Else (If Test-Path $Output)


    # If a filename is specified, add that to the list of files to process
    # Source: http://poshcode.org/2154
    # Credit: Lee Holmes: "Windows PowerShell Cookbook (O'Reilly)" (Get-FileHash script) http://www.leeholmes.com/guide
    If ($FilePath) {

        ForEach ($path in $FilePath) {

        # Test if the path exists

            If ((Test-Path $path) -eq $false) {

                $invalid_filepath_was_found = $true

                # Increment the error counter
                $num_invalid_paths++

                # Display an error message in console
                $empty_line | Out-String
                Write-Warning "'$path' doesn't seem to be a valid FullPath or FilePath value."
                $empty_line | Out-String
                Write-Verbose "Please consider checking that the full filename with the path name (the '-FilePath' variable value) '$path' was typed correctly and that it includes the path to the file as well. If the full filename or the directory name includes space characters, please enclose the whole string in quotation marks (single or double)." -verbose
                $empty_line | Out-String
                $skip_text = "Skipping '$path' from the results."
                Write-Output $skip_text

                    # Add the file candidate as an object (with properties) to a collection of skipped paths
                    $skipped += $obj_skipped = New-Object -TypeName PSCustomObject -Property @{

                                'Skipped FilePath Values'   = $path
                                'Owner'                     = ""
                                'Created on'                = ""
                                'Last Updated'              = ""
                                'Size'                      = "-"
                                'Error'                     = "The file was not found on $computer."
                                'raw_size'                  = 0

                        } # New-Object

                # Add the file candidate to a list of failed filenames
                $skipped_path_names += $path

                # Return to top of the program loop (ForEach $path) and skip just this iteration of the loop.
                Continue

            } Else {

                # Resolve path (if path is specified as relative)
                $real_path = (Resolve-Path $path).Path
                $files += $real_path

            } # Else (If Test-Path $path)

        } # ForEach $path

    } Else {
        # Take the files that are piped into the script
        $files += @($input | Foreach-Object { $_.FullName })
    } # Else (If $FilePath)


    # Create the hash value calculators for PowerShell versions 2 and 3
    # Requires .NET Framework v3.5
    # Source: http://stackoverflow.com/questions/21252824/how-do-i-get-powershell-4-cmdlets-such-as-test-netconnection-to-work-on-windows
    # Source: https://msdn.microsoft.com/en-us/library/system.security.cryptography.sha256cryptoserviceprovider(v=vs.110).aspx
    # Source: https://msdn.microsoft.com/en-us/library/system.security.cryptography.md5cryptoserviceprovider(v=vs.110).aspx
    # Source: https://msdn.microsoft.com/en-us/library/system.security.cryptography(v=vs.110).aspx
    # Source: https://msdn.microsoft.com/en-us/library/system.security.cryptography.mactripledes(v=vs.110).aspx
    # Source: https://msdn.microsoft.com/en-us/library/system.security.cryptography.ripemd160(v=vs.110).aspx
    # Credit: Twon of An: "Get the SHA1,SHA256,SHA384,SHA512,MD5 or RIPEMD160 hash of a file" https://community.spiceworks.com/scripts/show/2263-get-the-sha1-sha256-sha384-sha512-md5-or-ripemd160-hash-of-a-file
    If (($PSVersionTable.PSVersion).Major -lt 4) {
        $MD5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
        $SHA256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
        $SHA1 = New-Object -TypeName System.Security.Cryptography.SHA1CryptoServiceProvider
        $SHA384 = New-Object -TypeName System.Security.Cryptography.SHA384CryptoServiceProvider
        $SHA512 = New-Object -TypeName System.Security.Cryptography.SHA512CryptoServiceProvider
        $MACTripleDES = New-Object -TypeName System.Security.Cryptography.MACTripleDES
        $RIPEMD160 = [System.Security.Cryptography.HashAlgorithm]::Create("RIPEMD160")
    } Else {
        $continue = $true
    } # Else (If $FilePath)


} # Begin




Process {

    # Process each file
    # Source: http://poshcode.org/2154
    # Credit: Lee Holmes: "Windows PowerShell Cookbook (O'Reilly)" (Get-FileHash script) http://www.leeholmes.com/guide
    ForEach ($file in $files) {

        # Source: http://go.microsoft.com/fwlink/?LinkID=113418
        If ((Test-Path $file -PathType Leaf) -eq $false) {

                    # Increment the error counter
                    $num_invalid_paths++

                    # Add the file candidate as an object (with properties) to a collection of skipped paths
                    $skipped += $obj_skipped = New-Object -TypeName PSCustomObject -Property @{

                                'Skipped FilePath Values'   = $file
                                'Owner'                     = ""
                                'Created on'                = ""
                                'Last Updated'              = ""
                                'Size'                      = "-"
                                'Error'                     = "The FilePath value points to a directory."
                                'raw_size'                  = 0

                        } # New-Object

                    # Add the file candidate to a list of failed filenames
                    $skipped_path_names += $file

            # Skip the item ($file) if it is not a file (return to top of the program loop (ForEach $file)
            Continue

        } Else {

            # Convert the item ($file) to a fully-qualified path
            $full_path = (Resolve-Path $file).Path

            If (($PSVersionTable.PSVersion).Major -ge 4) {
                # Requires PowerShell version 4.0
                # Source: https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/get-filehash
                $hash_MD5 = Get-FileHash $full_path -Algorithm MD5 | Select-Object -ExpandProperty Hash
                $hash_SHA256 = Get-FileHash $full_path -Algorithm SHA256 | Select-Object -ExpandProperty Hash
                $hash_SHA1 = Get-FileHash $full_path -Algorithm SHA1 | Select-Object -ExpandProperty Hash
                $hash_SHA384 = Get-FileHash $full_path -Algorithm SHA384 | Select-Object -ExpandProperty Hash
                $hash_SHA512 = Get-FileHash $full_path -Algorithm SHA512 | Select-Object -ExpandProperty Hash
                $hash_MACTripleDES = Get-FileHash $full_path -Algorithm MACTripleDES | Select-Object -ExpandProperty Hash
                $hash_RIPEMD160 = Get-FileHash $full_path -Algorithm RIPEMD160 | Select-Object -ExpandProperty Hash
            } Else {
                # Get MD5, SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160 hash values in PowerShell version 2
                # Calculate the hash of the file regardless whether it is opened in another program or not
                # Source: http://stackoverflow.com/questions/21252824/how-do-i-get-powershell-4-cmdlets-such-as-test-netconnection-to-work-on-windows
                # Credit: Gisli: "Unable to read an open file with binary reader" http://stackoverflow.com/questions/8711564/unable-to-read-an-open-file-with-binary-reader
                    # MD5 (PowerShell v2)
                    $source_file_a = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_MD5 = [System.BitConverter]::ToString($MD5.ComputeHash($source_file_a)) -replace "-",""
                    $source_file_a.Close()

                    # SHA256 (PowerShell v2)
                    $source_file_b = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_SHA256 = [System.BitConverter]::ToString($SHA256.ComputeHash($source_file_b)) -replace "-",""
                    $source_file_b.Close()

                    # SHA1 (PowerShell v2)
                    $source_file_c = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_SHA1 = [System.BitConverter]::ToString($SHA1.ComputeHash($source_file_c)) -replace "-",""
                    $source_file_c.Close()

                    # SHA384 (PowerShell v2)
                    $source_file_d = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_SHA384 = [System.BitConverter]::ToString($SHA384.ComputeHash($source_file_d)) -replace "-",""
                    $source_file_d.Close()

                    # SHA512 (PowerShell v2)
                    $source_file_e = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_SHA512 = [System.BitConverter]::ToString($SHA512.ComputeHash($source_file_e)) -replace "-",""
                    $source_file_e.Close()

                    # MACTripleDES (PowerShell v2)
                    $source_file_f = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_MACTripleDES = [System.BitConverter]::ToString($MACTripleDES.ComputeHash($source_file_f)) -replace "-",""
                    $source_file_f.Close()

                    # RIPEMD160 (PowerShell v2)
                    $source_file_g = [System.IO.File]::Open("$full_path",[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
                    $hash_RIPEMD160 = [System.BitConverter]::ToString($RIPEMD160.ComputeHash($source_file_g)) -replace "-",""
                    $source_file_g.Close()
            } # Else (If $PSVersionTable.PSVersion)

        } # Else (If Test-Path $file)

        # Source: https://msdn.microsoft.com/en-us/library/system.io.path_methods(v=vs.110).aspx
        $filename = ([System.IO.Path]::GetFileName($full_path))
        $path = ([System.IO.Path]::GetFullPath($full_path))
        $directory = ([System.IO.Path]::GetDirectoryName($full_path))
        $extension = ([System.IO.Path]::GetExtension($full_path))
        $filename_without_extension = ([System.IO.Path]::GetFileNameWithoutExtension($full_path))

                                $results += New-Object -TypeName PSCustomObject -Property @{
                                        'File'          = $filename
                                        'Directory'     = $directory
                                        'Extension'     = $extension
                                        'File Name'     = $filename_without_extension
                                        'Full Path'     = $full_path
                                        'Full_Path'     = $full_path
                                        'MD5'           = $hash_MD5
                                        'MACTripleDES'  = $hash_MACTripleDES
                                        'RIPEMD160'     = $hash_RIPEMD160
                                        'SHA1'          = $hash_SHA1
                                        'SHA384'        = $hash_SHA384
                                        'SHA512'        = $hash_SHA512
                                        'SHA256'        = $hash_SHA256
                                } # New-Object
    } # ForEach ($file)
} # Process




End {

                # Do the background work for natural language
                If ($results.Count -gt 1) { $item_text = "items" } Else { $item_text = "item" }
                $unique_folders = "$(($results | select -ExpandProperty Directory -Unique) -join ', ')"
                $empty_line | Out-String

                # Write the operational stats in console
                If ($skipped_path_names.Count -eq 0) {
                    $enumeration_went_succesfully = $true
                            If ($results.Count -le 4) {
                                $stats_text = "Total $($results.Count) $item_text processed at $unique_folders."
                            } Else {
                                $stats_text = "Total $($results.Count) $item_text processed."
                            } # Else (If $results.Count)
                    Write-Output $stats_text

                } Else {

                    # Display the skipped path names and write the operational stats in console
                    $enumeration_went_succesfully = $false
                    $skipped.PSObject.TypeNames.Insert(0,"Skipped FilePath Names")
                    $skipped_selection = $skipped | Select-Object 'Skipped FilePath Values','Size','Error' | Sort-Object 'Skipped FilePath Values'
                    $skipped_selection | Format-Table -auto
                            If ($num_invalid_paths -gt 1) {
                                If ($results.Count -eq 0) {
                                    $stats_text = "There were $num_invalid_paths skipped FilePath values. Didn't process any files."
                                } ElseIf ($results.Count -le 4) {
                                    $stats_text = "Total $($results.Count) $item_text processed at $unique_folders. There were $num_invalid_paths skipped FilePath values."
                                } Else {
                                    $stats_text = "Total $($results.Count) $item_text processed. There were $num_invalid_paths skipped FilePath values."
                                } # Else (If $results.Count)
                            } Else {
                                If ($results.Count -eq 0) {
                                    $stats_text = "One FilePath value was skipped. Didn't process any files."
                                } ElseIf ($results.Count -le 4) {
                                    $stats_text = "Total $($results.Count) $item_text processed at $unique_folders. One FilePath value was skipped."
                                } Else {
                                    $stats_text = "Total $($results.Count) $item_text processed. One FilePath value was skipped."
                                } # Else (If $results.Count)
                            } # Else (If $num_invalid_paths)
                    Write-Output $stats_text

                } # Else (If $skipped_path_names.Count)


    If ($results.Count -ge 1) {


        # Write the hash values in console
        $results.PSObject.TypeNames.Insert(0,"Hash Values")
                If ($Algorithm) {

                                # Create an array of the $Algorithm values
                                # Source: Tobias Weltner: "PowerTips Monthly Volume 2: Arrays and Hash Tables" http://powershell.com/cs/media/p/24814.aspx
                                $selection = "File", "Full Path"

                                            Switch ($Algorithm) {
                                                "MD5"           { $selection += "MD5" }
                                                "SHA256"        { $selection += "SHA256" }
                                                "SHA1"          { $selection += "SHA1" }
                                                "SHA384"        { $selection += "SHA384" }
                                                "SHA512"        { $selection += "SHA512" }
                                                "MACTripleDES"  { $selection += "MACTripleDES" }
                                                "RIPEMD160"     { $selection += "RIPEMD160" }
                                            } # switch

                    $results_selection = $results | select $selection
                } Else {
                    $results_selection = $results | select 'File','Full Path','MD5','MACTripleDES','RIPEMD160','SHA1','SHA384','SHA512','SHA256'
                } # Else
        Write-Output $results_selection | Format-List


                # Write the hash valuess to a text file (located at the current temp-folder or the location is defined with the -Output parameter)
                If ((Test-Path $txt_file) -eq $false) {
                    ($results_selection | Format-List) | Out-File "$txt_file" -Encoding UTF8 -Force
                    Add-Content -Path "$txt_file" -Value "Date: $(Get-Date -Format g)"
                } Else {
                    $pre_existing_content = Get-Content $txt_file
                    ($pre_existing_content + $empty_line + $empty_line + $separator + $empty_line + ($results_selection | Format-List)) | Out-File "$txt_file" -Encoding UTF8 -Force
                    Add-Content -Path "$txt_file" -Value "Date: $(Get-Date -Format g)"
                } # Else (If Test-Path)

    } Else {
        $empty_line | Out-String
    } # Else (If $results.Count)
} # End




# [End of Line]


<#


   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|


https://community.spiceworks.com/scripts/show/2263-get-the-sha1-sha256-sha384-sha512-md5-or-ripemd160-hash-of-a-file    # Twon of An: "Get the SHA1,SHA256,SHA384,SHA512,MD5 or RIPEMD160 hash of a file"
http://stackoverflow.com/questions/8711564/unable-to-read-an-open-file-with-binary-reader                               # Gisli: "Unable to read an open file with binary reader"
http://www.leeholmes.com/guide                                                                                          # Lee Holmes: "Windows PowerShell Cookbook (O'Reilly)" (Get-FileHash script)


  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|
#>

<#

.SYNOPSIS
Retrieves the MD5, SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160
hash values from one or multiple specified files in Windows PowerShell version 2
or later.

.DESCRIPTION
Get-HashValue uses the inbuilt Get-FileHash cmdlet in machines that have PowerShell
version 4 or later installed and .NET Framework in machines that are running
PowerShell version 2 or 3 for file analysation and for calculating the hash values.
MD5, SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160 hash values are
automatically displayed for files the that are defined with the -FilePath parameter.
To show a certain hash type or a selection of the aforementioned hash types, the
parameter -Algorithm may be added to the launching command.

The -FilePath parameter accepts plain filenames (then the current directory gets
searched for the inputted filename) or 'FullPath' filenames, which include the path
to the file as well (such as C:\Windows\explorer.exe). To enter multiple files for
analysation, please separate each individual entity with a comma. If the filename or
the directory name includes space characters, please enclose the whole string
(the individual entity in question) in quotation marks (single or double).

If any hash values are successfully calculated, a text file (hash_values.txt) is 
created to $env:temp, which points to the current temporary file location and is 
set in the system (- for more information about $env:temp, please see the Notes 
section). The default output destination folder may be changed with the -Output 
parameter. During the possibly invoked text file creation procedure Get-HashValue 
tries to preserve any pre-existing content rather than overwrite the file, so if 
the text file already exists in the defined -Output folder, new data is appended 
to the end of that file. Please note that if any of the parameter values include 
space characters, the value should be enclosed in quotation marks (single or double)
so that PowerShell can interpret the command correctly.

.PARAMETER FilePath
with aliases -FilenameWithPathName, -FullPath, -Source, and -File. The -FilePath
parameter determines, which file(s) is/are selected for hash value calculation, and
in essence define the objects for Get-HashValue.

The -FilePath parameter accepts plain filenames (then the current directory gets
searched for the inputted filename) or 'FullPath' filenames, which include the path
to the file as well (such as C:\Windows\explorer.exe). To enter multiple files for
analysation, please separate each individual entity with a comma. If the filename or
the directory name includes space characters, please enclose the whole string
(the individual entity in question) in quotation marks (single or double). It's not
mandatory to write -FilePath in the get hash value command to invoke the -FilePath
parameter, as is shown in the Examples below, since Get-HashValue is trying to
decipher the inputted queries as good as it is machinely possible within a 40 KB
size limit. The -FilePath parameter also takes an array of strings and objects
could be piped to this parameter, too. If no value for the -FilePath parameter
is defined in the command launching Get-HashValue, the user will be prompted to
enter a -FilePath value.

.PARAMETER Output
with an alias -ReportPath. Specifies where the text file (hash_values.txt, which is
created or updated with successfully calculated hash values) is to be saved. The
text file includes the hash values and a timestamp, when the values were calculated.
The default save location is $env:temp, which points to the current temporary file
location, which is set in the system. The default -Output save location is defined
at line 16 with the $Output variable. In case the path name includes space
characters, please enclose the path name in quotation marks (single or double).
For usage, please see the Examples below and for more information about $env:temp,
please see the Notes section below.

.PARAMETER Algorithm
with aliases -Type, -Hash, -HashType, -Version and -Algo. To enter multiple values
to the -Algorithm parameter, please separate each individual entity with a comma.
If the -Algorithm parameter is added to the command launching Get-HashValue, the
defined types of hash values of the object file(s) are displayed and written
to the text file. The valid values for -Algorithm parameter are MD5, SHA1, SHA256,
SHA384, SHA512, MACTripleDES and RIPEMD160. If no -Algorithm parameter is defined
in the command launching Get-HashValue, all the available hash values (i.e. MD5,
SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160) are displayed and
written to a text file.

.OUTPUTS
Displays information about hash values in console, and if any hash values were
successfully calculated, writes or updates a text file (hash_values.txt) at
$env:temp by default or at the location specified with the -Output parameter.


    Default values (the text file creation/updating procedure only occurs, if
    hash values are successfully calculated by Get-HashValue):


        $env:temp\hash_values.txt       : TXT-file     : hash_values.txt


.NOTES
Please note that all the parameters can be used in one get hash value command
and that each of the parameters can be "tab completed" before typing them fully (by
pressing the [tab] key).

Please note that the default text file name (hash_values.txt) is defined at
line 29 with the $txt_filename variable.

Please note that the possibly generated text file is created in a directory,
which is end-user settable in each get hash value command with the -Output
parameter. The default save location is defined with the $Output variable (at
line 16). The $env:temp variable points to the current temp folder. The default
value of the $env:temp variable is C:\Users\<username>\AppData\Local\Temp
(i.e. each user account has their own separate temp folder at path
%USERPROFILE%\AppData\Local\Temp). To see the current temp path, for instance
a command

    [System.IO.Path]::GetTempPath()

may be used at the PowerShell prompt window [PS>]. To change the temp folder for
instance to C:\Temp, please, for example, follow the instructions at
http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html

    Homepage:           https://github.com/auberginehill/get-hash-value
    Short URL:          http://tinyurl.com/gv3n8fn
    Version:            1.2

.EXAMPLE
./Get-HashValue a_certain_filename.exe
Run the script. Please notice to insert ./ or .\ before the script name.
The current directory gets searched for the inputted filename
"a_certain_filename.exe") and if any hash values were successfully calculated, the
text file is saved to the default location ($env:temp). During the possibly invoked
text file creation procedure Get-HashValue tries to preserve any pre-existing content
rather than overwrite the file, so if the text file (hash_values.txt) already
exists, new data is appended to the end of that file.

.EXAMPLE
help ./Get-HashValue -Full
Display the help file.

.EXAMPLE
./Get-HashValue -FilePath "C:\Windows\explorer.exe" -Output "C:\Scripts"
Run the script and get the MD5, SHA1, SHA256, SHA384, SHA512, MACTripleDES and
RIPEMD160 hash values from the "C:\Windows\explorer.exe" file and if any hash values
were successfully calculated, save the text file to C:\Scripts. Please note, that
-FilePath can be omitted in this example, because

    ./Get-HashValue "C:\Windows\explorer.exe" -Output "C:\Scripts"

will result in the same outcome.

.EXAMPLE
./Get-HashValue -Source "C:\Users\Dropbox\a certain filename.exe" -Algorithm SHA256, MD5
Will display the SHA256 and MD5 hash values of
"C:\Users\Dropbox\a certain filename.exe" in console and write them to a text file,
which is saved to the default location ($env:temp). This command will work, because
-Source is an alias of -FilePath. The -FilePath (a.k.a. -Source a.k.a.
-FilenameWithPathName a.k.a. -FullPath a.k.a. -File) variable value is
case-insensitive (as is most of the PowerShell), but since the filename contains
space characters, the whole FullPath value needs to be enveloped with quotation
marks. Furthermore, the word -Source and the space character in the -Algorithm value
list may be left out from this command, since, for example,

    ./Get-HashValue "c:\users\dROPBOx\A Certain Filename.exe" -Algorithm sha256,md5

is the exact same command in nature.

.EXAMPLE
./Get-HashValue -FilePath "C:\Windows\explorer.exe", "C:\Users\Dropbox\a_certain_filename.exe"
Will display the hash values of "C:\Windows\explorer.exe" and
"C:\Users\Dropbox\a_certain_filename.exe" in console and write them to a text file,
which is saved to the default location ($env:temp). Since the -FilePath values don't
contain any space characters, they don't need to be enveloped with quotation marks,
because

    ./Get-HashValue C:\Windows\explorer.exe, C:\Users\Dropbox\a_certain_filename.exe

would result in the same outcome.

.EXAMPLE
Set-ExecutionPolicy remotesigned
This command is altering the Windows PowerShell rights to enable script execution for
the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights
(run as an administrator) to actually be able to change the script execution properties.
The default value of the default (LocalMachine) scope is "Set-ExecutionPolicy restricted".


    Parameters:

    Restricted      Does not load configuration files or run scripts. Restricted is the default
                    execution policy.

    AllSigned       Requires that all scripts and configuration files be signed by a trusted
                    publisher, including scripts that you write on the local computer.

    RemoteSigned    Requires that all scripts and configuration files downloaded from the Internet
                    be signed by a trusted publisher.

    Unrestricted    Loads all configuration files and runs all scripts. If you run an unsigned
                    script that was downloaded from the Internet, you are prompted for permission
                    before it runs.

    Bypass          Nothing is blocked and there are no warnings or prompts.

    Undefined       Removes the currently assigned execution policy from the current scope.
                    This parameter will not remove an execution policy that is set in a Group
                    Policy scope.


For more information, please type "Get-ExecutionPolicy -List", "help Set-ExecutionPolicy -Full",
"help about_Execution_Policies" or visit https://technet.microsoft.com/en-us/library/hh849812.aspx
or http://go.microsoft.com/fwlink/?LinkID=135170.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Get-HashValue.ps1
Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force. If the
path name and/or the filename includes space characters, please enclose the whole -Path parameter value
in quotation marks (single or double):

    New-Item -ItemType File -Path "C:\Folder Name\Get-HashValue.ps1"

For more information, please type "help New-Item -Full".

.LINK
https://community.spiceworks.com/scripts/show/2263-get-the-sha1-sha256-sha384-sha512-md5-or-ripemd160-hash-of-a-file
http://stackoverflow.com/questions/8711564/unable-to-read-an-open-file-with-binary-reader
http://www.leeholmes.com/guide
https://msdn.microsoft.com/en-us/library/system.security.cryptography.sha256cryptoserviceprovider(v=vs.110).aspx
https://msdn.microsoft.com/en-us/library/system.security.cryptography.md5cryptoserviceprovider(v=vs.110).aspx
https://msdn.microsoft.com/en-us/library/system.security.cryptography.mactripledes(v=vs.110).aspx
https://msdn.microsoft.com/en-us/library/system.security.cryptography.ripemd160(v=vs.110).aspx
https://msdn.microsoft.com/en-us/library/system.security.cryptography(v=vs.110).aspx
https://msdn.microsoft.com/en-us/library/system.io.path_methods(v=vs.110).aspx
http://go.microsoft.com/fwlink/?LinkID=113418
http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/
http://stackoverflow.com/questions/21252824/how-do-i-get-powershell-4-cmdlets-such-as-test-netconnection-to-work-on-windows
https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/get-filehash
http://windowsitpro.com/scripting/calculate-md5-and-sha1-file-hashes-using-powershell
https://gist.github.com/quentinproust/8d3bd11562a12446644f
http://powershell.com/cs/media/p/24814.aspx
http://poshcode.org/2154

#>
