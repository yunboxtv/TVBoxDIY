#!/bin/bash

#获取目录
CURRENT_DIR=$(cd $(dirname $0); pwd)
num=$(find $CURRENT_DIR -name gradlew  | awk -F"/" '{print NF-1}')
DIR=$(find $CURRENT_DIR -name gradlew  | cut -d \/ -f$num)
cd $CURRENT_DIR/$DIR

#签名
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " $CURRENT_DIR/$DIR/app/build.gradle
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/app/TVBoxOSC.jks
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/TVBoxOSC.jks
echo "" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_FILE=./TVBoxOSC.jks" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_ALIAS=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties


//设置界面修改

cp $CURRENT_DIR/DIY/ModelSettingFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
cp $CURRENT_DIR/DIY/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

//增加版本 更新说明
mv $CURRENT_DIR/DIY/VersionDialog.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/VersionDialog.java
mv $CURRENT_DIR/DIY/VersionDialog.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/VersionDialog.java
mv $CURRENT_DIR/DIY/dialog_version.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml
sed -i 's/6666/部分UI修改，播放器默认修改为EXO播放,增加外置播放器方式/g'   $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml

#播放界面修改
cp $CURRENT_DIR/DIY/player_vod_control_view.xml  $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
cp $CURRENT_DIR/DIY/VodController.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java
mv $CURRENT_DIR/DIY/shape_dialog_top_bg.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_top_bg.xml
mv $CURRENT_DIR/DIY/play_mobile_center_shape.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/play_mobile_center_shape.xml
#播放界面增加外部播放器
cp $CURRENT_DIR/DIY/PlayFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/PlayFragment.java

cp $CURRENT_DIR/DIY/PlayFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/PlayActivity.java

cp $CURRENT_DIR/DIY/PlayFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

cp $CURRENT_DIR/DIY/PlayFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java

//通用
cp $CURRENT_DIR/DIY/HawkConfig.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/HawkConfig.java

//播放界面修改
cp $CURRENT_DIR/DIY/PlayerHelper.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java

#图标修改
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-hdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xhdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxhdpi/app_icon.png
mv $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxxhdpi/app_icon.png




# 默认设置
cp $CURRENT_DIR/DIY/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java  

#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#背景修改
cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png

#首页排版边框
sed -i 's/vs_30/vs_15/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_select.xml

#增加听书嗅探
sed -i 's/|mp4|/|mp4|mp3|m4a|p2p|/'g $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/DefaultConfig.java

#修改进度条消失时间
sed -i 's/10000/6000/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#进度条颜色
sed -i 's/color_353744/color_1890FF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_player_control_vod_seek.xml

#名称修改
sed -i 's/TVBox/影视Box/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#版本号
sed -i 's/1.0.0/1.4.0/g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's/1.0.0/1.4.0/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.q/g' $CURRENT_DIR/$DIR/app/build.gradle

#添加PY支持
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O $CURRENT_DIR/$DIR/app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#@#\\#g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#pyramid#\\pyramid#g' $CURRENT_DIR/$DIR/app/build.gradle
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "#添加PY支持" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.undcover.freedom.pyramid.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.undcover.freedom.pyramid.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.chaquo.python.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.chaquo.python.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/PlayerHelper.init/a\        PythonLoader.getInstance().setApplication(this);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import android.util.Base64;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/import android.util.Base64;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/private void parseJson(String apiUrl, String jsonStr)/a\        PythonLoader.getInstance().setConfig(jsonStr);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Spider getCSP(SourceBean sourceBean)/a\        if (sourceBean.getApi().startsWith(\"py_\")) {\n        try {\n            return PythonLoader.getInstance().getSpider(sourceBean.getKey(), sourceBean.getExt());\n        } catch (Exception e) {\n            e.printStackTrace();\n            return new SpiderNull();\n        }\n    }' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Object\[\] proxyLoca/a\    try {\n        if(param.containsKey(\"api\")){\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"ck\"))\n                return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n            SourceBean sourceBean = ApiConfig.get().getSource(doStr);\n            return PythonLoader.getInstance().proxyLocal(sourceBean.getKey(),sourceBean.getExt(),param);\n        }else{\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"live\")) return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n        }\n    } catch (Exception e) {\n        e.printStackTrace();\n    }\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java


echo 'DIY end'
