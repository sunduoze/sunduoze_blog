---
categories:
- 笔记
date: 2020-11-08T15:32:43+08:00
keywords:
- 嵌入式
title: "Python_start"
url: ""
---
<br/>
<br/>


#### 1. IDE Pycharm

install Pycharm (1.安装包 2.补丁jar 3.增加补丁路径 4.离线后输入激活码) <br/>
install Python python-3.6.6-amd64.exe (记得勾选添加环境变量) <br/>

```
PyCharm 2019.3.1 (Professional Edition)
Build #PY-193.5662.61, built on December 18, 2019
Licensed to pig6
Subscription is active until July 8, 2089
Runtime version: 11.0.5+10-b520.17 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o
Windows 10 10.0
GC: ParNew, ConcurrentMarkSweep
Memory: 958M
Cores: 8
Registry: 
Non-Bundled Plugins: 
```

将补丁文件jetbrains-agent.jar放置到D:\Program Files\JetBrains\PyCharm 2019.3.1\bin <br/>
然后打开pycharm安装路径下bin文件夹中 pycharm64.exe vmoptions文件，在最后一行添加你的补丁路径，<br/>
```
-javaagent:D:\Program Files\JetBrains\PyCharm 2019.3.1\bin\jetbrains-agent.jar
```


激活码
```
520E5894E2-eyJsaWNlbnNlSWQiOiI1MjBFNTg5NEUyIiwibGljZW5zZWVOYW1lIjoicGlnNiIsImFzc2lnbmVlTmFtZSI6IiIsImFzc2lnbmVlRW1haWwiOiIiLCJsaWNlbnNlUmVzdHJpY3Rpb24iOiJVbmxpbWl0ZWQgbGljZW5zZSB0aWxsIGVuZCBvZiB0aGUgY2VudHVyeS4iLCJjaGVja0NvbmN1cnJlbnRVc2UiOmZhbHNlLCJwcm9kdWN0cyI6W3siY29kZSI6IklJIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiUlMwIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiV1MiLCJwYWlkVXBUbyI6IjIwODktMDctMDcifSx7ImNvZGUiOiJSRCIsInBhaWRVcFRvIjoiMjA4OS0wNy0wNyJ9LHsiY29kZSI6IlJDIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiREMiLCJwYWlkVXBUbyI6IjIwODktMDctMDcifSx7ImNvZGUiOiJEQiIsInBhaWRVcFRvIjoiMjA4OS0wNy0wNyJ9LHsiY29kZSI6IlJNIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiRE0iLCJwYWlkVXBUbyI6IjIwODktMDctMDcifSx7ImNvZGUiOiJBQyIsInBhaWRVcFRvIjoiMjA4OS0wNy0wNyJ9LHsiY29kZSI6IkRQTiIsInBhaWRVcFRvIjoiMjA4OS0wNy0wNyJ9LHsiY29kZSI6IkdPIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiUFMiLCJwYWlkVXBUbyI6IjIwODktMDctMDcifSx7ImNvZGUiOiJDTCIsInBhaWRVcFRvIjoiMjA4OS0wNy0wNyJ9LHsiY29kZSI6IlBDIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In0seyJjb2RlIjoiUlNVIiwicGFpZFVwVG8iOiIyMDg5LTA3LTA3In1dLCJoYXNoIjoiODkwNzA3MC8wIiwiZ3JhY2VQZXJpb2REYXlzIjowLCJhdXRvUHJvbG9uZ2F0ZWQiOmZhbHNlLCJpc0F1dG9Qcm9sb25nYXRlZCI6ZmFsc2V9-DZ/oNHBfyho0XrrCJJvAOKg5Q1tLBgOdbCmzCKwkuM+Yryce0RoOi3OOmH6Ba/uTcCh/L37meyD0FJdJIprv59y4+n+k2kIeF/XKrKqg0dEsDUQRw0lUqqMt99ohqa+zmbJ44Yufdwwx/F1CtoRGvEQ2Mn0QjuqRoZJZ3wiT5Am22JiJW8MaNUl3wg9YPj+OPGARKKJUdUJ0NGUDQBcBAv5ds8LhbSbJSbPkbkwH/a1QMz4nEdn6lRDKI1aFIn43QhBSCFqvUq6TPJlbIJ0ZjE+PyZjHFBKCgkry0DHPXU2BbtIZPsksQnN3fx240a9K6sN7peZnLpEoMoq23FEz4g==-MIIElTCCAn2gAwIBAgIBCTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBMB4XDTE4MTEwMTEyMjk0NloXDTIwMTEwMjEyMjk0NlowaDELMAkGA1UEBhMCQ1oxDjAMBgNVBAgMBU51c2xlMQ8wDQYDVQQHDAZQcmFndWUxGTAXBgNVBAoMEEpldEJyYWlucyBzLnIuby4xHTAbBgNVBAMMFHByb2QzeS1mcm9tLTIwMTgxMTAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5ndaik1GD0nyTdqkZgURQZGW+RGxCdBITPXIwpjhhaD0SXGa4XSZBEBoiPdY6XV6pOfUJeyfi9dXsY4MmT0D+sKoST3rSw96xaf9FXPvOjn4prMTdj3Ji3CyQrGWeQU2nzYqFrp1QYNLAbaViHRKuJrYHI6GCvqCbJe0LQ8qqUiVMA9wG/PQwScpNmTF9Kp2Iej+Z5OUxF33zzm+vg/nYV31HLF7fJUAplI/1nM+ZG8K+AXWgYKChtknl3sW9PCQa3a3imPL9GVToUNxc0wcuTil8mqveWcSQCHYxsIaUajWLpFzoO2AhK4mfYBSStAqEjoXRTuj17mo8Q6M2SHOcwIDAQABo4GZMIGWMAkGA1UdEwQCMAAwHQYDVR0OBBYEFGEpG9oZGcfLMGNBkY7SgHiMGgTcMEgGA1UdIwRBMD+AFKOetkhnQhI2Qb1t4Lm0oFKLl/GzoRykGjAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBggkA0myxg7KDeeEwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMA0GCSqGSIb3DQEBCwUAA4ICAQBonMu8oa3vmNAa4RQP8gPGlX3SQaA3WCRUAj6Zrlk8AesKV1YSkh5D2l+yUk6njysgzfr1bIR5xF8eup5xXc4/G7NtVYRSMvrd6rfQcHOyK5UFJLm+8utmyMIDrZOzLQuTsT8NxFpbCVCfV5wNRu4rChrCuArYVGaKbmp9ymkw1PU6+HoO5i2wU3ikTmRv8IRjrlSStyNzXpnPTwt7bja19ousk56r40SmlmC04GdDHErr0ei2UbjUua5kw71Qn9g02tL9fERI2sSRjQrvPbn9INwRWl5+k05mlKekbtbu2ev2woJFZK4WEXAd/GaAdeZZdumv8T2idDFL7cAirJwcrbfpawPeXr52oKTPnXfi0l5+g9Gnt/wfiXCrPElX6ycTR6iL3GC2VR4jTz6YatT4Ntz59/THOT7NJQhr6AyLkhhJCdkzE2cob/KouVp4ivV7Q3Fc6HX7eepHAAF/DpxwgOrg9smX6coXLgfp0b1RU2u/tUNID04rpNxTMueTtrT8WSskqvaJd3RH8r7cnRj6Y2hltkja82HlpDURDxDTRvv+krbwMr26SB/40BjpMUrDRCeKuiBahC0DCoU/4+ze1l94wVUhdkCfL0GpJrMSCDEK+XEurU18Hb7WT+ThXbkdl6VpFdHsRvqAnhR2g4b+Qzgidmuky5NUZVfEaZqV/g==

```

