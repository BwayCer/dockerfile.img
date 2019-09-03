遠端 Chromium
=======


> **版　本：** v1.0.0

> **基底映像：** [node:alpine](https://hub.docker.com/_/node)

> **拉取映像：** [`docker pull bwaycer/remote-chromium`](https://hub.docker.com/r/bwaycer/remote-chromium)



## 簡介


Chromium 是 [GitHub GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer)
的依賴工具，
不過其佔容量空間太大 (約 320 MB)，
期望能獨立瀏覽器容器並且自動化遠端連接的工作。



## 類似工具


**[GitHub adieuadieu/serverless-chrome/tree/master/packages/lambda](https://github.com/adieuadieu/serverless-chrome/tree/master/packages/lambda)：**

參考 [Serverless Chrome on AWS Lambda, the guide that works in 2019 and beyond - A geek with a hat 文章](https://swizec.com/blog/serverless-chrome-on-aws-lambda-the-guide-works-in-2019-beyond/swizec/9024)
的做法確實可以開啟遠端瀏覽器， 但是卻無法增加 `--lang=zh-TW` 旗標選項以至於需求網頁被引導至英文版。

在 [`README.md`](https://github.com/adieuadieu/serverless-chrome/tree/master/packages/lambda#setup)
中明明有寫道可以用旗標選項，但卻沒有效果。

```js
const launchChrome = require('@serverless-chrome/lambda')

launchChrome({
    flags: ['--window-size=1280,1696', '--hide-scrollbars']
})
```



**其他：**


* [GitHub cyrus-and/chrome-remote-interface](https://github.com/cyrus-and/chrome-remote-interface)
* [https://github.com/GoogleChrome/chrome-launcher](https://github.com/GoogleChrome/chrome-launcher)



## 示範


**啟動遠端 Chromium：**

```
$ docker run --rm -it --network host bwaycer/remote-chromium
DevTools listening on ws://127.0.0.1:9222/devtools/browser/eda95be4-1427-4d8e-a947-f90cd223e708
```


**執行 puppeteer：**

```js
const puppeteer = require('puppeteer-core');

(async () => {
    const browser = await puppeteer.connect({
        browserWSEndpoint: 'ws://127.0.0.1:9222/devtools/browser/b759498e-8afd-4354-8a53-87b6c5fc70f5',
        headless: true,
    });

    const page = await browser.newPage();
    await page.goto('http://example.com/');
    await page.evaluate(function () {...});

    browser.close();
})();
```



## 參考


* [GitHub GoogleChrome/puppeteer/issues/1793 - docker alpine with node js and chromium headless - puppeter - failed to launch chrome](https://github.com/GoogleChrome/puppeteer/issues/1793#issuecomment-437688599)
* [Connecting Puppeteer to Existing Chrome Window w/ reCAPTCHA](https://medium.com/@jaredpotter1/connecting-puppeteer-to-existing-chrome-window-8a10828149e0)

