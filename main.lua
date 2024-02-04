require "imports"

--Source：氚-Tritium 2957148920
--OpenSource:Apache License Version

--[[

Version 2.0, January 2004
http://www.apache.org/licenses/
TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions."License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document."Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License."Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity."You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License."Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files."Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types."Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below)."Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof."Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution.""Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:You must give any other recipients of the Work or Derivative Works a copy of this License; andYou must cause any modified files to carry prominent notices stating that You changed the files; andYou must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form

--]]


--一个简洁美观的布局 限制性开源
--老习惯 写完一个就开源


--配置设置字体样式函数
function setTypefaces(id,fileName)
  --导入类
  local File = luajava.bindClass "java.io.File"
  local Typeface = luajava.bindClass "android.graphics.Typeface"
  --通过getLuaDir()获取绝对路径
  local path = activity.getLuaDir("font/"..fileName..".ttf")
  --设置字体样式
  id.setTypeface(Typeface.createFromFile(File(path)))
end

--设置界面布局
activity.setContentView(loadlayout("layout.layout"))

--导入页面管理器
require "setting.pageManager"--包含很多东西
--导入自建数据库
require "lua.LuaDataBase"

--利用数据库里面的信息配置布局内容
local iconContent,userNameContent,nickNameContent,signContent,genderContent,dateContent = getInformation()

--设置头像
Glide.with(activity).load(iconContent).into(icon_main)--配置图片到IageView
Glide.with(activity).load(iconContent).into(icon_about)--配置图片到IageView

--设置昵称和签名
nickName.setText(nickNameContent)
sign.setText(signContent)

--设置副标题
subtitle_1.setText("何以解忧，唯唯有抱抱你，"..nickNameContent)

--回调事件
function onActivityResult(requestCode,resultCode,intent)
  if intent then
    --刷新数据
    if resultCode==1 then
      local pathstr=intent.getStringExtra("icon");
      local namestr=intent.getStringExtra("nickName");
      local signstr=intent.getStringExtra("sign");

      --设置头像
      Glide.with(activity).load(pathstr).into(icon_main)--配置图片到IageView
      Glide.with(activity).load(pathstr).into(icon_about)--配置图片到IageView

      --设置昵称和签名
      nickName.setText(namestr)
      sign.setText(signstr)

    end
  end
end

--调用函数设置样式

--创建一个二维表 储存信息
local TypefaceTable={
  {id=title_1,font="font2"},
  {id=title_2,font="font2"},
  {id=title_3,font="font2"},
  {id=title_4,font="font2"},
  {id=announcementTitle,font="font2"},
  {id=morningContent,font="font2"},
  {id=mineTitle,font="font2"},
  {id=notificationTitle,font="font2"},
  {id=settingTitle,font="font2"}
}

--ipairs解析并配置样式
for index,data in ipairs(TypefaceTable)
  --解析数据
  local TextId = data.id
  local fontFile = data.font
  --调用配置函数
  setTypefaces(TextId,fontFile)
end

--调用函数设置样式（效率不高 貌似也没区别
--setTypefaces(title_1,"font2")
--setTypefaces(title_2,"font2")
--setTypefaces(title_3,"font2")
--setTypefaces(title_4,"font2")



--创建一张点击时间表

title_1.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

subtitle_1.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

TextCard.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})


TextButton.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

announcementCard.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})





searchCard.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})




icon_about.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

nickName.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

sign.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

web.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

style.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

communicate.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

about.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

mine.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    activity.newActivity("function/mine")
  end
})

notification.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})

setting.setOnClickListener(View.OnClickListener
{
  onClick=function(view)

  end
})
