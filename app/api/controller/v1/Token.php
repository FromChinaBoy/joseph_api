<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/11
 * Time: 20:53
 */

namespace app\api\controller\v1;

use app\api\service\AppToken;
use app\api\validate\ThirdAppValidate;
use app\api\validate\TokenGet;
use app\api\service\UserToken;
use app\lib\exception\ParameterException;
use app\api\service\Token as TokenService;

class Token
{
    //微信小程序登录
    public function getToken($code = ''){
        (new TokenGet())->goCheck();
        $tk = new UserToken($code);
        $token =$tk->get();
        return json([
           'token' => $token,
        ]);

    }

    //手机账号登录
    public function getAppToken($ac = '',$se = ''){
        (new ThirdAppValidate())->goCheck();
        $app = new AppToken();
        $token = $app->get($ac,$se);
        return json([
            'token'=>$token
        ]);
    }

    public function verifyToken($token = ''){
        if(!$token){
            throw new ParameterException(
                [
                    'msg' => 'token参数不能为空'
                ]
            );
        }

        $valid = TokenService::verifyToken($token);
        return json([
            'isValid' =>$valid
        ]);
    }
}