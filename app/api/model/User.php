<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/12
 * Time: 22:55
 */

namespace app\api\model;


use app\api\service\ComputeYear;
use app\api\service\Token;

class User extends BaseModel
{

    protected $autoWriteTimestamp = 'datetime';
    // 定义时间戳字段名

    public function image(){
        return $this->hasMany('UserImage','user_id','id')->field('url,user_id');
    }

    public function img(){
        return $this->hasOne('UserImage','user_id','id')->order('sort_order asc');
    }

    public function interest(){
        return $this->hasOne('UserInterest','user_id','id')->field('user_id,sport,music,food,movie,cartoon,travel');
    }

    public function answer(){
        return $this->hasMany('UserAnswer','user_id','id')->field('answer_id,qusetion_id,user_id,answer_desc');
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
        $userInfo =  self::with('image,interest,answer')->where('id','=',$id)->find();

        $userInfo->age = ComputeYear::getYear(substr($userInfo->birthday,0,10));
        $userInfo->activity_time = friend_date(strtotime($userInfo->activity_time));
        $userInfo->gender = switchGender($userInfo->gender);
        $userInfo->hidden(['password','mobile','birthday','create_time','delete_time','update_time','status','openid']);
        return $userInfo->toArray();
    }

    public static function UpdateBase($post){

        $data['nickname'] = $post['nickname'];
        $data['birthday'] = $post['birthday'];
        $data['update_time'] = date('Y-m-d H:i:s');
        $id = 1;
        return self::where('id','=',$id)->update($data);

    }


}