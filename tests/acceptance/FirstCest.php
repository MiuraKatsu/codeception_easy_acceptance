<?php

/**
 * @group all
 */
class FirstCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    public function _after(AcceptanceTester $I)
    {
    }

    /**
     * @env phpbrowser
     */
    public function tryToPhpbrowserTest(AcceptanceTester $I)
    {
        $I->wantTo('test top page');
        codecept_debug($I->amOnPage('/'));
        $I->see('codeception','//*[@id="home-hero"]/div/h1');
        codecept_debug($I->grabTextFrom('//*[@id="home-hero"]/div/h1'));
    }

    /**
     * @env chrome
     */
    public function tryToChromeTest(AcceptanceTester $I)
    {
        $I->wantTo('test top page');
        codecept_debug($I->amOnPage('/'));
        $I->see('codeception','//*[@id="home-hero"]/div/h1');
        codecept_debug($I->grabTextFrom('//*[@id="home-hero"]/div/h1'));

        $I->makeScreenshot("top");
    }

    /**
     * @env firefox
     */
    public function tryToFirefoxTest(AcceptanceTester $I)
    {
        $I->wantTo('test top page');
        codecept_debug($I->amOnPage('/'));
        $I->see('codeception','//*[@id="home-hero"]/div/h1');
        codecept_debug($I->grabTextFrom('//*[@id="home-hero"]/div/h1'));

        $I->makeScreenshot("top");
    }
}
