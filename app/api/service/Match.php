<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/13/013
 * Time: 14:40
 */

namespace app\api\service;

use app\api\model\MatchInfo;
use app\api\model\Setting as SettingModel;
use app\api\model\UserFriend;
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

    public static function DealWithSlideData($uid,$object_id,$level = 0){

        // 1、是否存在这条数据，Y更新，N插入
        // 2、判断level级别，喜欢进入下一步，不喜欢直接跳过。
        // 3、是否存在对方数据，Y比较,N结束
        // 4、对方也喜欢，产生一条匹配成功的好友数据

            // 1、是否存在这条数据，Y更新，N插入
            $is_self_exist = MatchInfo::where(['user_id'=>$uid,'object_id'=>$object_id])->find();
            if($is_self_exist){
                //存在，已经匹配过
                MatchInfo::where(['user_id'=>$uid,'object_id'=>$object_id])->update(['level'=>$level,'update_time'=>date('Y-m-d H:i:s')]);
            }else{
                $matchData = [
                    'user_id'=>$uid,
                    'object_id'=>$object_id,
                    'level'=>$level,
                    'create_time'=>date('Y-m-d H:i:s'),
                ];
                MatchInfo::insert($matchData);
            }

            // 2、判断level级别，喜欢进入下一步，不喜欢直接跳过。
            if($level > 1){

                    // 3、是否存在对方数据，Y比较,N结束
                    $is_object_exist = MatchInfo::where(['user_id'=>$object_id,'object_id'=>$uid])->find();
                    if(!$is_object_exist){
                        return ['status'=>-1];
                    }

                    // 4、对方也喜欢，产生一条匹配成功的好友数据
                    if($is_object_exist['level'] > 1){
                        $create_time = date('Y-m-d H:i:s');
                        $friendData[0] = [
                            'user_id'=>$uid,
                            'friend_id'=>$object_id,
                            'create_time'=>$create_time,
                        ];
                        $friendData[1] = [
                            'user_id'=>$object_id,
                            'friend_id'=>$uid,
                            'create_time'=>$create_time,
                        ];

                        //删除旧的数据，测试用
                        $daleteData1 = [
                            'user_id'=>$uid,
                            'friend_id'=>$object_id,
                        ];
                        $daleteData2 = [
                            'user_id'=>$object_id,
                            'friend_id'=>$uid,
                        ];
                        Db::name('user_friend')->where($daleteData1)->delete();
                        Db::name('user_friend')->where($daleteData2)->delete();


                        Db::name('user_friend')->insertAll($friendData);
//                        UserFriend::insertAll($friendData);
                        return ['status'=>1,'msg'=>'对方也喜欢你!'];
                    }
            }
            return ['status'=>-1];

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