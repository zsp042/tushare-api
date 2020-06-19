# tushare-api

[tushare.pro](https://tushare.pro/) 的 HTTP API 封装。

## 安装

```
npm install tushare-api
```

## 使用说明


首先，设置环境变量 TUSHARE_TOKEN

```
API = require('tushare-api')
```

也可以这样

```
API = require('tushare-api/api')("你的令牌xxx")
```

使用方式，比如读取沪深日线的成交量、成交额，调用如下 :

  ```
  const API = require('tushare-api');

  (async ()=>{
    var data = await API.index_daily(
      {
        ts_code:'399300.SZ',
        start_date:20180101,
        end_date:20181010,
      },
      "vol,amount"
    );
    console.log(data);
  })()
  ```

## 开发说明

进入 `src` 目录

运行一次测试 `npm run test`

持续运行测试 `npm run dev`

[代码库地址 github.com/TqLj/tushare-api](https://github.com/TqLj/tushare-api)
