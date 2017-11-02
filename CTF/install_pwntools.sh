apt-get update
apt-get install -y python-pip || exit
pip install pwntools
pip install --upgrade capstone

apt-get install -y ipython python-tk

apt-get install -y nmap

git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

apt-get install -y gcc-multilib