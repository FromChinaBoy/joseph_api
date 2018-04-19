<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/12/012
 * Time: 9:56
 */

namespace app\api\model;


class ExtendSetting extends BaseModel
{
    public static function getExSetting($id){
        return  self::where('user_id','=',$id)->find();
    }
}