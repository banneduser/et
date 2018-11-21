echo "UPSTREAM=$(dig +short _gateway)" >> .bashrc
# set up chron job
echo "What is the IP address of your phone?"
read phone_ip
UPSTREAM=$phone_ip
echo "Thank you. Your phone's IP has been registered."
echo "This script now try to establish a connection. Please ensure that this phone: "
echo "	- Has an SSH server running on port 8022, preferably the Termux one"
echo "  - Does not have a firewall blocking the server."
ssh $phone_ip -p 8022 "echo Success!"
ssh $phone_ip -p 8022 "mkdir ufo"
ssh $phone_ip -p 8022 "touch ufo/identity"
