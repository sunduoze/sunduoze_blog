---
categories:
- 笔记
date: 2020-11-08T18:10:03+08:00

keywords:
- 嵌入式
title: "Python_instrument_lib_build"
url: ""
---
<br/>
<br/>


#### 1. instrument library build

1. serial has been verify
2. ethernet socket server & cilent need verify more

```

# utf-8
import os
import socket
import time
import threading

import serial
import serial.tools.list_ports


"""Function to looks for connected USB instruments"""


def list_instruments():
    # This isn't implemented yet.
    inst_list = []
    return inst_list

# 处理客户端，sock为socket，addr为客户端地址
def tcp_server(sock, addr):
    print("Accept new connection from %s:%s" % addr)
    sock.send(b"What's your name?")
    while True:
        data = sock.recv(1024)
        time.sleep(0.001)
        if not data or data.decode("utf-8") == "disconnect":
            break
        sock.send(('Hello, %s!' % data.decode('utf-8')).encode('utf-8'))
    sock.close()
    print('Connection from %s:%s closed.' % addr)

class client_dev:
    def __init__(self, location):
        self.device = location
        self.port = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.port.connect((location[0], location[1]))  # ("127.0.0.1", 3288)
    def write(self, command):
        self.port.send(command)

    def read(self):
        return self.port.recv(1024).decode('utf-8')

class server_dev:
    def __init__(self, location):
        self.device = location
        self.port = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.port.bind((location[0], location[1]))  ##  ("127.0.0.1", 3288))
        self.port.listen(10)  # 设置最大连接数，并开始监听
        while True:
            # 接收TCP客户端连接，阻塞等待连接
            sock_fd, addr = self.port.accept()
            # 开启新线程对TCP连接进行处理
            thread_server = threading.Thread(target=tcp_server, args=(sock_fd, addr))
            thread_server.start()
    def write(self, command):
        self.port.send(command)

    def read(self):
        return self.port.recv(1024).decode('utf-8')

    def close(self):
        # 发送断开连接的指令
        self.port.send(b'disconnect')
        # 套接字关闭
        self.port.close()

class serial_dev:
    def __init__(self, location):
        self.device = location
        self.port = serial.Serial(location, 115200)

    def write(self, command):
        self.port.write(command)

    def read(self):
        return self.port.readline()


class usb_dev:
    """Initializes a connection to the device port [presumably usb]"""

    def __init__(self, location):
        self.device = location
        self.connect = os.open(location, os.O_RDWR)

    def write(self, command):
        os.write(self.connect, command);

    def read(self, length=4000):
        return os.read(self.connect, length)

    def getID(self):
        self.write("*IDN?")
        return self.read(100)


class instrument:
    """Initialize instrument given a port, e.g. /dev/usbtmc0/"""

    def __init__(self, location, conType):
        if conType.lower() == 'serial':
            self.port = serial_dev(location)

        if conType.lower() == 'usb':
            self.port = usb_dev(location)
            self.id = self.port.getID()
            print(self.id)
        else:
            print("Device type not recognized")

    def write(self, command):
        self.port.write(command)

    def read(self, command):
        return self.port.read(command)

```

#### 2. main

1. File -> New Project -> Pure Python -> Create ....
2. File -> Settings  --> Project: xxx ->Project Interpreter <br/>
3. project interpreter: python 3.6 (3.6.6) <br/>
click '+'' -> click Manage Repositories click '+' 镜像源 

以下选择一个即可：
```
# utf-8

import instrument_driver

try:

    com = 'COM1'
    mcu = instrument_driver.serial_dev(com)
    read_info = mcu.read()
    print("rd:" + str(read_info))
    mcu.write(read_info)

    eth_port = ["127.0.0.3", 3288]
    server = instrument_driver.server_dev(eth_port)
    # read_info = server.read()
    # print("rd:" + str(read_info))
    # server.write("server wt test\r\n")



except Exception as e:
    print("error" , e)


```


<br/>
<br/>
<br/>
<br/>
<br/>