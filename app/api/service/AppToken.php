<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * Date: 2017/12/13
 * Time: 22:12
 */

namespace app\api\service;


use app\api\model\ThirdApp;
use app\lib\exception\TokenException;
use app\lib\exception\UserException;
use think\Cache;
use think\Db;

class AppToken extends Token
{
    public function get($ac,$se){
        $ThirdApp = ThirdApp::getUser($ac);
        if(!$ThirdApp){
            throw new UserException();
        }

        //检查用户最近30分钟密码错误次数
        $res = $this->checkPassWrongTime($ThirdApp->id);

        if(!$res){
            throw new UserException([
                'msg'=>'输错很多次密码，系统已经将您账号锁定30min',
                'errorCode' => 60004
            ]);
        }

        if(appEncrypt($se) != $ThirdApp->app_secret){

            //记录错误次数
            $this->recordPassWrongTime($ThirdApp->id);
            throw new TokenException(
                [
                    'errorCode'=>10004,
                    'msg'=>'授权失败'
                ]
            );
        }

        $scope = $ThirdApp->scope;
        $uid = $ThirdApp->id;
        $value = [
            'scope' => $scope,
            'uid' => $uid
        ];
        return $token = $this->saveToCache($value);

    }

    private function saveToCache($value){
        $token = Token::generateToken();
        $expire_in = Config('setting.token_expire_in');
        $result = Cache::set($token,json_encode($value),$expire_in);
        if(!$result){
            throw new TokenException(
                [
                'errorCode'=>10005,
                'msg'=>'服务器缓存异常'
            ]);
        }
        return $token;
    }


    /**
     * 检查用户最近$min分钟密码错误次数
     * $uid 用户ID
     * $min  锁定时间
     * $wTIme 错误次数
     * @return 错误次数超过返回false,其他返回错误次数，提示用户
     */
    protected function checkPassWrongTime($uid, $min=30, $wTime=3)
    {
        $time = time();
        $prevTime = time() - $min*60;

        //用户所在登录ip
        $ip = ip2long( $_SERVER['REMOTE_ADDR'] );

        $wrongTime = Db::name('user_login_info')->where(['user_id'=>$uid,'ipaddr'=>$ip,'pass_wrong_time_status'=>2,'UNIX_TIMESTAMP(login_time)'=>['>',$prevTime]])->count('id');
        //统计错误次数

        //判断错误次数是否超过限制次数
        if ( $wrongTime > $wTime ) {
            return false;
        }

        return $wrongTime;

    }

    //记录密码输出信息
    protected function recordPassWrongTime($uid)
    {
        //ip2long()函数可以将IP地址转换成数字
        $ip = ip2long( $_SERVER['REMOTE_ADDR'] );

        $time = date('Y-m-d H:i:s');
        $data = [
            'user_id'=>$uid,
            'ipaddr'=>$ip,
            'login_time'=>$time,
            'pass_wrong_time_status'=>2
        ];
        Db::name('user_login_info')->insert($data);

    }
}