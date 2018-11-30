PHONE_PORT=8022
echo "UPSTREAM=$(dig +short _gateway)" >> .bashrc
# set up chron job
echo "What is the IP address of your phone?"
read phone_ip
UPSTREAM=$phone_ip
echo "Thank you. Your phone's IP has been registered."
echo "This script now try to establish a connection. Please ensure that this phone: "
echo "	- Has an SSH server running on port 8022, preferably the Termux one"
echo "  - Does not have a firewall blocking the server."
ssh $phone_ip -p $PHONE_PORT "echo Success!"
ssh $phone_ip -p $PHONE_PORT "mkdir ufo"
ssh $phone_ip -p $PHONE_PORT "touch ufo/identity"
ssh $phone_up -p $PHONE_PORT "mkdir ufo/backups/"
ssh $phone_up -p $PHONE_PORT "mkdir ufo/terraform/"
ssh $phone_up -p $PHONE_PORT "touch ufo/terraform/apt"
ssh $phone_up -p $PHONE_PORT "touch ufo/terraform/snap"
ssh $phone_up -p $PHONE_PORT "touch ufo/terraform/vim"
