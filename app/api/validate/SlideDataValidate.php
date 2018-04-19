<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/19/019
 * Time: 16:10
 */

namespace app\api\validate;

use app\api\service\Token as TokenService;

class SlideDataValidate extends BaseValidate
{
    protected $rule = [
        'object_id'=>'require|isNotSelf|isPositiveInteger',
        'level'=>'require|between:1,3|isPositiveInteger',
    ];
    protected $message = [
        'object_id.require'=>'匹配的对象呢？',
        'object_id.isNotSelf'=>'匹配的对象不能是自己呀！',
        'object_id.isPositiveInteger'=>'object_id必须为正整数!!',
        'level'=>'你必须在喜欢与不喜欢做出选择！',
        'level.isPositiveInteger'=>'level必须为正整数!!',

    ];


    public function isNotSelf($object_id){
        $uid = TokenService::getCurrentUId();
        if($uid == $object_id){
            return false;
        }
        return true;
    }
}