#### 2. 新项目开始 

1. File -> New Project -> Pure Python -> Create ....
2. File -> Settings  --> Project: xxx ->Project Interpreter <br/>
3. project interpreter: python 3.6 (3.6.6) <br/>
click '+'' -> click Manage Repositories click '+' 镜像源 

以下选择一个即可：
```
初始：
https://pypi.python.org/simple 
国内：
清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
阿里云 http://mirrors.aliyun.com/pypi/simple/
豆瓣(douban) http://pypi.douban.com/simple/
```
然后 click '刷新按钮'
然后 。。。。 搜索“pyserial” 然后click Install Package

坑：不知为何国内的源没法安装成功

#### 3. 串口基本操作

pyserial库常用函数：

```
serial = serial.Serial('COM1', 115200)   #打开COM1并设置波特率为115200，COM1只适用于Windows
serial = serial.Serial('/dev/ttyS0', 115200)  #打开/dev/ttyS0并设置波特率为115200, 只适用于Linux
print(serial.portstr)   #能看到第一个串口的标识
serial.write("hello")   #往串口里面写数据
serial .close()    #关闭serial 表示的串口

serial .open()    #打开串口
data = serial .read(num)   # 读num个字符
data = serial .readline()    #读一行数据，以/n结束，要是没有/n就一直读，阻塞。
serial .baudrate = 9600   # 设置波特率
print serial    #可查看当前串口的状态信息
serial.isOpen()    #当前串口是否已经打开
serial.inWaiting()    #判断当前接收的数据
serial.flushInput()   # 清除输入缓冲区数据
serial.flushOutput()    #中止当前输出并清除输出缓冲区数据
```

