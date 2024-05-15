## Setup for Ubuntu 20.04（先科学上网）
## 1 运行脚本配置
### 1.1 卸载不常用软件
```bash
sudo apt-get -y remove libreoffice-common
sudo apt-get -y remove unity-webapps-common
sudo apt-get -y remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get remove onboard deja-dup
```

### 1.2 安装基本软件
```bash
sudo apt install -y wget git zsh vim openssh-server guake 
``` 

### 1.3 配置zsh

```bash
git clone https://gitee.com/paradis3/powerline-fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# install oh-my-zsh
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"

# install zsh-autosuggestions zsh-syntax-highlighting
git clone https://gitee.com/victor_htq/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://gitee.com/lightnear/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# change zsh config file
rm -rf $HOME/.zshrc
cp ./configs/.zshrc $HOME/
```

### 1.4 配置git与ssh连接

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
```

### 1.5 换系统源、安装ROS、微信 (利用fishros脚本一键安装)

```bash
wget http://fishros.com/install -O fishros && . fishros
```



## 2 图形化配置
### 2.1 修改 guake 终端配置

  #### General

  * 取消 Enable popup notifications on startup
  

  #### Scrollbar
  * 选中 infinite scrolling

  #### Appearance 
  * 取消 Use the system fixed width font
  * 选择 Source Code Pro for Powerline light 14pt
  * 选择 I-Beam Cursor shape
  * 选择 Solaried Dark Higher Contrast built-in schemes

  #### Keyboard Shortcut (与Terminator匹配) 

  * 设置 Toggle Guake visibility 快捷键为 F1
  * 设置 Go to previous tab 快捷键为 Ctrl+Shift+P
  * 设置 Go to next tab 快捷键为 Ctrl+Shift+N

  #### 设置开机启动

  * 在启动应用程序中添加命令 /usr/bin/guake

  #### 默认 shell

  * 如果 Guake 的默认 shell 还是 bash，可以在 Shell 中手动将其修改为 /usr/bin/zsh

* 如果你在重启了终端之后，自动提示的颜色还是过浅，可运行如下命令，之后重新打开终端即可

```bash
mv $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh.bak
cp zsh-autosuggestions.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```


### 2.2 安装sougou输入法
参考链接：[安装指南](https://shurufa.sogou.com/linux/guide)

```bash
sudo apt-get install fcitx
sudo dpkg -i sogoupinyin_2.3.1.0112_amd64.deb
sudo apt-get -f install
sudo apt purge ibus
sudo apt install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
sudo apt install libgsettings-qt1
```


### 2.3 安装clash
从U盘中拷贝clash_for_linux.zip，然后导入url。

### 2.4 配置笔记软件（坚果云+Obsidian+PicGo）

obsidian.desktop
```bash
[Desktop Entry]
Name=Obsidian
Comment=Obsidian
Exec=/home/zuzu/.local/bin/obsidian/Obsidian-1.5.12.AppImage
Icon=/home/zuzu/.local/bin/obsidian/obsidian-icon.png
Terminal=false
Categories=Office;
StartupNotify=false
Type=Application
```
#### PicGo配置
下载PicGo并配置图标
[下载地址](https://github.com/Molunerfinn/PicGo/releases)
picgo.desktop
```bash
[Desktop Entry]
Name=PicGo
Comment=PicGo
Exec=/home/zuzu/.local/bin/PicGo/PicGo-2.4.0-beta.7.AppImage
Icon=/home/zuzu/.local/bin/PicGo/PicGo.png
Terminal=false
Categories=Office;
StartupNotify=false
Type=Application
```
配置Github图床
```bash
"github": {
  "repo": "zhujiangchao/PictureBed",
  "token": "xxx",
  "path": "img/",
  "customUrl": "",
  "branch": "master"
},
```


### 2.5 安装typora

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
Exec="/opt/Typora/Typora" %U
Icon=/opt/Typora/resources/app/asserts/icon/icon_256x256.png
Terminal=false
Categories=Markdown;
StartupNotify=false
Type=Application
```



### 2.6 install cuda and cudnn, follow the steps listed in the following link
https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork

### 2.7 install sublime-text


