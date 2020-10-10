# echo "remove unsed softwares"
sudo apt-get remove libreoffice-common
sudo apt-get remove unity-webapps-common
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get remove onboard deja-dup

# echo "change apt source"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y

# echo "install curl wget git zsh vim openssh-server guake dconf-tools"
sudo apt install -y curl wget git zsh vim openssh-server tmux guake dconf-tools

# echo "add ip addr related to github into /ect/hosts to speed up git clone"
sudo echo "151.101.76.133 raw.githubusercontent.com" >> /etc/hosts

# echo "install powerline fonts and oh-my-zsh"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
rm -rf $HOME/.zshrc
cp ./configs/.zshrc $HOME/

# echo "install ros"
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update 
sudo apt install -y ros-melodic-desktop
echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
source ~/.zshrc
sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential
sudo rosdep init
rosdep update

# echo "configure tmux"
rm -rf $HOME/.tmux.conf
cp ./configs/.tmux.conf $HOME/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/bin/install_plugins

# echo "configre git ssh"
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore_global
rm -r $HOME/.ssh

cp configs/git/.gitconfig $HOME/
cp configs/git/.gitignore_global $HOME/
cp -r configs/.ssh $HOME/.ssh

chmod 755 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_ras ~/.ssh/config

# git config --global http.proxy 'socks5://127.0.0.1:1080'
# git config --global https.proxy 'socks5://127.0.0.1:1080'
