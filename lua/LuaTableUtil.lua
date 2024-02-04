--TableUtil类
-----------------------
TableUtil = {}
--newTable 需要操作的Table 默认为空
function TableUtil:new(newTable)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  --将newTable赋值给类变量_mTable
  o._mTable = newTable or {}
  return o
end
--putItem根据key增加键值对
function TableUtil:putItem(key,value)
  self._mTable[key] = value
  return self
end
--removeItem根据key删除键值对
function TableUtil:removeItem(key)
  self._mTable[key] = nil
  return self
end
--整理当前表
function TableUtil:sort()
  table.sort(self._mTable)
  return self
end
--获取表的长度
function TableUtil:getLength()
  local count = 0
  for _,_ in pairs(self._mTable) do
    count = count + 1
  end
  return count
end
--获取当前表 链式调用结束
function TableUtil:getTable()
  return self._mTable
end
--TableUtil类结束↑
