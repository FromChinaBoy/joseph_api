<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 15:14
 */

namespace app\api\model;


class UserAnswer extends BaseModel
{
    public function getQusetionIdAttr($value){
        return Question::getDescById($value);
    }

}