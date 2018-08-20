# codeception_easy_acceptance

[![CircleCI](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance.svg?style=svg)](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance)

### codeceptionを使った簡単なE2Eの受け入れテスト

* codeceptionの実行環境とselenium severを全部Dockerで構築しています。
* PHP Browser,chrome,firefoxの３種類のブラウザを使ったAcceptanceテストが同時に実行できます。

## Installation

* Docker
* Docker-Compose

## Configuration

### Url

Urlはparam.phpで設定しています。

```php:tests/param.php
<?php

    $TARGET_URL = 'https://codeception.com/';

    return [
        'TARGET_URL' => $TARGET_URL
    ];
```

### Environments

acceptance.suite.ymlでブラウザ環境を３種類設定しています。

```yaml:tests/acceptance.suite.yml
actor: AcceptanceTester
class_name: AcceptanceTester

extensions:
    enabled:
        - Codeception\Extension\Recorder:
env:
    phpbrowser:
        modules:
            enabled:
                - PhpBrowser:
                - \Helper\Acceptance
            config:
                PhpBrowser:
                    url: %TARGET_URL%

    firefox:
         modules:
            enabled:
                - WebDriver:
            config:
                WebDriver:
                    url: %TARGET_URL%
                    browser: firefox
                    host: firefox
                    window_size: 1280x1024
                    capabilities:
                        javascriptEnabled: true
                        firefoxOptions:
                            args:
                                []

    chrome:
         modules:
            enabled:
                - WebDriver:
            config:
                WebDriver:
                    url: %TARGET_URL%
                    browser: chrome
                    host: chrome
                    window_size: 1280x1024
                    capabilities:
                        javascriptEnabled: true
                        chromeOptions: # additional chrome options
                            args:
                                ['disable-infobars', 'headless', 'disable-gpu']
```

## Write Acceptance Test

```@env```アノテーションでそれぞれの環境を指定できます。

```
<?php

/**
 * @group all
 */
class FirstCest
{

    /**
     * @env phpbrowser
     */
    public function tryToPhpbrowserTest(AcceptanceTester $I)
    {
        // some test
    }

    /**
     * @env chrome
     */
    public function tryToChromeTest(AcceptanceTester $I)
    {
        // some test
    }

    /**
     * @env firefox
     */
    public function tryToFirefoxTest(AcceptanceTester $I)
    {
        // some test
    }
}
```

## Run

Makefileを用意したので、```make```コマンドだけでテストは実行されます。

```
make
```

## Debug

```docker-compose run```コマンドを個別に実行すれば、```@env```,```@group```アノテーションで絞り込んだ実行もできます。
```
docker-compose run codecept run --env firefox -g onlythisone
```

実際に接続できているかはvncで確認できます。

```
make open-vnc
```
