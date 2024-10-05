#!/bin/bash

TEMPFILE=/tmp/f2bstat.tmp
OUTPUTFILE=/tmp/f2bstat_output.txt
MESSAGEFILE=/tmp/message_output.txt
BOT_TOKEN=""  # Replace with your bot's token
CHAT_ID=""  # Replace with your chat ID

# Create temporary and output files if they don't exist
if [ ! -f $TEMPFILE ]; then
  touch $TEMPFILE
fi
if [ ! -f $OUTPUTFILE ]; then
  touch $OUTPUTFILE
fi
if [ ! -f $MESSAGEFILE ]; then
  touch $MESSAGEFILE
fi

# Get system information from /etc/os-release
OS_INFO=$(cat /etc/os-release | grep -E '^NAME=|^VERSION=' | sed 's/NAME=//' | sed 's/VERSION=//')

# Get network IP information using ifconfig (or you can replace with `ip addr`)
IP_INFO=$(ifconfig | grep -E 'inet ' | awk '{print $2}' | tr '\n' ' ')

# Get the current timestamp in the desired format
TIMESTAMP=$(date "+%d-%m-%Y - %T WIB")

# Initialize message with system info and network IPs
echo "*System Information:*" > $MESSAGEFILE
echo "Operating System: $OS_INFO" >> $MESSAGEFILE
echo "*Network IPs:* $IP_INFO" >> $MESSAGEFILE

# Add a clear description of the IP addresses being blocked
echo -e "\n*IP Addresses blocked by the server and their Locations:*" > $OUTPUTFILE

count=0

# Loop through blocked IPs and get location information
for ip in $(iptables -S | grep f2b | grep REJECT | awk '{print $4;}' | cut -d'/' -f1); do
  location=$(geoiplookup $ip | cut -d ':' -f 2)  # Get location info
  echo "$ip - $location" >> $OUTPUTFILE          # Write IP and location to the output file
  echo "$location" >> $TEMPFILE                  # Append location to the temp file for counting
  ((count++))
done

# Sort, count, and export the unique results to the message file
echo -e "\n*Summary blocked by the server and their Locations:*" >> $MESSAGEFILE
cat $TEMPFILE | sort | uniq -c | sort -rn >> $MESSAGEFILE
echo -e "\n*Total Blocked IPs:* $count" >> $MESSAGEFILE

# Add footer with timestamp
echo -e "\n*Generated on $TIMESTAMP*" >> $MESSAGEFILE

# Read the summary and system information to send via Telegram as a message
message=$(cat $MESSAGEFILE)

# Send the system info, network IPs, and summary as a message to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$message" \
     -d parse_mode="Markdown"

# Send the IP Addresses and Locations as a file to Telegram with timestamp in the caption
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
     -F chat_id="$CHAT_ID" \
     -F document=@$OUTPUTFILE \
     -F caption="List of IP Addresses blocked by the server and their Locations, $TIMESTAMP"

# Clean up temporary files
rm $TEMPFILE
rm $OUTPUTFILE
rm $MESSAGEFILE
