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
use app\lib\exception\MatchException;
use app\lib\exception\UserException;
use think\Db;
use app\api\model\Match as MatchModel;

class Match
{
    public static function getWaitToMatchData($id = 0){
        //匹配上的不能再次出现，不喜欢的不能再次出现。

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

    public static function DealWithThink($uid,$object_id,$level = 0){
        if($uid == $object_id){
            Throw new MatchException([
                    'msg'=>'不能自己匹配自己',
                    'errorCode'=>70001
            ]);
        }





    }

    protected function prepareDealWithData($uid,$object_id,$level = 0){
        //1、整理出key
        //2、查找是否有这条数据，有则对比the_former 和the_latter是否都为2以上，成功把is_match变为1，并将成功信息反馈给前端
        //3、
        $the_latter = 0;
        $the_former = 0;
        $data = [];
        if($uid < $object_id){
            $key = $uid.'_'.$object_id;
            $the_former = $level;
            $match_history = MatchModel::where('key','=',$key)->find();
            if($match_history){
                //存在匹配历史
                if($the_former >= 2 && $match_history->the_latter>= 2 ){
                    //更新数据
                    $prepareData['the_former'] = $the_former;
                    $prepareData['the_former'] = $the_former;
                    $update_match = MatchModel::where('key','=',$key)->where()->find();
                }

            }

        }else{
            $key = $object_id.'_'.$uid;
            $the_latter = $level;
            $match_history = MatchModel::where('key','=',$key)->find();
            if($match_history){
                //存在匹配历史
                if($match_history->the_former>= 2 || $match_history->the_latter>= 2 ){

                }

            }
        }



        $data['key'] = $key;
        $data['the_latter'] = $the_latter;
        $data['the_former'] = $the_former;
        //不存在匹配历史
        MatchModel::insert($data);

    }
}