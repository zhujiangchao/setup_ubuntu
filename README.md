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

### 1.5 换系统源和安装ROS (利用fishros脚本一键安装)

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



### 2.4 安装wechat

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

- 解决中文显示乱码的问题:

  方法一：

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

​		方法二：

```bash
sudo subl /opt/deepinwine/tools/run_v2.sh
```

找到WINE_CMD
修改为：

```
WINE_CMD="LC_ALL=zh_CN.UTF-8 deepin-wine"
```

- 解决无法上传图片的问题

  ```c++
  sudo apt install libjpeg62:i386
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


