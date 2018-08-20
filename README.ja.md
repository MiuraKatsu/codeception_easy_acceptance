# codeception_easy_acceptance

[![CircleCI](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance.svg?style=svg)](https://circleci.com/gh/MiuraKatsu/codeception_easy_acceptance)

### codeceptionを使ったE2Eの受け入れテストが簡単に実行できます

## Installation

* Docker
* Docker-Compose

## Configuration

### URL

URLはtests/param.phpで設定しています。

```php:tests/param.php
<?php

    $TARGET_URL = 'https://codeception.com/';

    return [
        'TARGET_URL' => $TARGET_URL
    ];
```

## Write Acceptance Test



## Run

```
make
```
