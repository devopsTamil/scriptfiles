echo "-------------------------------------------------------------------------------"
echo "                                                                               "
echo "The installation of atto-5Gc in your machine is Begin, Please hold on and keep your terminal untouched for couple of minutes..."
echo "                                                                               "
echo "-------------------------------------------------------------------------------"

#Initiating the base updates for machine and installing the dependencies.
echo "-------Step 1------"
echo "Initiating the base updates for machine and installing the dependencies..."
apt update -y && apt-get install -y dialog apt-utils wget
echo "Basic packages installation completed."

#Creating a directory and switching pwd.
echo "-------Step 2------"
echo "Creating a directory and switching pwd..."
mkdir /tmp/yubico /attocore && cd /tmp/yubico
echo "Completed creating the directory and switched into it."

#Downloading all the dependency files using wget package and storing them in a directory name yubico.
echo "-------Step 3------"
echo "Downloading all the dependency files using wget package and storing them in a directory name yubico..."
wget https://launchpad.net/~yubico/+archive/ubuntu/stable/+build/12443837/+files/libykpiv1_1.4.3-1~ppa1~yakkety1_amd64.deb
wget https://launchpad.net/~yubico/+archive/ubuntu/stable/+build/12443837/+files/ykcs11_1.4.3-1~ppa1~yakkety1_amd64.deb
wget https://launchpad.net/~ubuntu-security-proposed/+archive/ubuntu/ppa/+build/8393389/+files/libssl1.0.0_1.0.2d-0ubuntu1.2_amd64.deb
echo "Completed downloading the *.deb files required for installation as dependencies."

#Copying all the files that we downloaded to main attocore directory which created and centralized for backup in "/" .
echo "-------Step 4------"
echo "Copying all the files that we downloaded to main attocore directory which xreated and centralized for backup in / ...."
cp . -r /attocore/
echo "Copied all the files for backup and those will be available in /attocore/. - directory."

#Initiating the installation of the dependencies using dpkg package installer.
echo "-------Step 5------"
echo "Initiating the installation of the dependencies using dpkg package installer..."
dpkg -i *.deb
apt --fix-broken install -y
dpkg -i *.deb
echo "Completed installing all the *.deb files."

#Switching to the backup.
echo "-------Step 6------"
echo "Switching to the downloads directory..."
cd /home/$USER/Downloads
echo "Now shell is in downloads directory..."

#Installing unzip for extracting project files.
echo "-------Step 7------"
echo "Installing unzip for extracting project files..."
apt install unzip -y
echo "Unzip installation completed."

#Extracting the files.
echo "-------Step 8------"
echo "Unzip has been initiated for the project file..."
unzip attocore.zip
cp atto-5gc.7.0.31-buster_amd64.deb license.txt /attocore
echo "Completed unzipping the files and copying those to the backup directory that is /attocore/..."

#Copying atto-5gc installer to /tmp directory.
echo "-------Step 9------"
echo "Copying .deb file to a temporary directory..."
cp atto-5gc.7.0.31-buster_amd64.deb /tmp
cd /tmp
echo "Completed copying the file."

#Setting up the execute permissions for installer file.
echo "-------Step 10------"
echo "Setting up the execute permission for the installer file..."
chmod +x atto-5gc.7.0.31-buster_amd64.deb

#Installing the atto-5gc package using .deb file.
echo "-------Step 11------"
echo "Initiating the attocore installation using .deb file..."
dpkg -i atto-5gc.7.0.31-buster_amd64.deb
apt --fix-broken install -y
dpkg -i atto-5gc.7.0.31-buster_amd64.deb
echo "Verifying the ATTO-5GC Version"
atto-5gc --version
echo "Completed installing the attocore-5GC"

#Creating the syslink and starting the atto-5gc-service.
echo "-------Step 12------"
echo "Creating the syslink and starting the atto-5gc-service..."
systemctl enable atto-5gc && systemctl start atto-5gc

#Copying the license file to the required directory.
echo "-------Step 13------"
echo "Copying license file to required directory..."
cp /attocore/license.txt /var/lib/atto-5gc/
echo "Done license file copy."

#After the service restart switching to the root directory.
echo "-------Step 14------"
echo "After copying the license file, restarting the atto-5gc service..."
systemctl restart atto-5gc && cd ~
echo "Done restarting the service."

#Creating the new user with password protected for logging into the Web UI of Atto-5GC.
echo "-------Step 15------"
echo "Creating the new user with password protected for logging into the Web UI of Atto-5GC..."
useradd atto5gctest && echo "atto5gctest:Testpass@123" | chpasswd && usermod -aG sudo atto5gctest
echo "Created the user and provided the sudo privileges with password.."

#Modifying the password for default user ("atto") which is created while installing atto-5gc.
echo "-------Step 16------"
echo "Reconfiguring the password for default atto-user..."
echo "atto:atto" | chpasswd
echo "Done reconfiguring the password for atto-user."

#At last, installing vim (cli editor), net-tools (fetching network interface informations) and mlocate (to locate the details of the file).
echo "-------Step 17------"
echo "At last, installing vim (cli editor), net-tools (fetching network interface informations) and mlocate (to locate the details of the file)..."
apt update && apt install vim net-tools mlocate -y
echo "-------------------------------------------------------------------------------"
echo "                                                                               "
echo "And the installation of atto-5Gc in your machine is completed, you can start using it."
echo "                                                                               "
echo "-------------------------------------------------------------------------------"