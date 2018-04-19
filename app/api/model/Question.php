<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 15:16
 */

namespace app\api\model;


class Question extends BaseModel
{
    public static function getDescById($id){
        return self::where('question_id','=',$id)->value('question_desc');
    }
}