```
# utf-8
import serial
import serial.tools.list_ports

port_list = list(serial.tools.list_ports.comports())
print(port_list)

if len(port_list) == 0:
    print("无可用串口！")
else:
    for i in range(0, len(port_list)):
        print(port_list[i])
try:
    portx = "COM1"  # 端口：CNU； Linux上的/dev /ttyUSB0等； windows上的COM3等
    bps = 115200
    # 超时设置，None：永远等待操作；
    #         0：立即返回请求结果；
    #        其他：等待超时时间（单位为秒）
    timex = 5

    ser = serial.Serial(portx, bps, timeout=timex)  # 打开串口，并得到串口对象
    print("串口详情参数：", ser)
    result = ser.write("hello world !\r\n".encode("gbk"))  # 写数据
    print("写总字节数：", result)
    # # 十六进制的发送
    # result = ser.write(chr(0x06).encode("utf-8")) # 写数据
    # print("写总字节数：", result)
    #
    # 十六进制的读取
    # print(ser.read().hex()+"\r\n")  # 读一个字节
    ser.close()  # 关闭串口

except Exception as e:
    print("error!", e)


# BIF build in funciton 内置函数
# 逐渐割掉瑕疵，才能产生卓越体验
# print("test\r\n" * 8)
temp = input("Please input a number:\r\n")
guess = int(temp)

if guess == 8:
    test_str = r'fish cccc\n'
    print(test_str)
    test_str = 'fish cccc\n'
    print(test_str)
    print("input right\n")
else:
    print("input error\n")
print("game over\n")


```

#### 串口 echo

```
import threading
import serial
import serial.tools.list_ports

DATA = ""  # 读取的数据
NOEND = True  # 是否读取结束


# 读数据的本体
def read_data(ser):
    global DATA, NOEND

    # 循环接收数据（此为死循环，可用线程实现）
    while NOEND:
        if ser.in_waiting:
            DATA = ser.read(ser.in_waiting).decode("gbk")
            print("\n>> receive: ", DATA, "\n>>", end="")
            # print(">>", end="")
            if (DATA == "quit" or DATA == "quit\n"):
                print("oppo seri has closen.\n>>", end="")

# 列出串口清单
def list_seri():
    ret = False
    try:

        port_list = list(serial.tools.list_ports.comports())
        print(port_list)

        if len(port_list) == 0:
            test_str = r'无可用串口！\n'
            print(test_str)
            test_str = '无可用串口！\n'
            print(test_str)
            ret = False
        else:
            ret = True
            for i in range(0, len(port_list)):
                print(port_list[i])

    except Exception as e:
        print("error!", e)
    return ret

# 打开串口
def open_seri(portx, bps, timeout):
    ret = False
    try:
        # 打开串口，并得到串口对象
        ser = serial.Serial(portx, bps, timeout=timeout)

        # 判断是否成功打开
        if (ser.is_open):
            ret = True
            th = threading.Thread(target=read_data, args=(ser,))  # 创建一个子线程去等待读数据
            th.start()
    except Exception as e:
        print("error!", e)

    return ser, ret


# 关闭串口
def close_seri(ser):
    global NOEND
    NOEND = False
    ser.close()


# 写数据
def write_to_seri(ser, text):
    res = ser.write(text.encode("gbk"))  # 写
    return res


# 读数据
def read_from_seri():
    global DATA
    data = DATA
    DATA = ""  # 清空当次读取
    return data

# import serial.tools.list_ports

if __name__ == "__main__":
    # 列出串口清单
    ret = list_seri()
    # 打开一个串口
    port = input("输入串口名：")
    ser, ret = open_seri(port, 115200, None)  # 串口com3、bps为115200，等待时间为永久
    # oprate_lst = {"quit":close_seri}
    # print("操作数字所对应的行为，1:read_from_seri 2:write_to_seri 3:close_seri: ")
    while True:
        text = input(">>")
        write_to_seri(ser, text)
        if text == "quit":
            close_seri(ser)
            print("bye!")
            break

```

