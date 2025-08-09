# cloud
cloud_monitor

项目结构采用DDD
cloud-monitor/                          # 根目录
│
│── cmd/                                 # 应用启动入口
│   └── main.go                          # 启动程序（加载配置、初始化依赖、启动服务）
│
│── configs/                             # 配置文件（加密存储，避免明文）
│
│── internal/                            # 项目核心代码（DDD 四层架构）
│   ├── domain/                          # 领域层：核心业务逻辑（纯 Go，无第三方依赖）
│   │   ├── monitor/                     # 网站监控领域
│   │   │   ├── entity.go                 # 实体（Entity）：有唯一 ID 的业务对象
│   │   │   ├── repository.go             # 仓储接口：数据持久化抽象
│   │   │   ├── service.go                 # 领域服务：封装业务规则
│   │   │   └── value_object.go            # 值对象：业务值类型（不可变，无唯一 ID）
│   │   └── user/...                      # 用户领域
│   │
│   ├── application/                      # 应用层：用例编排（调用领域服务完成业务场景）
│   │   ├── monitor_app.go                 # 监控任务应用用例
│   │   └── user_app.go                    # 用户应用用例
│   │
│   ├── infrastructure/                   # 基础设施层：技术实现（DB、缓存、API 调用等）
│   │   ├── persistence/                   # 持久化实现（如 GORM、MySQL、Redis）
│   │   │   ├── monitor_repo.go             # 监控任务仓储实现
│   │   └── config/                         # 配置加载与加解密
│   │
│   └── interfaces/                        # 接口层：对外 API、消息订阅等
│       ├── http/                           # HTTP API（Gin）
│       │   ├── monitor_handler.go           # 监控任务 HTTP 接口
│       │   └── user_handler.go              # 用户 HTTP 接口
│       └── middleware/                      # 中间件（鉴权、日志、跨域等）
│
│── pkg/                                    # 公共工具库（加密、日志、响应封装等）
