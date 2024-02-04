require "imports"
require "lua.LuaTableUtil"


--配置函数获取信息
function getInformation()
  --导入cjson库
  local cjson=require("cjson")
  --获取应用对应Android/data目录
  local ExternalFilesDir=activity.getExternalFilesDir(nil).toString()
  --配置数据储存目录
  local FilesDir=ExternalFilesDir.."/information.conf"
  --判断数据储存目录内是否存有对应数据库文件
  if File(FilesDir).exists()==false then
    local DataTable=cjson.encode(TableUtil:new():sort():getTable())
    io.open(FilesDir,"w"):write(DataTable):close()
    local cjson=require("cjson")
    local DataTable=
    cjson.encode(TableUtil:new()
    :putItem("icon",activity.getLuaDir("img/aR.png"))
    :putItem("userName","ID-941314520")
    :putItem("nickName","喵喵喵")
    :putItem("sign","此人从未留下签名")
    :putItem("gender",1)
    :putItem("date","2077-12-31")
    :sort():getTable())
    --初始化数据
    io.open(FilesDir,"w"):write(DataTable):close()
    --初始化避免空值
    local icon,userName,nickName,sign,gender,date = activity.getLuaDir("img/aR.png"),"ID-941314520","喵喵喵","此人从未留下签名",1,"2077-12-31"
    --返回数据
    return icon,userName,nickName,sign,gender,date
   else
    --有 获取数据库内容
    local DataTable=cjson.decode(io.open(FilesDir,"r"):read())
    --依据key读取表内相应数据
    local icon,userName,nickName,sign,gender,date =DataTable["icon"],DataTable["userName"],DataTable["nickName"],DataTable["sign"],tointeger(DataTable["gender"]),DataTable["date"]
    --返回数据
    return icon,userName,nickName,sign,gender,date
  end
end

--依据key修改对应数据库相应数据
function alterData(key,value)
  --导入cjson库
  local cjson=require("cjson")
  --获取应用对应Android/data目录
  local ExternalFilesDir=activity.getExternalFilesDir(nil).toString()
  --配置数据储存目录
  local FilesDir=ExternalFilesDir.."/information.conf"
  --判断数据储存目录内是否存有对应数据库文件
  if File(FilesDir).exists()==true then
    --有 获取数据库内容
    local DataTable=cjson.decode(tostring(io.open(FilesDir):read("*a")))
    --依据key修改表内相应数据
    DataTable[key]=value
    --储存新的表 更新数据库
    io.open(FilesDir,"w+"):write(cjson.encode(DataTable)):close()
    --修改成功 弹出提示信息
    --Toast.makeText(activity,"修改成功",Toast.LENGTH_SHORT).show()
   else
    --没有 弹出提示信息
    --Toast.makeText(activity,"数据库「"..BaseName.."」不存在",Toast.LENGTH_SHORT).show()
  end
end

--初始化信息
getInformation()--配置函数获取信息



