# AntRunner 天线旋转器
[English](./README.md)
 * [介绍](#介绍)
 * [特性](#特性)
 * [规格](#规格)
 * [使用教程](#使用教程)
 * [系统原理说明](#系统原理说明)
 * [参考](#参考)

## 介绍
AntRunner是MuseLab设计实现的便携式天线旋转器，支持360度方位角和180度俯仰角的控制，可承重最大5KG的天线，支持平台 Windows/Linux/Mac/RaspberryPi/Android，配合对应的开源上位机可实现卫星的实时自动指向跟踪，支持有线（串口）与无线（ Wifi 2.4G）2种控制方式，支持多种规格的天线（一般为八木天线），安装方便。使用12V电池供电，可利用充电宝+12V快充诱骗线直接供电，整体重量较轻，便于携带，精心设计的多种功能，更方便各位HAM在野外的架台使用。

![AntRunner-1](https://github.com/wuxx/AntRunner/blob/master/doc/1.jpg)
![AntRunner-3](https://github.com/wuxx/AntRunner/blob/master/doc/3.jpg)
![AntRunner-2](https://github.com/wuxx/AntRunner/blob/master/doc/2.jpg)

## 特性
- 方位角和仰角全角度跟踪
- 支持平台 Windows/Linux/RaspberryPi/Android
- 支持有线串口控制
- 支持无线WiFi 2.4G 控制
- 12V电源供电，方便野外架设
- 拆装方便

## 规格
- 旋转限制: AZ: 0 - 360°; EL: 0-180°
- 最大负载: 10KG
- 齿隙: AZ:1° EL:1°
- 重量: 3.5KG
- 尺寸:  120mmØ x 65mm (H)
i
## 使用教程

### Windows

#### 0 天线安装
将天线通过U型抱箍安装至旋转器U型支架上，注意尽量安装至天线的重心处，以使运行更加平稳。

#### 1 旋转器调整
上电之前需要将旋转器的方位角调整到正北方(方位角0度)，俯仰调整为水平(俯仰角0度)，此步骤可通过手机指南针APP配合完成调整。

#### 2 接线上电
使用12V电源将旋转器上电，并通过TYPE-C线连接旋转器和PC，正常连接后设备管理器中会出现一个串口，如图所示
![AntRunner-1](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-1.png)

#### 3 启动Hamlib
进入Hamlib目录，目录中有一批处理脚本，脚本中为一条命令, 如下所示，需要手动编辑一下脚本，修改其中的串口号。由于串口编号为系统分配，不同系统编号有所不同，故需要使用文本编辑器手动更改串口号再运行
```
rotctld.exe -vvvvv -m 2401 -r COMx
```
将COMx修改成设备管理器中出现的实际串口号即可，保存脚本，双击运行即可。
![AntRunner-2](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-2.png)
![AntRunner-3](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-3.png)
![AntRunner-4](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-4.png)

#### 4 启动Gpredict
双击gpredict.exe，即可打开Gpredict程序

![Gpredict-1a](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1a.png)

##### 4.1 经纬度配置
首先需要配置你所在的地区的经纬度，选择 Edit -> General -> Ground Stations -> Add new，在出来的页面中配置好自己当地的经纬度、高度即可。
![Gpredict-1c](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1c.png)

##### 4.2 卫星配置
需要将欲跟踪的卫星添加至列表中，点击右上方的倒三角，选择 Configure, 在出现中的窗口中将欲跟踪卫星添加至右侧小窗口内即可
![Gpredict-1b](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1b.png)


##### 4.3 旋转器配置
新建一个旋转器设备，选择 Edit -> Interfaces -> Rotators -> Add New，并根据如图所示配置
![Gpredict-1d](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1d.png)

##### 4.4 旋转器测试
配置完旋转器之后，即可对旋转器进行初步的测试，点击右上方的倒三角，选择Antennna Control，即可进入旋转器控制页面，
Device选择刚刚新建的grbltrk, 点击Engage初始化旋转器，然后即可配置方位角和俯仰角，配置完旋转器会即时响应，并会实时返回当前的角度值。
![Gpredict-2b](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2b.png)
![Gpredict-2c](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2c.png)
![Gpredict-2d](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2d.png)

##### 4.5 卫星跟踪
在Target中选择需要跟踪的卫星如ISS，点击Track，旋转器即会开始实时跟踪卫星，若卫星未入境，则会调整俯仰角为0度，方位角为卫星入境时的角度，等待卫星入境，左方的雷达图中亦会显示卫星的入境轨迹以及当前的旋转器位置。
![Gpredict-2e](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2e.png)
![Gpredict-3](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-3.png)

### 树莓派
由于Linux下亦支持Gpredict，树莓派中可直接运行使用，操作步骤基本相同，在此不再赘述。
Hamlib启动命令如下
```
rotctld -vvvvv -m 2401 -r /dev/ttyUSB0
```


### Android
#### Look4Sat 
由于Android 不支持Hamlib，需要通过额外硬件系统转换 TODO

## 系统原理说明
本节为技术原理细节描述，不感兴趣的朋友可直接忽略本节说明，直接前往实际操作章节使用。

### 旋转器电机控制原理说明
旋转控制器底层芯片使用ESP32，其上运行的固件为GRBL，这原本是一款开源的CNC控制固件，最早运行于ATmega328P芯片上（一款性能较为低端，主频仅为16MHz的单片机，SRAM容量为2KB，Flash存储容量为32KB），而ESP32则是乐鑫信息科技推出的一颗WiFi芯片。拥有40nm工艺、双核32位MCU、2.4GHz双模Wi-Fi和蓝牙芯片、主频高达240MHz，SRAM容量为520KB，Flash容量最高则可达16MB， 较高的性能，丰富的外设使得其可以支持更多更强的特性功能，故这里使用的是开源社区移植的[GRBL版本](https://github.com/bdring/Grbl_Esp32)。其不仅支持常规的串口控制，而且有一套完善的WEBUI，可通过WEBUI进行手动控制、配置，也可通过telnet 22端口实现网络控制。（当然，也可以构造HTTP请求从WEB 80端口实现控制），由于ESP32支持蓝牙，理论上也可通过蓝牙实现电机的控制，由于WiFi的通信更加具有普适性，通信的速度、稳定性也相对更好一些，且基于TCP/IP的软件协议栈使得通信也更加稳定可靠，故当前无线控制的实现基于WiFi实现。
注1：GRBL系统的控制命令一般称之为gcode，是一种简单的指令系统，例如："G0, X0, Y5" 表明将当前位置移动到坐标[0mm, 5mm]处。

### Gpredict上位机说明
Gpredict (https://github.com/csete/gpredict)为 Alexandru Csete （呼号为
oz9aec）发起并主导的开源的实时卫星跟踪和轨道预报软件，它可以跟踪无限数量的卫星,并以列表,表格,地图,雷达等方式显示他们的位置和其他数据。它还可以通过一个卫星预测未来的时间, 并为您提供详细资料，另外它还可以对接多种常用的电台、SDR设备和多种的天线旋转器，AntRunner的主要使用场景即为和Gpredict配合实现实时的跟踪控制。
由于其是基于GPL的开源项目，当前Gpredict仍然在社区的推动下不断的发展，相信后续会有更多的功能、更方便的特性实现。


### Hamlib中间件说明
Hamlib (https://hamlib.github.io/) 为基于LGPL开源协议的无线电和旋转器的控制库，支持Windows/Linux, 上面提到Gpredict可控制各种规格型号的无线电设备和旋转器，实际上都是通过Hamlib实现控制的，可以理解成Hamlib是Gpredict和实际的硬件的中间一层，Hamlib向Gpredict提供统一的控制接口，其自身则实现复杂的各类硬件设备的操作。在实际运行时，Hamlib为一个单独的任务运行在后台，其过TCP 4533端口接收请求并发送响应，例如：Gpredict通过4533 TCP端口发送“p 30 60”则意为将当前旋转器方位角调整为30度，俯仰角调整为60度，由Hamlib来进行实际的硬件操作，Gpredict并不需要关心使用的什么规格型号的旋转器，只需在Hamlib启动时候指定旋转器的型号即可。
注：AntRunner的驱动即实现在Hamlib中，并已经合入到官方Hamlib仓库 (https://github.com/Hamlib/Hamlib) 取Hamlib的最新版本即可。合入点：https://github.com/Hamlib/Hamlib/pull/1032

### Look4Sat说明 
Look4Sat (https://github.com/rt-bishop/Look4Sat) 为 Arty Bishop实现的基于Android的开源卫星跟踪软件，页面简洁使用，最新的提交也支持了旋转器的控制，其主要特色是在卫星跟踪过程中支持陀螺仪的实时显示，可以方便的对准卫星，目前其他同类卫星预测软件均不支持这种简洁的使用方式，在当前HAM中较为广泛使用。
Look4Sat对于旋转器的控制通过网络发送，例如"\set_pos 30.0 60.0" 表明将当前旋转器方位角调整为30度，俯仰角调整为60度。
由于Android端当前并不支持Hamlib，所以通过Look4Sat控制需要一个额外的硬件设备，这里自己基于ESP32-C3设计了一个小系统，用于将网络请求转换成实际的GRBL命令发送给GRBL固件实现方位和俯仰的控制，其作用相当于自己实现了一个简单的"Hamlib"。


### SDR#
SDR# 是目前流行的SDR控制上位机，使用简单方便，支持多种常见的SDR设备，支持多种插件功能，可以和Gpredict实现联动，同时Gpredict又可支持控制无线设备和旋转器，故可以实现：使用SDR设备例如RTL-SDR，同时用Gpredict跟踪卫星，gpredict可以通过SDR#中的对应插件向SDR#发送多普勒频率进行实时调整，同时Gpredict又可实时的控制旋转器进行跟踪。SDR#中的其他插件则可以对接收到的信号波形进行分析、录制等，实现全系统的联动。

## 参考
