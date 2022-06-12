#  前置知识

## Swift

https://www.runoob.com/manual/gitbook/swift5/source/_book/index.html

## Swift UI

https://developer.apple.com/tutorials/swiftui#swiftui-essentials

# 工程结构

```bash
gmFs
├── Model # 项目中通用的一些数据结构
├── Proto # 服务端IDL生成的代码
├── Service # 网络、接口、分享、加密模块
├── Util # 工具函数和工具类
└── View # 界面相关
    ├── Common # 通用组件的封装
    ├── Disk # 文件列表界面
    │   ├── Node # 文件，文件夹相关界面
    │   └── Share # 分享相关界面
    ├── Login # 登录注册相关界面
    └── Mine # 个人信息相关界面
```



## 程序入口

`gmFS/gmFSApp.swift`

```swift
import SwiftUI

@main
struct gmFSApp: App {
    @StateObject private var shareService = ShareService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shareService)
        }
    }
}
```

## Service

```bash
Service
├── AppManager.swift # 	整个App的管理器，目前只有临时存储用户数据的功能
├── BackendService.swift # 接口模块，负责调用服务端的接口（服务端也称后端，Backend）
├── EncryptService.swift # 数据加密模块
├── NetWorkService.swift # 网络模块， 负责和服务器做HTTPS通信
├── ShareService.swift # 分享模块，负责设备间通信
└── ca.p12 # HTTPS P12证书
```

## View

```bash
View
├── Common
│   └── ToastView.swift # 弹出成功或失败的通用组件
├── ContentView.swift # 程序入口界面，会根据是否登录来选择显示界面
├── Disk
│   ├── AlertInputView.swift # 提示用户输入文件夹名字的封装
│   ├── FileTreeView.swift # 文件列表界面
│   ├── Node
│   │   ├── DirRowView.swift # 文件夹组件
│   │   ├── FileContentView.swift # 显示文件内容的组件
│   │   └── FileRowView.swift # 文件组件
│   └── Share
│       ├── DirTreeView.swift # 收到文件显示可保存的文件夹
│       ├── MCBrowserView.swift # 发现设备界面
│       └── SharedFileView.swift # 显示已收到的文件
├── HomeView.swift # 主界面
├── Login
│   ├── LoginView.swift # 登录界面
│   └── RegisterView.swift # 注册界面
└── Mine
    ├── AboutView.swift # 关于界面
    ├── MineTabView.swift # 个人信息界面
    ├── PasswdChgView.swift # 密码修改界面
    └── SettingView.swift # 设置界面
```

# 演示

见论文功能测试部分
