<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 16:09
 */

namespace app\lib\exception;


class SettingMissException extends BaseException
{
    public $code = 404;
    public $msg = '请求的Setting不存在';
    public $errorCode = '60002';

}