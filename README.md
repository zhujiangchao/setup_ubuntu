## Setup

### Step 1:卸载不常用软件
sudo apt-get remove libreoffice-common
sudo apt-get remove unity-webapps-common
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get remove onboard deja-dup

### Step 2: 更换源
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade

### Step 3: 安装基本软件
sudo apt install -y curl wget git zsh vim openssh-server tmux guake dconf-tools

### Step 4: 在/etc/hosts中添加github相关的ip地址
sudo echo "151.101.76.133 raw.githubusercontent.com\n52.74.223.119 github.com" >> /etc/hosts

### Step 5: install powerline fonts and oh-my-zsh
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

```bash
# install zsh-autosuggestions zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

* 关闭默认终端，使用 guake 终端

* 在 .zshrc 文件中将 ZSH_THEME=“robbyrussell” 改为

  ```bash
  ZSH_THEME="agnoster"
  ```

* 在 .zshrc 文件中将 plugins=(git) 改为如下

  ```bash
  plugins=(
    git
    zsh-autosuggestions
  )
  ```

* 打开 dconf-tools 的 org > gnome > desktop > terminal 选择 guake 为默认终端

  > 可能不存在这个路径，便不再配置

* 修改 guake 终端配置如下：

  #### General ####

  * 取消 Enable popup notifications on startup

  #### Main Window ####

  * 取消 show tab bar

  #### Scrollbar ####

  * 选中 infinite scrolling

  #### Appearance ####

  * 取消 Use the system fixed width font
  * 选择 Source Code Pro for Powerline light 14pt
  * 选择 I-Beam Cursor shape
  * 选择 Solaried Dark Higher Contrast built-in schemes

  #### Keyboard Shortcut ####

  * 设置 Toggle Guake visibility 快捷键为 Ctrl+Shift+Space
  * 设置 Go to previous tab 快捷键为 Ctrl+Shift+P
  * 设置 Go to next tab 快捷键为 Ctrl+Shift+N

  #### 设置开机启动 ####

  * 在启动应用程序中添加命令 /usr/bin/guake

  #### 默认 shell ####

  * 如果 Guake 的默认 shell 还是 bash，可以在 Shell 中手动将其修改为 /usr/bin/zsh

* 如果你在重启了终端之后，自动提示的颜色还是过浅，可运行如下命令，之后重新打开终端即可

```bash
mv $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh.bak
cp zsh-autosuggestions.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```

### Step 6: 安装sougou输入法
sudo apt-get install fcitx
sudo dpkg -i sogoupinyin_2.3.1.0112_amd64.deb

### Step 7: 安装electron-ssr
sudo apt install libcanberra-gtk-module libcanberra-gtk3-module gconf2 gconf-service libappindicator1
sudo apt-get install python
sudo dpkg -i electron-ssr-0.2.6.deb

# https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt

### Step 8: config files
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore_global
rm -r $HOME/.ssh

mv Config-File/git/.gitconfig $HOME/
mv Config-File/git/.gitignore_global $HOME/

cp -r Config-File/.ssh $HOME/.ssh
chmod 755 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_ras ~/.ssh/config

git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

### Step 8: install cuda and cudnn



### Step 9: install ros

cuda10.2
https://developer.nvidia.com/cuda-10.2-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=deblocal


wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda

https://blog.csdn.net/u013084111/article/details/104167056
https://blog.csdn.net/qq_32408773/article/details/84112166


之后可运行

```bash
./setup_ros.sh
```

脚本安装 ros，同样有一次提示询问是否要更新一次软件，可自行选择

Ubuntu 虚拟机可以使用宿主机的代理设置只需要

* 在 .zshrc 文件中添加下面两行中的一行，推荐使用 http

  ```bash
  export all_proxy=http://<宿主机 IP>:<宿主机 http 代理监听端口>
  export all_proxy=socks5://<宿主机 IP>:<宿主机 socks5 代理监听端口>
  ```

* 在系统设置中添加手动代理 http、https、sock 主机均填宿主机 IP，http 与 https 端口填 http 监听端口，sock 主机填 socks5 监听端口



