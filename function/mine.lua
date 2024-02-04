require "imports"
require "lua.LuaDataBase"--导入自建数据库

--配置MDC_R主题
MDC_R=luajava.bindClass "com.google.android.material.R$style"
activity.setTheme(MDC_R.Theme_Material3_DynamicColors_Light)

--设置界面布局
activity.setContentView(loadlayout("layout.mine"))

--配置状态栏和导航栏颜色
setBarColor(0xFFF8F8F8,0xFFFFFFFF)

--尝试增大TextInputLayout圆角
local function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end
--圆角表
local corii={dp2px(12),dp2px(12),dp2px(12),dp2px(12)}
nickNameBox.setBoxCornerRadii(table.unpack(corii))
signBox.setBoxCornerRadii(table.unpack(corii))
dateBox.setBoxCornerRadii(table.unpack(corii))


--配置显示动画
ShowAnimation=TranslateAnimation(0,0,activity.height,0)
ShowAnimation.setDuration(600)--设置持续时间
ShowAnimation.setFillAfter(true)--设置填充时间
mainCard.startAnimation(ShowAnimation)--激活动画

--ID显示动画
task(650,function()
  userName.setVisibility(View.VISIBLE)--显示控件
end)


function setGender(num)
  --覆盖所有项目
  man.setStrokeColor(0xffF7F7F7)
  woman.setStrokeColor(0xffF7F7F7)
  other.setStrokeColor(0xffF7F7F7)
  --判断选择项目
  if num == 1 then
    --设置选择项目
    man.setStrokeColor(Color.parseColor("#333438"))
   elseif num == 0 then
    --设置选择项目
    woman.setStrokeColor(Color.parseColor("#333438"))
   else
    --设置选择项目
    other.setStrokeColor(Color.parseColor("#333438"))
  end
end


--利用数据库里面的信息配置布局内容
local iconContent,userNameContent,nickNameContent,signContent,genderContent,dateContent = getInformation()

--设置头像
Glide.with(activity).load(iconContent).into(icon)--配置图片到IageView

--设置昵称和签名
userName.setText(userNameContent)
nickName.setText(nickNameContent)
sign.setText(signContent)
date.setText(dateContent)

--设置性别
setGender(tointeger(genderContent))


--创建函数方便复用
function setStrokeColors(view)
  --覆盖所有项目
  man.setStrokeColor(0xffF7F7F7)
  woman.setStrokeColor(0xffF7F7F7)
  other.setStrokeColor(0xffF7F7F7)
  --设置选择项目
  view.setStrokeColor(Color.parseColor("#333438"))
end

--数据保存函数
function saveInformationDatas()
  --输入框内是否有文字
  if date.Text ~= nil and sign.Text ~= nil and nickName.Text ~= nil and userName.Text ~= nil and date.Text ~= "" and sign.Text ~= "" and nickName.Text ~= "" and userName.Text ~= "" then
    --判断信息是否有变动
    if userName.Text ~= userNameContent then
      --修改信息
      alterData("userName",userName.Text)
    end
    --判断信息是否有变动
    if nickName.Text ~= nickNameContent then
      --修改信息
      alterData("nickName",nickName.Text)
    end
    --判断信息是否有变动
    if sign.Text ~= signContent then
      --修改信息
      alterData("sign",sign.Text)
    end
    --判断信息是否有变动
    if genderContent ~= newGenderContent then
      --修改信息
      alterData("gender",newGenderContent)
    end
    --判断信息是否有变动
    if date.Text ~= dateContent then
      --修改信息
      alterData("date",date.Text)
    end
    --判断信息是否有变动
    if iconChange == true then
      --修改信息
      alterData("icon",iconPath)
     else
      --避免空值异常
      iconPath=iconContent
    end

    --引入Intent类
    local intent=luajava.newInstance("android.content.Intent")
    --将名为"delete"的extra信息添加到intent中
    intent.putExtra("icon",iconPath)
    intent.putExtra("nickName",nickName.Text)
    intent.putExtra("sign",sign.Text)
    --通过Activity的setResult方法
    --第一个参数为结果码设为
    --第二个参数为带有extra的intent
    activity.setResult(1,intent)--来设置Activity的返回数据

    makeToast("保存成功")

    activity.finish()
   else
    makeToast("输入框里面什么都没有 这很奇怪")
  end
end


saveButton.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    --保存信息
    saveInformationDatas()
  end
})

imgButton.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    intent= Intent(Intent.ACTION_PICK)
    intent.setType("image/*")--设置文件类型
    this.startActivityForResult(intent,1)--激活intent
  end
})

--图片选择回调
function onActivityResult(requestCode,resultCode,intent)
  --判断返回数据
  if intent then
    local cursor =activity.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
    cursor.moveToFirst()
    local MediaStore = luajava.bindClass "android.provider.MediaStore"
    local Images = luajava.bindClass "android.provider.MediaStore$Images"
    local ImageColumns = luajava.bindClass "android.provider.MediaStore$Images$ImageColumns"
    local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
    local fileSrc = cursor.getString(idx)
    --储存新的图片地址
    iconPath = fileSrc
    --更新状态
    iconChange = true
    --更新布局图片
    Glide.with(activity).load(iconPath).into(icon)--配置图片到IageView
   else
    makeToast("未选择图片")
  end
end


man.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    --刷新布局
    setStrokeColors(view)
    --这里放你的操作
    newGenderContent = 1
  end
})

woman.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    --刷新布局
    setStrokeColors(view)
    --这里放你的操作
    newGenderContent = 0
  end
})

other.setOnClickListener(View.OnClickListener
{
  onClick=function(view)
    --刷新布局
    setStrokeColors(view)
    --这里放你的操作
    newGenderContent = 3
  end
})

波纹函数(saveTitle,0xffffffff)


local value=0
--配置按键监听
function onKeyDown(key)
  --判断按键
  if key==4 then
    --判断信息是否有变动
    if userName.Text ~= userNameContent or nickName.Text ~= nickNameContent or sign.Text ~= signContent or genderContent ~= newGenderContent or date.Text ~= dateContent or iconChange == true then
      if value+2 > tonumber(os.time()) then
        --结束活动
        activity.finish()
       else
        --提示信息
        local anchor=activity.findViewById(android.R.id.content)
        local mSnackbar=Snackbar.make(anchor, "您的修改并未保存，是否保存？ ", Snackbar.LENGTH_LONG)
        mSnackbar.setAction("保存", View.OnClickListener{
          onClick=function(v)
            saveInformationDatas()
          end
        })
        --mSnackbar.setActionTextColor(0xFFFFFFFF)--修改按钮颜色
        mSnackbar.show()
        --更新参数
        value=tonumber(os.time())
      end
     else
      if value+2 > tonumber(os.time()) then
        --结束活动
        activity.finish()
       else
        --提示信息
        makeToast('再按一次返回键退出')
        --更新参数
        value=tonumber(os.time())
      end
    end
    return true
  end
end

