<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/12
 * Time: 22:55
 */

namespace app\api\model;


use app\api\service\Token;

class User extends BaseModel
{

    protected $autoWriteTimestamp = 'datetime';
    // 定义时间戳字段名

    public function image(){
        return $this->hasMany('UserImage','user_id','id');
    }

    public function interest(){
        return $this->hasOne('UserInterest','user_id','id');
    }

    public function answer(){
        return $this->hasMany('UserAnswer','user_id','id');
    }

    public static function getByopenId($openid){
        $user =self::where('openid','=',$openid)->find();
        return $user;
    }

    public static function getOpenIdByUserId($userId){
        $openId =self::where('user_id','=',$userId)->value('openid');
        return $openId;
    }

    public static function getUserInfo($id){
        return self::with('image,interest,answer')->where('id','=',$id)->find();
    }

    public static function UpdateBase($post){

        $data['nickname'] = $post['nickname'];
        $data['birthday'] = $post['birthday'];
        $data['update_time'] = date('Y-m-d H:i:s');
        $id = 1;
        return self::where('id','=',$id)->update($data);

    }

}