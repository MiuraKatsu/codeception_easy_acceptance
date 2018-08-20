# codeception_easy_acceptance

[![CircleCI](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance.svg?style=svg)](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance)

[日本語](README.ja.md)

### simple end-to-end acceptance tests using codeception

* I am building all execution environment of codeception and selenium sever with docker-compose.
* Acceptance test using three kinds of browsers, PHP Browser, chrome, firefox can be executed at the same time.
    

## Installation

* Docker
* Docker-Compose

## Configuration

### Url

Url is set in param.php

```php:tests/param.php
<?php

    $TARGET_URL = 'https://codeception.com/';

    return [
        'TARGET_URL' => $TARGET_URL
    ];
```

### Environments

We set three kinds of browser environments with acceptance.suite.yml.

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

You can specify each environment with ```@env``` annotation.

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

Now that we have a Makefile, the test will only be executed with the ```make``` command.

```
make
```

## Debug

If you run the ```docker-compose run``` command individually, you can also narrow it down with the ```@env```, ```@group``` annotation.

```
docker-compose run codecept run --env firefox -g onlythisone
```

You can check with vnc whether it is actually connected.


```
make open-vnc
```
