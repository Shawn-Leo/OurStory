#  API 接口说明  
### 本文档用于解释项目中使用的各种API接口，便于使用。
## SocketIOManager
*此部分为与网络相关的各种method，以此将socket变量和界面的关联剥离开*  
- 函数名称：**didReceive**
    > 函数功能：描述客户端收到各类信息时的处理方式
    > 参数接口：使用协议默认参数，我们无需修改
    > 返回值：无
    > 例子：当客户端连接到服务器时，收到一个.connected信息，触发相关case，向控制台输出"websocket is connected:\(headers)"，
    >            向服务器发送“Hi Server"
    > 更改日志：2020/07/16 由刘相廷创建，并添加连接成功时向服务器发信的功能
    > 备注：此函数参考了starscream的自带demo
## M
## V
## C
## Utilities
*此部分中的函数用于处理一些特定的信息或完成一些不属于特定类的工作，提升效率*
- 函数名称：**imageFromProjectDecode**
    > 函数功能：实现工程中的图片解码，将图片编码为base64，且经过URL转换的字符串，便于后续传输，为使用【相对路径】调取图片的方法
    > 参数接口：type: 字符串，为图片的类型，目前只提供jpg和png两种类型的转换
    >                   imageDir: 字符串，为图片在此工程下的相对路径，【不包含后缀】
    > 返回值：经过编码后的字符串
    > 例子：假设工程中有一个叫"1.jpg"的图片，可以通过`imageFromProjectDecode(type: "jpg", imageDir: "1")`
    >            来获得编码后的字符串
    > 更改日志：2020/07/23 由刘相廷创建
    > 备注：由于使用了Bundle，此函数只能用于已经导入工程中的图片         如果你想要让图片可以不用手动加入到Xcode中，可以选择先新建一个图片文件夹，将这个文件夹提前加入工程中，并在后续
        操作中将图片保存在那个文件夹下，这样就可以通过相对路径来调用了

- 函数名称：**imageOutsideProjectDecode**
    > 函数功能：实现工程外的图片解码，和前面的功能类似，为使用【绝对路径】调取图片的方法
    > 参数接口：type: 字符串，为图片的类型，目前只提供jpg和png两种类型的转换
    >                   imageDir: 字符串，为图片的绝对路径，【包含后缀】
    > 返回值：经过编码后的字符串
    > 例子：假设桌面上有一个叫"1.jpg"的图片，可以通过
    >             `imageOutsideProjectDecode(type: "jpg", imageDir: "/Users/apple/Desktop/1.jpg")`来获得编码后的
    >              字符串
    > 更改日志：2020/07/23 由刘相廷创建

- 函数名称：**imageEncode**
    > 函数功能：将经过base64编码，且经过URL转化的图片转码字符串重新转码成为UIImage图片
    > 参数接口：base64Data: 经过转化的图片字符串
    > 返回值：经过转码后得到的图片，为UIImage类型
    > 例子：假设Data为一个经过了Decode函数编码后的图片，可以通过`imageEncode(base64Data: Data)`获得原先的UImage
    > 更改日志：2020/07/23 由刘相廷创建

- 函数名称：**imageSave**
    > 函数功能：将UIImage另存到其他位置
    > 参数接口：imageName：文件名
    >                   type：另存的文件种类，可以为jpg或png
    >                   imageDir：另存到的位置，必须以/结尾
    >                   image：需要另存的图片，为UIImage类型
    > 返回值：是否另存成功，成功返回1，否则返回0
    > 例子：假设image为一个UIImage，可以通过
    >            `imageSave(imageName: "1", type: "jpg", imagedir: "/Users/apple/Desktop/", image: image)`
    >            来将这个图片另存到桌面上，文件名为"1.jpg"
    > 更改日志：2020/07/23 由刘相廷创建

- 扩展 **StringExtension**
    > 用于给string类型添加一些用法，使之与python类似，更加实用
    > 经过这个扩展，String类型现在可以：
    >> 通过length属性获得长度
    >> 通过下标获得子串或特定位置字符
    >> 通过`substring`函数将字符串从中间截断获得前半段或后半段子串
    >> 通过`toInt`将一个十进制数字字符串转换为数字
    ```
    let str = "abcdef"
    str[1 ..< 3] // returns "bc"
    str[5] // returns "f"
    str[80] // returns ""
    str.substring(fromIndex: 3) // returns "def"
    str.substring(toIndex: str.length - 2) // returns "abcd"
    let num = "12"
    num.toInt() // returns 12
    ```

- 函数名称：**writeLoginInformation**
    > 函数功能：将用户ID、密码以及“是否记住密码”信息写入本地
    > 参数接口：ID：用户ID，唯一标识，为utf8String
    >                   Password：用户密码，为utf8String
    >                   rememberPasswordFlag：是否记住密码，整数，0为否，1为是
    > 返回值：无
    > 例子：通过`LoginPageViewController.writeLoginInformation(ID: "Shawn",
    >     Password: "lxt5393792", rememberPasswordFlag: 1)` 可以将用户的用户名密码以及“是否记住密码”信息保存到本地
    >     便于下次使用
    > 更改日志：2020/08/04 由刘相廷创建
    
- 函数名称：**loadLoginInformation**
    > 函数功能：读取存储在本地的用户ID、密码以及“是否记住密码”信息
    > 参数接口：ID：用户ID，唯一标识，为utf8String
    >                   Password：用户密码，为utf8String
    >                   rememberPasswordFlag：是否记住密码，整数，0为否，1为是
    > 返回值：无
    > 例子：`LoginPageViewController.loadLoginInformation(ID: &ID, Password: &Password, rememberPasswordFlag: &flag)`
    > 通过这个方式可以为ID，Password和flag三个变量赋值，便于显示到界面上
    > 更改日志：2020/08/04 由刘相廷创建
    > 备注：具体使用时，无论用户是否选择“记住密码”都可以使用这个函数，若用户没有选择记住密码，你的Password会被赋值为空字符串，直接将其设置为密码栏初始文本即可

- 函数名称：**messageSplit**
    > 函数功能：用于处理特定格式消息，将其转化为其中的有效信息
    > 参数接口：message：处理前的字符串，消息格式为：类型信息 + [字符串长度 + 字符串]
    > 返回值：处理后的信息数组
    > 例子：`messageSplit("login 5 shawn 10 lxt5393792") = {"shawn","lxt5393792"}`
    > 更改日志：2020/07/28 由刘相廷创建
