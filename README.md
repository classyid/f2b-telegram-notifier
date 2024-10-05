# Fail2Ban IP Blocking Notification Script

This script helps system administrators monitor IP addresses blocked by Fail2Ban and sends the list of blocked IPs along with their geolocation to a Telegram bot.

### Features:
- Sends system information and network IPs to a Telegram bot.
- Lists all IP addresses blocked by Fail2Ban.
- Shows geolocation of each IP address.
- Provides a summary and the total count of blocked IPs.
- Sends the detailed list in a text file to the Telegram bot.

### Requirements:

Make sure the following packages are installed on your Linux server:

1. **`iptables`**: To retrieve blocked IPs by Fail2Ban.
   ```bash
   sudo apt-get install iptables
geoip-bin: To fetch geolocation data based on the IP addresses.
sudo apt-get install geoip-bin
sudo apt-get install fail2ban
Setup:
Create a bot using BotFather and get the BOT_TOKEN.
Find your chat ID by messaging the bot and accessing the Telegram Bot API via the following URL:
bash
Copy code
https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
Update the script by replacing:
BOT_TOKEN="" with your actual bot token.
CHAT_ID="" with your Telegram chat ID.
How to Use:
Clone this repository.
Make the script executable:
bash
Copy code
chmod +x f2bstat.sh
Run the script:
bash
Copy code
./f2bstat.sh
The script will send a Telegram message containing system and network information, along with a summary of blocked IPs. It will also upload a .txt file with the detailed list of blocked IPs and their locations.
