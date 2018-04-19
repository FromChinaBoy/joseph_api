<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * Date: 2018/4/19
 * Time: 23:31
 */

namespace app\api\service;


class ComputeYear
{
    private static $leapYears = 0;

    public static function getYear($birthday){
        $currentDay = new \DateTime();
        self::getLeapYears($currentDay->format('Y-m-d'),$birthday);
        $daysDiff = date_diff($currentDay,date_create($birthday));
        $realDays = $daysDiff->days-self::$leapYears;
        if($realDays >= 365){
            $age = floor($realDays / 365);
            return $age;
        }else{
            return 0;
        }
    }

    private static function getLeapYears($currentDay,$birthDay){
        $currentYear = date('Y',strtotime($currentDay));
        $currentMonth = date('m',strtotime($currentDay));
        $birthYear = date('Y',strtotime($birthDay));
        $birthMonth = date('m',strtotime($birthDay));
        if($birthMonth > 2){
            $birthYear += 1;
        }
        if($currentMonth < 2){
            $currentYear += 1;
        }
        for($i = $birthYear;$i<=$currentYear;$i++){
            if(self::checkLeap($i)){
                self::$leapYears++;
            }
        }
    }

    private static function checkLeap($year){
        $time = mktime(20,20,20,2,1,$year);
        if (date("t",$time)==29){
            return true;
        }else{
            return false;
        }
    }
}