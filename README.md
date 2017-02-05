<!-- Visual Studio Code: For a more comfortable reading experience, use the key combination Ctrl + Shift + V
     Visual Studio Code: To crop the tailing end space characters out, please use the key combination Ctrl + A Ctrl + K Ctrl + X (Formerly Ctrl + Shift + X)
     Visual Studio Code: To improve the formatting of HTML code, press Shift + Alt + F and the selected area will be reformatted in a html file.
     Visual Studio Code shortcuts: http://code.visualstudio.com/docs/customization/keybindings (or https://aka.ms/vscodekeybindings)
     Visual Studio Code shortcut PDF (Windows): https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf


   _____      _          _    _           _ __      __   _
  / ____|    | |        | |  | |         | |\ \    / /  | |
 | |  __  ___| |_ ______| |__| | __ _ ___| |_\ \  / /_ _| |_   _  ___
 | | |_ |/ _ \ __|______|  __  |/ _` / __| '_ \ \/ / _` | | | | |/ _ \
 | |__| |  __/ |_       | |  | | (_| \__ \ | | \  / (_| | | |_| |  __/
  \_____|\___|\__|      |_|  |_|\__,_|___/_| |_|\/ \__,_|_|\__,_|\___|                              -->


## Get-HashValue.ps1

<table>
   <tr>
      <td style="padding:6px"><strong>OS:</strong></td>
      <td style="padding:6px">Windows</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Type:</strong></td>
      <td style="padding:6px">A Windows PowerShell script</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Language:</strong></td>
      <td style="padding:6px">Windows PowerShell</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Description:</strong></td>
      <td style="padding:6px">Get-HashValue uses the inbuilt <code>Get-FileHash</code> cmdlet in machines that have PowerShell version 4 or later installed and .NET Framework v3.5 in machines that are running PowerShell version 2 or 3 for file analysation and for calculating the hash values. MD5, SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160 hash values are automatically displayed for files that are defined with the <code>-FilePath</code> parameter. To show only a certain hash type, the parameter <code>-Algorithm</code> may be added to the launching command.
      <br />
      <br />The <code>-FilePath</code> parameter accepts plain filenames (then the current directory gets searched for the inputted filename) or 'FullPath' filenames, which include the path to the file as well (such as <code>C:\Windows\explorer.exe</code>). To enter multiple files for analysation, please separate each individual entity with a comma. If the filename or the directory name includes space characters, please enclose the whole string (the individual entity in question) in quotation marks (single or double). 
      <br /> 
      <br />If any hash values are found, a text file (<code>hash_values.txt</code>) is created to <code>$env:temp</code>, which points to the current temporary file location and is set in the system (- for more information about <code>$env:temp</code>, please see the Notes section). The default output destination folder may be changed with the <code>-Output</code> parameter. During the possibly invoked text file creation procedure Get-HashValue tries to preserve any pre-existing content rather than overwrite the file, so if the text file already exists in the defined <code>-Output</code> folder, new log-info data is appended to the end of that file. Please note that if any of the parameter values include space characters, the value should be enclosed in quotation marks (single or double) so that PowerShell can interpret the command correctly.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Homepage:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-hash-value">https://github.com/auberginehill/get-hash-value</a>
      <br />Short URL: <a href="http://tinyurl.com/gv3n8fn">http://tinyurl.com/gv3n8fn</a></td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Version:</strong></td>
      <td style="padding:6px">1.0</td>
   </tr>
   <tr>
        <td style="padding:6px"><strong>Sources:</strong></td>
        <td style="padding:6px">
            <table>
                <tr>
                    <td style="padding:6px">Emojis:</td>
                    <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Twon of An:</td>
                    <td style="padding:6px"><a href="https://community.spiceworks.com/scripts/show/2263-get-the-sha1-sha256-sha384-sha512-md5-or-ripemd160-hash-of-a-file">Get the SHA1,SHA256,SHA384,SHA512,MD5 or RIPEMD160 hash of a file</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Gisli:</td>
                    <td style="padding:6px"><a href="http://stackoverflow.com/questions/8711564/unable-to-read-an-open-file-with-binary-reader">Unable to read an open file with binary reader</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Lee Holmes:</td>
                    <td style="padding:6px"><a href="http://www.leeholmes.com/guide">Windows PowerShell Cookbook (O'Reilly)</a>: Get-FileHash script</td>
                </tr>
            </table>
        </td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Downloads:</strong></td>
      <td style="padding:6px">For instance <a href="https://raw.githubusercontent.com/auberginehill/get-hash-value/master/Get-HashValue.ps1">Get-HashValue.ps1</a>. Or <a href="https://github.com/auberginehill/get-hash-value/archive/master.zip">everything as a .zip-file</a>.</td>
   </tr>
</table>




### Screenshot

<img class="screenshot" title="screenshot" alt="screenshot" height="100%" width="100%" src="https://raw.githubusercontent.com/auberginehill/get-hash-value/master/Get-HashValue.png">




### Parameters

<table>
    <tr>
        <th>:triangular_ruler:</th>
        <td style="padding:6px">
            <ul>
                <li>
                    <h5>Parameter <code>-FilePath</code></h5>
                    <p>with aliases <code>-FilenameWithPathName</code>, <code>-FullPath</code>, <code>-Source</code>, and <code>-File</code>. The <code>-FilePath</code> parameter determines, which file(s) is/are selected for hash value calculation, and in essence define the objects for Get-HashValue.</p>
                    <p>The <code>-FilePath</code> parameter accepts plain filenames (then the current directory gets searched for the inputted filename) or 'FullPath' filenames, which include the path
                    to the file as well (such as <code>C:\Windows\explorer.exe</code>). To enter multiple files for analysation, please separate each individual entity with a comma. If the filename or the directory name includes space characters, please enclose the whole string (the individual entity in question) in quotation marks (single or double). It's not mandatory to write <code>-FilePath</code> in the get hash value command to invoke the <code>-FilePath</code> parameter, as is shown in the Examples below, since Get-HashValue is trying to decipher the inputted queries as good as it is machinely possible within a 40 KB size limit. The <code>-FilePath</code> parameter also takes an array of strings and objects could be piped to this parameter, too. If no value for the <code>-FilePath</code> parameter is defined in the command launching Get-HashValue, the user will be prompted to enter a <code>-FilePath</code> value.</p>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>
                        <h5>Parameter <code>-Output</code></h5>
                        <p>with an alias <code>-ReportPath</code>. Specifies where the text file (<code>hash_values.txt</code>, which is created or updated with successfully calculated hash values) is to be saved. The text file includes the hash values and a timestamp, when the values were calculated. The default save location is <code>$env:temp</code>, which points to the current temporary file location, which is set in the system. The default <code>-Output</code> save location is defined at line 16 with the <code>$Output</code> variable. In case the path name includes space characters, please enclose the path name in quotation marks (single or double). For usage, please see the Examples below and for more information about <code>$env:temp</code>, please see the Notes section below.</p>
                    </li>
                </p>
                <p>
                    <li>
                        <h5>Parameter <code>-Algorithm</code></h5>
                        <p>with aliases <code>-Type</code>, <code>-Hash</code>, <code>-HashType</code>, <code>-Version</code> and <code>-Algo</code>. If the <code>-Algorithm</code> parameter is added to the command launching Get-HashValue, only the defined type of hash value of the object file(s) is displayed and written to the text file. The valid values for <code>-Algorithm</code> parameter are MD5, SHA1, SHA256, SHA384, SHA512, MACTripleDES or RIPEMD160. For best results, please specify only one valid value for <code>-Algorithm</code> parameter in one get hash value command. To make the <code>-Algorithm</code> parameter accept multiple values may be the focus of further development in Get-HashValue. If no <code>-Algorithm</code> parameter is defined in the command launching Get-HashValue, all  the available hash values (i.e. MD5, SHA256, SHA1, SHA384, SHA512, MACTripleDES and RIPEMD160) are displayed and written to a text file.</p>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>




### Outputs

<table>
    <tr>
        <th>:arrow_right:</th>
        <td style="padding:6px">
            <ul>
                <li>Displays information about hash values in console, and if any hash values were successfully calculated, writes or updates a text file (<code>hash_values.txt</code>) at <code>$env:temp</code> by default or at the location specified with the <code>-Output</code> parameter.</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Default values (the text file creation/updating procedure only occurs, if hash values are successfully calculated by Get-HashValue):</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Path</strong></td>
                                <td style="padding:6px"><strong>Type</strong></td>
                                <td style="padding:6px"><strong>Name</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\hash_values.txt</code></td>
                                <td style="padding:6px">TXT-file</td>
                                <td style="padding:6px"><code>hash_values.txt</code></td>
                            </tr>
                        </table>
                    </p>
                </ol>
            </ul>
        </td>
    </tr>
</table>




### Notes

<table>
    <tr>
        <th>:warning:</th>
        <td style="padding:6px">
            <ul>
                <li>Please note that all the parameters can be used in one get hash value command and that each of the parameters can be "tab completed" before typing them fully (by pressing the <code>[tab]</code> key).</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Please note that the default text file name (<code>hash_values.txt</code>) is defined at line 29 with the <code>$txt_filename</code> variable.</li>
                    <li>Please note that the possibly generated text file is created in a directory, which is end-user settable in each get hash value command with the <code>-Output</code> parameter. The default save location is defined with the <code>$Output</code> variable (at line 16). The <code>$env:temp</code> variable points to the current temp folder. The default value of the <code>$env:temp</code> variable is <code>C:\Users\&lt;username&gt;\AppData\Local\Temp</code> (i.e. each user account has their own separate temp folder at path <code>%USERPROFILE%\AppData\Local\Temp</code>). To see the current temp path, for instance a command
                    <br />
                    <br /><code>[System.IO.Path]::GetTempPath()</code>
                    <br />
                    <br />may be used at the PowerShell prompt window <code>[PS>]</code>. To change the temp folder for instance to <code>C:\Temp</code>, please, for example, follow the instructions at <a href="http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html">Temporary Files Folder - Change Location in Windows</a>, which in essence are something along the lines:
                        <ol>
                           <li>Right click on Computer and click on Properties (or select Start → Control Panel → System). In the resulting window with the basic information about the computer...</li>
                           <li>Click on Advanced system settings on the left panel and select Advanced tab on the resulting pop-up window.</li>
                           <li>Click on the button near the bottom labeled Environment Variables.</li>
                           <li>In the topmost section labeled User variables both TMP and TEMP may be seen. Each different login account is assigned its own temporary locations. These values can be changed by double clicking a value or by highlighting a value and selecting Edit. The specified path will be used by Windows and many other programs for temporary files. It's advisable to set the same value (a directory path) for both TMP and TEMP.</li>
                           <li>Any running programs need to be restarted for the new values to take effect. In fact, probably also Windows itself needs to be restarted for it to begin using the new values for its own temporary files.</li>
                        </ol>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>





### Examples

<table>
    <tr>
        <th>:book:</th>
        <td style="padding:6px">To open this code in Windows PowerShell, for instance:</td>
   </tr>
   <tr>
        <th></th>
        <td style="padding:6px">
            <ol>
                <p>
                    <li><code>./Get-HashValue a_certain_filename.exe</code><br />
                    Run the script. Please notice to insert <code>./</code> or <code>.\</code> before the script name. The current directory gets searched for the inputted filename "<code>a_certain_filename.exe</code>") and if any hash values were successfully calculated, the text file is saved to the default location (<code>$env:temp</code>). During the possibly invoked text file creation procedure Get-HashValue tries to preserve any pre-existing content rather than overwrite the file, so if the text file (<code>hash_values.txt</code>) already exists, new log-info data is appended to the end of that file.</li>
                </p>
                <p>
                    <li><code>help ./Get-HashValue -Full</code><br />
                    Display the help file.</li>
                </p>
                <p>
                    <li><code>./Get-HashValue -FilePath "C:\Windows\explorer.exe" -Output "C:\Scripts"</code><br />
                    Run the script and get  get the MD5, SHA1, SHA256, SHA384, SHA512, MACTripleDES and RIPEMD160 hash values from the "<code>C:\Windows\explorer.exe</code>" file and if any hash values were successfully calculated, save the text file to <code>C:\Scripts</code>. Please note, that <code>-FilePath</code> can be omitted in this example, because
                    <br />
                    <br /><code>./Get-HashValue "C:\Windows\explorer.exe" -Output "C:\Scripts"</code>
                    <br />
                    <br />will result in the exact same outcome.</li>
                </p>
                <p>
                    <li><code>./Get-HashValue -Source "C:\Users\Dropbox\a certain filename.exe" -Algorithm SHA256</code><br />
                    Will display the SHA256 hash value of "<code>C:\Users\Dropbox\a certain filename.exe</code>" in console and write it to a text file, which is saved to the default location (<code>$env:temp</code>). This command will work, because <code>-Source</code> is an alias of <code>-FilePath</code>. The <code>-FilePath</code> (a.k.a. <code>-Source</code> a.k.a. <code>-FilenameWithPathName</code> a.k.a. <code>-FullPath</code> a.k.a. <code>-File</code>) variable value is case-insensitive (as is most of the PowerShell), but since the filename contains space characters, the whole FullPath value needs to be enveloped with quotation marks. The <code>-Source</code> parameter may be left out from this command, since for example,
                    <br />
                    <br /><code>./Get-HashValue "c:\users\dROPBOx\A Certain Filename.exe" -Algorithm SHA256</code>
                    <br />
                    <br />is the exact same command in nature.</li>
                </p>
                <p>
                    <li><code>./Get-HashValue -FilePath "C:\Windows\explorer.exe", "C:\Users\Dropbox\a_certain_filename.exe"</code><br />
                    Will display the hash values of "<code>C:\Windows\explorer.exe</code>" and "<code>C:\Users\Dropbox\a_certain_filename.exe</code>" in console and write them to a text file, which is saved to the default location (<code>$env:temp</code>). Since the <code>-FilePath</code> values don't contain any space characters, they don't need to be enveloped with quotation marks, because
                    <br />
                    <br /><code>./Get-HashValue C:\Windows\explorer.exe, C:\Users\Dropbox\a_certain_filename.exe</code>
                    <br />
                    <br />would result in the same outcome.</li>
                </p>
                <p>
                    <li><p><code>Set-ExecutionPolicy remotesigned</code><br />
                    This command is altering the Windows PowerShell rights to enable script execution for the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights (run as an administrator) to actually be able to change the script execution properties. The default value of the default (LocalMachine) scope is "<code>Set-ExecutionPolicy restricted</code>".</p>
                        <p>Parameters:
                                <ol>
                                    <table>
                                        <tr>
                                            <td style="padding:6px"><code>Restricted</code></td>
                                            <td style="padding:6px">Does not load configuration files or run scripts. Restricted is the default execution policy.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>AllSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>RemoteSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files downloaded from the Internet be signed by a trusted publisher.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Unrestricted</code></td>
                                            <td style="padding:6px">Loads all configuration files and runs all scripts. If you run an unsigned script that was downloaded from the Internet, you are prompted for permission before it runs.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Bypass</code></td>
                                            <td style="padding:6px">Nothing is blocked and there are no warnings or prompts.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Undefined</code></td>
                                            <td style="padding:6px">Removes the currently assigned execution policy from the current scope. This parameter will not remove an execution policy that is set in a Group Policy scope.</td>
                                        </tr>
                                    </table>
                                </ol>
                        </p>
                    <p>For more information, please type "<code>Get-ExecutionPolicy -List</code>", "<code>help Set-ExecutionPolicy -Full</code>", "<code>help about_Execution_Policies</code>" or visit <a href="https://technet.microsoft.com/en-us/library/hh849812.aspx">Set-ExecutionPolicy</a> or <a href="http://go.microsoft.com/fwlink/?LinkID=135170">about_Execution_Policies</a>.</p>
                    </li>
                </p>
                <p>
                    <li><code>New-Item -ItemType File -Path C:\Temp\Get-HashValue.ps1</code><br />
                    Creates an empty ps1-file to the <code>C:\Temp</code> directory. The <code>New-Item</code> cmdlet has an inherent <code>-NoClobber</code> mode built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing file is about to happen. Overwriting a file with the <code>New-Item</code> cmdlet requires using the <code>Force</code>. If the path name includes space characters, please enclose the path name in quotation marks (single or double):
                        <ol>
                            <br /><code>New-Item -ItemType File -Path "C:\Folder Name\Get-HashValue.ps1"</code>
                        </ol>
                    <br />For more information, please type "<code>help New-Item -Full</code>".</li>
                </p>
            </ol>
        </td>
    </tr>
</table>




### Contributing

<p>Find a bug? Have a feature request? Here is how you can contribute to this project:</p>

 <table>
   <tr>
      <th><img class="emoji" title="contributing" alt="contributing" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f33f.png"></th>
      <td style="padding:6px"><strong>Bugs:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-hash-value/issues">Submit bugs</a> and help us verify fixes.</td>
   </tr>
   <tr>
      <th rowspan="2"></th>
      <td style="padding:6px"><strong>Feature Requests:</strong></td>
      <td style="padding:6px">Feature request can be submitted by <a href="https://github.com/auberginehill/get-hash-value/issues">creating an Issue</a>.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Edit Source Files:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-hash-value/pulls">Submit pull requests</a> for bug fixes and features and discuss existing proposals.</td>
   </tr>
 </table>




### www

<table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f310.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-hash-value">Script Homepage</a></td>
    </tr>
    <tr>
        <th rowspan="17"></th>
        <td style="padding:6px">Twon of An: <a href="https://community.spiceworks.com/scripts/show/2263-get-the-sha1-sha256-sha384-sha512-md5-or-ripemd160-hash-of-a-file">Get the SHA1,SHA256,SHA384,SHA512,MD5 or RIPEMD160 hash of a file</a></td>
    </tr>
    <tr>
        <td style="padding:6px">Gisli: <a href="http://stackoverflow.com/questions/8711564/unable-to-read-an-open-file-with-binary-reader">Unable to read an open file with binary reader</a></td>
    </tr>
    <tr>
        <td style="padding:6px">Lee Holmes: <a href="http://www.leeholmes.com/guide">Windows PowerShell Cookbook (O'Reilly)</a>: Get-FileHash script</td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.security.cryptography.sha256cryptoserviceprovider(v=vs.110).aspx">SHA256CryptoServiceProvider Class</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.security.cryptography.md5cryptoserviceprovider(v=vs.110).aspx">MD5CryptoServiceProvider Class</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.security.cryptography.mactripledes(v=vs.110).aspx">MACTripleDES Class</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.security.cryptography.ripemd160(v=vs.110).aspx">RIPEMD160 Class</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.security.cryptography(v=vs.110).aspx">System.Security.Cryptography Namespace</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/system.io.path_methods(v=vs.110).aspx">Path Methods</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://go.microsoft.com/fwlink/?LinkID=113418">Test-Path</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/">PowerShell Advanced Functions: Can we build them better?</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://stackoverflow.com/questions/21252824/how-do-i-get-powershell-4-cmdlets-such-as-test-netconnection-to-work-on-windows">How do I get PowerShell 4 cmdlets such as Test-NetConnection to work on Windows 7?</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/get-filehash">Get-FileHash</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://windowsitpro.com/scripting/calculate-md5-and-sha1-file-hashes-using-powershell">Calculate MD5 and SHA1 File Hashes Using PowerShell</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/quentinproust/8d3bd11562a12446644f">remove-duplicate-files.ps1</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://poshcode.org/2154">Get-FileHash.ps1</a></td>
    </tr> 
    <tr>
        <td style="padding:6px">ASCII Art: <a href="http://www.figlet.org/">http://www.figlet.org/</a> and <a href="http://www.network-science.de/ascii/">ASCII Art Text Generator</a></td>
    </tr>
</table>




### Related scripts

 <table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/0023-20e3.png"></th>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/aa812bfa79fa19fbd880b97bdc22e2c1">Disable-Defrag</a></td>
    </tr>
    <tr>
        <th rowspan="23"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/firefox-customization-files">Firefox Customization Files</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ascii-table">Get-AsciiTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-battery-info">Get-BatteryInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-computer-info">Get-ComputerInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-culture-tables">Get-CultureTables</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-directory-size">Get-DirectorySize</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">Get-InstalledPrograms</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-windows-updates">Get-InstalledWindowsUpdates</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-powershell-aliases-table">Get-PowerShellAliasesTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/9c2f26146a0c9d3d1f30ef0395b6e6f5">Get-PowerShellSpecialFolders</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ram-info">Get-RAMInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/eb07d0c781c09ea868123bf519374ee8">Get-TimeDifference</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table">Get-TimeZoneTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-unused-drive-letters">Get-UnusedDriveLetters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/java-update">Java-Update</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/remove-empty-folders">Remove-EmptyFolders</a></td>
    </tr>    
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/13bb9f56dc0882bf5e85a8f88ccd4610">Remove-EmptyFoldersLite</a></td>
    </tr> 
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/176774de38ebb3234b633c5fbc6f9e41">Rename-Files</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/rock-paper-scissors">Rock-Paper-Scissors</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/toss-a-coin">Toss-a-Coin</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-adobe-flash-player">Update-AdobeFlashPlayer</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-mozilla-firefox">Update-MozillaFirefox</a></td>
    </tr>
</table>
