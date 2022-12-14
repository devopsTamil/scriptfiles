echo "-------------------------------------------------------------------------------"
echo "                                                                               "
echo "The installation of UERANSIM in your machine is Begin,"
echo "Please hold on and keep your terminal untouched for couple of minutes..."
echo "                                                                               "
echo "-------------------------------------------------------------------------------"

#Installing the basic required packages.
echo "-------Step 1------"
echo "Installing and updating basic packages..."
apt update -y && apt install git wget curl net-tools -y
echo "Done installing and updating basic packages."

#Creating the backup folder.
echo "-------Step 2------"
echo "Creating the backup directory in / ..."
mkdir /ueransim-backup
echo "Done creating the directory."

#Cloning UERAN-Simulator from github repository.
echo "-------Step 3------"
echo "Cloning UERAN-Simulator from github repository..."
cd /root
git clone https://github.com/aligungr/UERANSIM
echo "Done Cloning the repository and the destination is /root/UERANSIM"

#Upgrading the tools and packages.
echo "-------Step 4------"
echo "Upgrading the tools and packages..."
apt update -y && apt upgrade -y
echo "Done updating and upgrading the machine"

#Installing dependency packages.
echo "-------Step 5------"
echo "Installing dependency packages..."
apt install make gcc g++ libsctp-dev lksctp-tools iproute2 -y
apt --fix-broken install -y
echo "Done installing dependency packages."
snap install cmake --classic

#Initiating the Compilation of the packages.
echo "-------Step 6------"
echo "Initiating the Compilation of the packages."
cd ~/UERANSIM
make
echo "Done Compilation of the packages."

#Making the backup copy of UERANSIM to /ueransim-bakup directory.
echo "Making the backup copy of UERANSIM to /ueransim-bakup directory..."
cp -R /root/UERANSIM /ueransim-backup
echo "Done backup of RAN Simulator files."
echo "-------------------------------------------------------------------------------"
echo "                                                                               "
echo "And the installation of UERAN-Simulator in your machine is completed,"
echo "You can start using it...."
echo "                                                                               "
echo "-------------------------------------------------------------------------------"