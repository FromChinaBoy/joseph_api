<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 13:06
 */

namespace app\api\controller\v1;


use app\api\controller\BaseController;
use app\api\model\Setting;
use app\api\model\UserAnswer;
use app\api\validate\IDMustBePositiveInt;
use app\api\model\User as UserModel;
use app\lib\exception\UserException;

class User extends BaseController
{
//    protected $beforeActionList =[
//        'needPrimaryScope'=>['only'=>'user_info']
//    ];

    public function getById(){
        (new IDMustBePositiveInt())->goCheck();
        $UserInfo = UserModel::getUserInfo($_POST['id']);
        if(!$UserInfo){
            throw new UserException();
        }
        return json($UserInfo,200);
    }
}