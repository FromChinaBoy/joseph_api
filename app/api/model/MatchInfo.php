<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/19/019
 * Time: 17:23
 */

namespace app\api\model;


class MatchInfo extends BaseModel
{
    public function user(){
        return $this->belongsTo('user','user_id','id');
    }

    public static function beSuperLike($id = 0){
        $result = self::with('user.img')->field('user_id,object_id,level')->where(['object_id'=>$id,'level'=>3])->select();
        return $result->hidden(['user.nickname']);
    }
}