<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 16:04
 */

namespace app\api\model;


class Setting extends BaseModel
{
    protected $hidden = [

    ];
    public function briefAddress(){
        return $this->hasOne('UserAddress','user_id','user_id')->field('address,user_id')->where('is_default','=',1);
    }

    public function address(){
        return $this->hasMany('UserAddress','user_id','user_id');
    }

    public static function getSetting($id){
        return self::with('briefAddress')->where('user_id','=',$id)->find();
    }

    public static function getSettingByVal($id,$val){
        return self::where('user_id','=',$id)->value($val);
    }
}