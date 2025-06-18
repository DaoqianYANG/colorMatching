本项目遵循GPL-3.0-or-later许可证，完整条款见[LICENSE](LICENSE)文件。

### **鸿蒙应用开源项目.HarmonyOS、ArkTS、ArkUI**
无联网单机项目 应用页面已适配普通屏、折叠屏、平板、即应用上下分屏、左右分屏 适用于学习和样式参考和窗口宽高的异步处理参考。

本项目基于 "Color颜值" 微信小程序项目的衍生作品，遵循GNU通用公共许可证第三版（GPL-3.0）或更高版本。原始代码可访问：https://github.com/czcaiwj/color

### 功能说明

色搭配是一个基于色轮配色原理的鸿蒙App。通过这一鸿蒙App，可以搭配出协调的色彩，令你的配色工作更加轻松。

_一、配色广场，提供了中国和日本传统颜色，以及自己收藏的配色方案。_

_二、颜色转换，提供了颜色在RGB、CMYK、LAB、HSB四个色彩空间以及HEX的换算操作，方便在查询色彩分量的同时，参考其他色彩空间的值。_

_三、配色工具，提供了基于六种颜色关系的配色算法。 1、类比色、相似色：相邻的颜色称为类比色。类比色都拥有相近的颜色，该配色原理根据给定的基准色和角度，计算两个与基准色夹角递增的类比色以及两个与基准色夹角递减的类比色。_

        1、类比色、相似色：相邻的颜色称为类比色。类比色都拥有相近的颜色，该配色原理根据给定的基准色和角度，计算两个与基准色夹角递增的类比色以及两个与基准色夹角递减的类比色。
        
        2、互补色：在色轮上直线相对的两种颜色称为互补色。补色形成强列的对比效果，传达出活力、能量、兴奋等意义。
        
        3、分裂补色：如果同时用补色及类比色的方法来确定的颜色关系，就称为分裂补色。这种颜色搭配既具有类比色的低对比度的美感，又具有补色的力量感。形成了一种既和谐又有重点的颜色关系。
        
        4、单色：一种色相由暗、中、明三种色调组成。该算法根据基准色的色相，按比例调整配色的亮度和饱和度。
        
        5、渐变：渐变由指定的基准色通过变化一定比例的亮度或饱和度来得到。

        6、二次色配比：二次色之间都拥有一种共同的颜色，其中两种拥有相同的蓝色分量，两种拥有相同的绿色分量，两种拥有相同的红色分量。它们轻易能够形成协调的搭配。如果三种二次色同时使用，则显得很舒适、吸引，并具有丰富的色调。它们同时具有的颜色深度及广度。
        
        7、I am Feeling Lucky是在使用者无需考虑配色原理的前提下，随机搭配一种配色算法给出的配色方案。

_四、Web颜色，列举了Web标准规范中HTML和CSS定义的标准色和安全色。_

### App截图

<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T000821.png" width="40%" alt="Color色搭"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T000925.png" width="60%" alt="配色广场"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T000942.png" width="60%" alt="中国传统色彩"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T000951.png" width="60%" alt="日本传统色彩"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T001027.png" width="60%" alt="Web颜色"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T001037.png" width="60%" alt="色彩工具"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T001100.png" width="60%" alt="互补色配色"><br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2FScreenshot_2025-06-19T001005.png" width="60%" alt="颜色转换"><br>

### 安装说明
[开发环境下载和安装指南](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/ide-software-install)<br>
1.打开 DevEco Studio并打开本项目文件夹，选择右上方菜单栏中的 NoDevices > Device Manager 图标（长得像手机） 来打开设备管理器。<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F1.png" width="1024px" alt="1"><br>
2.在 Device Manager 窗口中，点击 New Emulator,从设备列表里挑选一款设备（例如 Phone），然后点击 Next，要是没有已下载的镜像，点击 Download 进行下载，下载完成后点击 Next。<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F2.png" width="1024px" alt="2"><br>
3.为模拟器设置名称（可以使用默认名称），再点击 Finish 完成创建。<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F3.png" width="1024px" alt="2"><br>
4.在 Device Manager 窗口中，找到已创建的模拟器，点击模拟器右侧的 Run 按钮（三角形图标）。<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F4.png" width="1024px" alt="2"><br>
5.模拟器会自动启动，启动过程可能需要 1 - 2 分钟。<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F5.png" width="1024px" alt="2"><br>
6.模拟器启动完毕后，右上方菜单栏中的 NoDevices下拉框会出现刚创建并启动模拟器，选中它后点Run按钮<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F6.png" width="1024px" alt="2"><br>
7.等待项目构建完成，大概30~50秒即会自动运行本项目<br>
<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2F7.png" width="1024px" alt="2"><br>

### 感谢🙏~

谢谢喏~ 🙏谢谢(🙏ˊᗜˋ*) 祝您阖家平安!六腑调泰!朱颜长春进致四方钱财~生活常处富足之中!~~~

<img src="https://glaze-1253247173.cos.ap-chengdu.myqcloud.com/%E8%89%B2%E6%90%AD%2Faa.png" width="80%" alt="答谢作者">