### add file write 

```
import sys
import threading
import datetime
import serial
import serial.tools.list_ports

DATA = ""  # 读取的数据
NOEND = True  # 是否读取结束

# def log_init():
file_name = str(sys.argv[0])
log_file = open(file_name + '.log', 'w')
data_file = open(file_name + '.csv', 'w')


# 读数据的本体
def read_data(ser):
    global DATA, NOEND

    # 循环接收数据（此为死循环，可用线程实现）
    while NOEND:
        if ser.in_waiting:
            DATA = ser.read(ser.in_waiting).decode("gbk")
            print("\n>> receive: ", DATA, "\n>>", end="")
            data_file.write('rd:' + DATA)
            # print(">>", end="")
            if (DATA == "quit" or DATA == "quit\n"):
                print("oppo seri has closen.\n>>", end="")

# 列出串口清单
def list_seri():
    ret = False
    try:

        port_list = list(serial.tools.list_ports.comports())
        print(port_list)

        if len(port_list) == 0:
            test_str = r'无可用串口！\n'
            print(test_str)
            test_str = '无可用串口！\n'
            print(test_str)
            ret = False
        else:
            ret = True
            for i in range(0, len(port_list)):
                print(port_list[i])

    except Exception as e:
        print("error!", e)
    return ret

# 打开串口
def open_seri(portx, bps, timeout):
    ret = False
    try:
        # 打开串口，并得到串口对象
        ser = serial.Serial(portx, bps, timeout=timeout)

        # 判断是否成功打开
        if (ser.is_open):
            ret = True
            th = threading.Thread(target=read_data, args=(ser,))  # 创建一个子线程去等待读数据
            th.start()
    except Exception as e:
        print("error!", e)

    return ser, ret


# 关闭串口
def close_seri(ser):
    global NOEND
    NOEND = False
    ser.close()


# 写数据
def write_to_seri(ser, text):
    res = ser.write(text.encode("gbk"))  # 写
    return res


# 读数据
def read_from_seri():
    global DATA
    data = DATA
    DATA = ""  # 清空当次读取
    return data

# import serial.tools.list_ports

if __name__ == "__main__":
    # 列出串口清单
    ret = list_seri()
    # 打开一个串口
    port = input("输入串口名：")
    ser, ret = open_seri(port, 115200, None)  # 串口com3、bps为115200，等待时间为永久
    # oprate_lst = {"quit":close_seri}
    # print("操作数字所对应的行为，1:read_from_seri 2:write_to_seri 3:close_seri: ")
    data_file.write('user: ')
    data_file.write('date: ' + datetime.datetime.now().strftime("%Y-%m-%d") + '\n')
    data_file.write('time: ' + datetime.datetime.now().strftime("%H-%M-%S") + '\n')
    # eg = raw_input('sample used:')

    while True:
        text = input(">>")
        write_to_seri(ser, text)
        data_file.write('wt:' + text + '\n')
        if text == "quit":
            close_seri(ser)
            print("bye!")
            break
```

<br/>
<br/>
<br/>
<br/>
<br/>