<?php
/**
 * Created by PhpStorm.
 * User: ZZHPENG
 * QQ: 398949389
 * Date: 2018/4/10/010
 * Time: 16:25
 */

namespace app\api\controller\v1;


use app\api\controller\BaseController;
use app\api\validate\IDMustBePositiveInt;
use app\lib\exception\SettingMissException;
use app\lib\exception\UserException;
use app\api\model\Setting as SettingModel;
use app\api\model\ExtendSetting as ExtendSettingModel;

class Setting extends BaseController
{
    public function getSetting(){
        (new IDMustBePositiveInt())->goCheck();
        $setting = SettingModel::getSetting($_POST['id']);
        if(!$setting){
            throw new SettingMissException();
        }
        return json($setting,200);
    }

    public function getExSetting(){
        (new IDMustBePositiveInt())->goCheck();
        $setting = ExtendSettingModel::getExSetting($_POST['id']);
        if(!$setting){
            throw new SettingMissException();
        }
        return json($setting,200);
    }
}