# AntRunner
[中文](./README_cn.md)
 * [Introduce](#introduce)
 * [Feature](#feature)
 * [Specification](#specification)
 * [How to Use](#how-to-use)
 * [System Detail](#system-detail)
    * [Gpredict](#gpredict)
    * [Hamlib](#hamlib)
    * [Look4Sat](#look4sat)
    * [SDR#](#sdr)
 * [How to Get One](#how-to-get-one)
 * [Rerfeence](#reference)

## Introduce
AntRunner is a portable antenna rotator designed and made by Muse Lab. It can be used for real-time automatic racking of satellites with corresponding open source software which is available on Windows/Linux/Mac/RaspberryPi/Android. The rotator and the host computer can communicate via wired (serial port) or wireless (Wifi 2.4G).  It can install various types of antennas (usually Yagi antennas), support 360-degree azimuth and 180-degree elevation control, and can support antennas up to 5KG.  It can be powered by a 12V battery or by a fast charging power bank with a 12V fast charging trigger cable. It’s easy to carry as its weight is relatively light and very convenient to use in the wild for HAM.

![AntRunner-1](https://github.com/wuxx/AntRunner/blob/master/doc/1.jpg)
![AntRunner-2](https://github.com/wuxx/AntRunner/blob/master/doc/3.jpg)
![AntRunner-3](https://github.com/wuxx/AntRunner/blob/master/doc/2.jpg)

## Feature
- full Azimuth and elevation angle tracking
- Support Windows/Linux/RaspberryPi/Android
- Support wired serial port control
- Support wireless WiFi 2.4G control
- 12V power supply, convenient for field erection
- Easy disassembly and assembly

## Specification
- Rotation Limit: AZ: 0 - 360°; EL: 0-180°
- Max Load: 10KG
- Backlash: AZ:1° EL:1°
- Weight: 2.5KG
- Rotator Diameter x Height:  120mmØ x 65mm (H)
- Support Material: 5mm/10mm Acrylic

## How to Use

### Windows

#### 0 Antenna installation
Install the antenna on the U-shaped bracket of the rotator through the U-shaped hoop, and pay attention to install it at the center of gravity of the antenna to make the operation more stable.

#### 1 Rotator adjustment
Before powering on, you need to adjust the azimuth of the rotator to true north (azimuth angle of 0 degrees), and the pitch to be horizontal (pitch angle of 0 degrees). This step can be adjusted through the mobile compass APP.

#### 2 Power up
Use the 12V power supply to power on the rotator, and connect the rotator and PC through the TYPE-C cable. After the normal connection, a serial port will appear in the device manager, as shown in the figure.
![AntRunner-1](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-1.png)

#### 3 Start Hamlib
Enter the Hamlib directory, there is a batch script in the directory, and the script is a command, as shown below, you need to manually edit the script to modify the serial port number. Since the serial port number is assigned by the system, the serial number is different for different systems, so you need to use a text editor to manually change the serial port number before running.
```
rotctld.exe -vvvvv -m 2401 -r COMx
```
Modify COMx to the actual serial port number that appears in the device manager, save the script, and double-click to run it.
![AntRunner-2](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-2.png)
![AntRunner-3](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-3.png)
![AntRunner-4](https://github.com/wuxx/AntRunner/blob/master/doc/AntRunner_Start-4.png)

#### 4 Start Gpredict
Double-click gpredict.exe to open the Gpredict program

![Gpredict-1a](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1a.png)

##### 4.1 Longitude and latitude configuration
First, you need to configure the latitude and longitude of your region, select Edit -> General -> Ground Stations -> Add new, and configure your local latitude, longitude and altitude on the page that comes out.
![Gpredict-1c](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1c.png)

##### 4.2 Satellite configuration
You need to add the satellites you want to track to the list, click the inverted triangle on the upper right, select Configure, and add the satellites you want to track to the small window on the right in the window that appears.
![Gpredict-1b](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1b.png)


##### 4.3 Rotator configuration
Create a new rotator device, select Edit -> Interfaces -> Rotators -> Add New, and configure it as shown
![Gpredict-1d](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-1d.png)

##### 4.4 Rotator test
After configuring the rotator device, you can perform a preliminary test on the rotator. Click the inverted triangle on the upper right and select Antenna Control to enter the antenna control page.
select the newly created grbltrk, click Engage to initialize the rotator, and then configure the azimuth and pitch angles. After configuring the rotator, it will respond immediately and return the current angle value in real time.
![Gpredict-2b](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2b.png)
![Gpredict-2c](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2c.png)
![Gpredict-2d](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2d.png)

##### 4.5 satellite tracking
Select the satellite to be tracked in Target, such as ISS, click Track, the rotator will start tracking the satellite in real time, if the satellite is not in entry, it will adjust the pitch angle to 0 degrees, and the azimuth angle to the angle when the satellite enters, wait for the satellite to enter, The radar map on the left also shows the satellite's inbound trajectory and the current rotator position.
![Gpredict-2e](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-2e.png)
![Gpredict-3](https://github.com/wuxx/AntRunner/blob/master/doc/Gpredict-3.png)

### Raspberry
Since Gpredict is also supported under Linux, it can be directly run and used in the Raspberry Pi. The operation steps are basically the same, and will not be repeated here.
here is how to start the Hamlib
```
rotctld -vvvvv -m 2401 -r /dev/ttyUSB0
```


### Android
#### Look4Sat 
TODO

## System Detail
This section is a detailed description of the technical principle. Those who are not interested can ignore the description in this section and go directly to the actual operation chapter.

### Rotator Motor Control 
The bottom chip of the rotary controller uses ESP32, and the firmware running on it is GRBL, which was originally an open source CNC control firmware, and was first run on the ATmega328P chip (a low-end single-chip microcomputer with a main frequency of only 16MHz, SRAM The capacity is 2KB, and the Flash storage capacity is 32KB), while ESP32 is a WiFi chip launched by Espressif Information Technology. With 40nm process, dual-core 32-bit MCU, 2.4GHz dual-mode Wi-Fi and Bluetooth chip, the main frequency is up to 240MHz, the SRAM capacity is 520KB, and the Flash capacity is up to 16MB. It supports more and stronger features, so the [GRBL version] transplanted by the open source community is used here (https://github.com/bdring/Grbl_Esp32). It not only supports conventional serial port control, but also has a complete set of WEBUI, which can be manually controlled and configured through the WEBUI, and can also be controlled through the telnet 22 port. (Of course, an HTTP request can also be constructed to realize control from the WEB 80 port), since ESP32 supports Bluetooth, the motor control can also be achieved theoretically through Bluetooth. Since WiFi communication is more universal, the speed and stability of communication are also relatively high. Better, and the software protocol stack based on TCP/IP makes communication more stable and reliable, so the current implementation of wireless control is based on WiFi.
Note 1: The control command of the GRBL system is generally called gcode, which is a simple command system. For example: "G0, X0, Y5" means to move the current position to the coordinates [0mm, 5mm].

### Gpredict 
Gpredict (https://github.com/csete/gpredict) is lead by Alexandru Csete (call sign oz9aec) is an open source real-time satellite tracking and orbit forecasting software that can track an unlimited number of satellites and display their positions and other data in lists, tables, maps, radars, etc. It can also predict the future time through a satellite and provide you with detailed information. In addition, it can connect to a variety of commonly used radio stations, SDR equipment and a variety of antenna rotators. The main use scenario of AntRunner is to cooperate with Gpredict. Real-time tracking control.
Since it is an open source project based on GPL, Gpredict is still developing under the impetus of the community, and it is believed that more functions and more convenient features will be implemented in the future.

### Hamlib 
Hamlib (https://hamlib.github.io/) is a control library for radios and rotators based on the LGPL open source protocol, supporting Windows/Linux. Gpredict mentioned above can control various types of radio equipment and rotators. The above are all controlled by Hamlib. It can be understood that Hamlib is the middle layer between Gpredict and the actual hardware. Hamlib provides a unified control interface to Gpredict, and itself realizes the operation of complex hardware devices. In actual operation, Hamlib runs in the background as a separate task, which receives requests and sends responses through TCP port 4533. For example: Gpredict sends "p 30 60" through TCP port 4533, which means to adjust the current rotator azimuth to 30 degrees, the pitch angle is adjusted to 60 degrees, and the actual hardware operation is performed by Hamlib. Gpredict does not need to care what type of rotator is used, just specify the model of the rotator when Hamlib starts.
Note: AntRunner's driver is implemented in Hamlib, and has been incorporated into the official Hamlib repository (https://github.com/Hamlib/Hamlib). Just take the latest version of Hamlib. merge node: https://github.com/Hamlib/Hamlib/pull/1032

### Look4Sat
Look4Sat (https://github.com/rt-bishop/Look4Sat) is an Android-based open source satellite tracking software implemented by Arty Bishop. The page is concise and easy to use. The latest submission also supports the control of the rotator. The real-time display of the gyroscope is supported during the tracking process, which can easily align the satellite. At present, other similar satellite prediction software does not support this simple use method, and it is widely used in the current HAM.
Look4Sat's control of the spinner is sent over the network, for example "\set_pos 30.0 60.0" means to adjust the current spinner azimuth to 30 degrees and pitch to 60 degrees.
Since Hamlib is not currently supported on the Android side, an additional hardware device is required to control through Look4Sat. Here, I designed a small system based on ESP32-C3 to convert network requests into actual GRBL commands and send them to the GRBL firmware to achieve orientation and The control of pitch is equivalent to implementing a simple "Hamlib" by itself.

### SDR#
SDR# is a popular SDR control application. It is simple and convenient to use. It supports a variety of common SDR devices, supports a variety of plug-in functions, and can be linked with Gpredict. At the same time, Gpredict can also support wireless devices and rotators. : Use SDR equipment such as RTL-SDR, and use Gpredict to track satellites at the same time, gpredict can send Doppler frequency to SDR# through the corresponding plug-in in SDR# for real-time adjustment, and Gpredict can control the rotator in real time for tracking. Other plug-ins in SDR# can analyze and record the received signal waveform to realize the linkage of the whole system.

### How to Get One
Some guys ask me if they could buy AntRunner rotator, so I plan to make some AntRunner prototypes. Interested friends can place an order in my tindie store: https://www.tindie.com/products/johnnywu/the-antrunner-rotator/

## Reference
- Gpredict (https://github.com/csete/gpredict) 
- Hamlib (https://hamlib.github.io/)
- Look4Sat (https://github.com/rt-bishop/Look4Sat)
- sdr# (https://airspy.com/download/)
