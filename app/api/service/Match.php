<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/13/013
 * Time: 14:40
 */

namespace app\api\service;

use app\api\model\Setting as SettingModel;
use app\lib\exception\UserException;
use think\Db;

class Match
{
    public static function getWaitToMatchData($id = 0){
        //1、根据
        $user  = Db::name('user_address');

        //获取用户ip
//        $user_ip= $_SERVER["REMOTE_ADDR"];//获取客户端IP
        $user_ip = '116.7.170.160';
        $location = get_lat_and_lng_ByIP($user_ip);
        if($location['status'] == -1){
            throw new UserException(
                [
                    'errorCode'=>61001,
                    'msg' => $location['msg']
                ]);
        }


        $client_lon = $location['result']['point']['x'];
        $client_lat = $location['result']['point']['y'];

        //取得用户配置，得到希望匹配意向，男女不限等
        $sexual_orientation = SettingModel::getSettingByVal($id,'sexual_orientation');
        $sql = "SELECT address,nickname,birthday,activity_time,vocation,field,user_id,ROUND(6378.138*2*ASIN(SQRT(POW(SIN(($client_lat*PI()/180-lat*PI()/180)/2),2)+COS($client_lat*PI()/180)*COS(lat*PI()/180)*POW(SIN(($client_lon*PI()/180-lon*PI()/180)/2),2)))*1000) AS distance FROM user_address JOIN user AS u ";
        $sql .= "where is_default = 1 and user_id = u.id and u.id <> $id";

        if($sexual_orientation != 0){
            $sql .= " and gender = $sexual_orientation ";
        }

        $sql .= "  ORDER BY distance ASC  LIMIT 20";
        $result = $user->query($sql);

        foreach ($result as &$v){
            $v['img'] = Db::name('user_image')->field('url,sort_order')->where(['user_id'=>$v['user_id']])->order('sort_order asc')->select()->toArray();
        }

        return $result;
    }
}