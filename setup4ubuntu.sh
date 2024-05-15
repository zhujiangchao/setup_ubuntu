# echo "step 1: remove unsed softwares"
sudo apt-get remove libreoffice-common
sudo apt-get remove unity-webapps-common
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get remove onboard deja-dup

# echo "step 2: install curl wget git zsh vim openssh-server guake dconf-tools"
sudo apt install -y curl wget git zsh vim openssh-server tmux guake dconf-tools

# echo "step 3: install powerline fonts and oh-my-zsh"
git clone https://gitee.com/paradis3/powerline-fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
git clone https://gitee.com/victor_htq/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://gitee.com/lightnear/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
rm -rf $HOME/.zshrc
cp ./configs/.zshrc $HOME/


# echo "Step 4: configre git ssh"
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore_global
rm -r $HOME/.ssh

cp configs/git/.gitconfig $HOME/
cp configs/git/.gitignore_global $HOME/
cp -r configs/.ssh $HOME/.ssh

chmod 755 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_ras ~/.ssh/config

# echo "Step 5: change source.list and install ros"
wget http://fishros.com/install -O fishros && . fishros

