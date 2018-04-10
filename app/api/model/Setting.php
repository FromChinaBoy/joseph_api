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
        return $this->hasOne('UserAddress','user_id','user_id');
    }
    public function address(){
        return $this->hasMany('UserAddress','user_id','user_id');
    }

    public static function getSetting($id){
        return self::with('briefAddress')->where('user_id','=',$id)->find();
    }
}