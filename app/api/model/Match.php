<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/17/017
 * Time: 17:02
 */

namespace app\api\model;


use think\Db;

class Match extends BaseModel
{

    protected $autoWriteTimestamp = true;
    public static function beSuperLike($id = 0){
        $result = self::where(['object_id'=>$id,'level'=>3])->select();
        return $result;
    }
}