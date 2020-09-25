## Setup_18 for Ubuntu 18.04

### Step 1：卸载不常用软件
```bash
sudo apt-get remove libreoffice-common
sudo apt-get remove unity-webapps-common
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get remove onboard deja-dup
```



### Step 2：更换源
```bash
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade
```



### Step 3:：安装基本软件
```bash
sudo apt install -y curl wget git zsh vim openssh-server tmux guake dconf-tools
```



### Step 4： 在/etc/hosts中添加github相关的ip地址

```bash
sudo echo "151.101.76.133 raw.githubusercontent.com\n52.74.223.119 github.com" >> /etc/hosts
```



### Step 5:：配置终端

```bash
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# install oh-my-zsh
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
## or wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# install zsh-autosuggestions zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
```

- 关闭默认终端，使用`guake`终端
- 替换`.zshrc`

```bash
rm -rf $HOME/.zshrc
cp ./configs/.zshrc $HOME/
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

  * 设置 Toggle Guake visibility 快捷键为 F1
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



### Step 6：配置tmux

- 替换`.tmux.conf`

```bash
rm -rf $HOME/.tmux.conf
cp ./configs/.tmux.conf $HOME/
```

- 安装插件

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/bin/install_plugins
```



### Step 7：git ssh 配置文件

```bash
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore_global
rm -r $HOME/.ssh

cp configs/git/.gitconfig $HOME/
cp configs/git/.gitignore_global $HOME/
cp -r configs/.ssh $HOME/.ssh

chmod 755 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_ras ~/.ssh/config

git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
```



### Step 8：install ros (key经常出问题？)

```bash
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update 
sudo apt install -y ros-melodic-desktop
sudo rosdep init
rosdep update
echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
source ~/.zshrc
sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential
```



### Step 9：安装sougou输入法

```bash
sudo apt-get install fcitx
sudo dpkg -i install/sogoupinyin_2.3.1.0112_amd64.deb
```



### Step 10：安装electron-ssr和代理设置
```bash
sudo apt install libcanberra-gtk-module libcanberra-gtk3-module gconf2 gconf-service libappindicator1
sudo apt-get install python
sudo dpkg -i electron-ssr-0.2.6.deb
```

- 现在我的代理设置方式是这样的：系统的网络设置里选择==自动==，浏览器插件`switchomega`选择==系统代理==；终端的代理使用`proxychains`，在需要代理的命令前加上`proxychains4 `
- 可能会用到的网址：`https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt`



### Step 11：安装wechat

- 安装`deepin-wine`

```bash
git clone https://github.com/wszqkzqk/deepin-wine-ubuntu.git
cd deepin-wine-ubuntu
./install.sh
```

- 安装`wechat`

```bash
sudo dpkg -r packages/
```

- 解决中文显示乱码的问题

  #### 下载字体 

  下载地址一：蓝奏云 （推荐）https://www.lanzous.com/i5wivmd
  cp msyh.ttc ~/.deepinwine/Deepin-WeChat/drive_c/windows/Fonts

  #### 修改系统注册表

  gedit ~/.deepinwine/Deepin-WeChat/system.reg
  更改以下两行内容为：
  "MS Shell Dlg"="msyh"
  "MS Shell Dlg 2"="msyh"

  #### 字体注册

  gedit msyh_config.reg
  在文件msyh_config.reg内添加如下内容：

  ```bash
  REGEDIT4
  [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink]
  "Lucida Sans Unicode"="msyh.ttc"
  "Microsoft Sans Serif"="msyh.ttc"
  "MS Sans Serif"="msyh.ttc"
  "Tahoma"="msyh.ttc"
  "Tahoma Bold"="msyhbd.ttc"
  "msyh"="msyh.ttc"
  "Arial"="msyh.ttc"
  "Arial Black"="msyh.ttc"
  ```

  #### 注册

  ```bash
  deepin-wine regedit msyh_config.reg
  ```

  

### Step 12： 安装typora
```bash
tar -xzvf packages/Typora-linux-x64.tar.gz
sudo mv packages/Typora-linux-x64 /opt/
sudo vim /usr/share/applications/Typora.desktop
```

```bash
[Desktop Entry]
Name=Typora
GenericName=Editor
Comment=Typroa - a markdown editor
Exec="/opt/Typora-linux-x64/Typora" %U
Icon=/opt/Typora-linux-x64/resources/app/asserts/icon/icon_256x256.png
Terminal=false
Categories=Markdown;
StartupNotify=false
Type=Application
```



### Step 13： install cuda and cudnn

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