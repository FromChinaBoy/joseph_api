<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/12/012
 * Time: 10:23
 */

namespace app\api\validate;


class UserValidate extends BaseValidate
{
    protected $rule=[
        'nickname'=>'require|isNotEmpty',
        'mobile'=>'require|isMobile',
        'birthday'=>'require|checkDateIsValid'
    ];

    protected $message = [
        'nickname'=>'昵称不能为空',
        'mobile.isMobile'=>'电话号码格式有误',
        'birthday.checkDateIsValid'=>'生日格式有误'
    ];

    protected $scene = [
        'base'=>'nickname,birthday'
    ];
}