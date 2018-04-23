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
use app\api\model\User as UserModel;
use app\api\validate\IDMustBePositiveInt;
use app\api\validate\UserValidate;
use app\lib\exception\UserException;
use app\api\service\Token as TokenService;
use app\api\service\Match as MatchService;


class User extends BaseController
{

    protected $beforeActionList =[
        'needPrimaryScope'=>['only'=>'user_info']
    ];
    protected $uid;
    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->uid = TokenService::getCurrentUId();
    }

    //获取用户信息
    public function getById(){
        (new IDMustBePositiveInt())->goCheck();
        $UserInfo = UserModel::getUserInfo($_POST['id']);
        $match = new MatchService();
        $distince = $match->getDistince($this->uid);
        $UserInfo['distince'] = switchMeter($distince);

        if(!$UserInfo){
            throw new UserException();
        }
        return json($UserInfo,200);
    }

    //编辑个人基本信息
    public function updateUserBase(){
        (new UserValidate())->goCheck('base');
        $user = new UserModel();
        $user->nickname = $_POST['nickname'];
        $user->birthday = $_POST['birthday'];

        $user->id = $this->uid;
        $update_result=  $user->isUpdate()->save();

        
        if(!$update_result){
            throw new UserException([
                'msg'=>'用户信息更新失败',
                'errorCode'=>60003
            ]);
        }
        return json(['status'=>1],200);
    }

    //更新用户活跃时间
    public function updateActivityTime(){
        $user = new UserModel();
        $user->id = $this->uid;
        $user->activity_time = date('Y-m-d H:i:s');
        $update_result=  $user->isUpdate()->save();


        if(!$update_result){
            throw new UserException([
                'msg'=>'更新活跃时间失败',
                'errorCode'=>60003
            ]);
        }
        return json(['status'=>1],200);
    }
}