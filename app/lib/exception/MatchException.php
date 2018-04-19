<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/17/017
 * Time: 17:10
 */

namespace app\lib\exception;


class MatchException extends BaseException
{
    public $code = 403;
    public $msg = '匹配异常';
    public $errorCode = '70000';
}