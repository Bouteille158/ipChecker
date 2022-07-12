# IP Checker

## Requirements

Script tested on Ubuntu server 22.04 LTS for ARM on a Raspberry PI 4.
The mail was sent using a gmail account.
You must install the ssmtp package with the following commands :
```bash
sudo apt update
sudo apt install ssmtp 
````
Then you must set up an account in `/etc/ssmtp/ssmtp.conf`
````bash
sudo nano /etc/ssmtp/ssmtp.conf
````
With a Google account, since May 30, 2022, you can not use the standard password and must set up an App Password, click [here](https://support.google.com/accounts/answer/6010255) for more details.

## How the script works

1. The script *ipChecker.sh* first take the last know IP store in the _ipHistory_ file.
2. It then pings the openDNS server to know which public IP address is assigned to the device.
   * If the two IPs are identical, nothing happen.
   * If the two IPs are different, the script send an email using the SMTP user configured in `/etc/ssmtp/ssmtp.conf`
3. The script will then store a timestamp and the new IP in the ipHistory file for logging purpose

## Script setup
1. **Edit the destination mail** (line 11) the script will send the message to.
2. **Edit the mail message** (lines 25 to 30) the script will send. %s will be replaced by the new detected IP.
3. **Change the ipHistory file location** (line 10) if you want to give it another name or store it in another folder. The location can be relative to the script or an absolute path.

## Additional steps
### ipHistory 

The ipHistory file must follow this format :
````bash
12-07-2022T13:20:02
1.2.3.4
````
The script will take the IP stored in the last line. For now, there is no limit to the space the file can take, so be careful.

### Crontab
You can use crontab to launch the script regularly using :
````bash
crontab -e
````
For exemple, to launch the script every 15 minutes I use `*/15 * * * *`, use [crontab.guru](https://crontab.guru/) to easily find the best setting for your usage.

## TODO
* Limit the size of the ipHistory file by erasing older data