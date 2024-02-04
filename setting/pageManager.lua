require "imports"

--设置数据表
local data_main={}
--设置适配器
adapter=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #data_main
  end,
  getItemViewType=function(position)
    return data_main[position+1].mtype
  end,
  onCreateViewHolder=function(parent,viewType)
    --判断布局样式类型
    switch viewType
     case 0
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_0",views))
      holder.view.setTag(views)
      return holder
     case 1
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_1",views))
      holder.view.setTag(views)
      return holder
     case 2
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_2",views))
      holder.view.setTag(views)
      return holder
    end
  end,
  onBindViewHolder=function(holder,position)
    local view=holder.view.getTag()
    local viewType=data_main[position+1].mtype

    --设置文本内容
    if viewType ~= 0 then
      --设置标题内容
      view.title.setText(data_main[position+1].title)--配置数据到适配器
      --设置内容
      view.content.setText(data_main[position+1].content)--配置数据到适配器
    end

    --配置函数
    local function getImgpath(path)
      if path:find'http' then
        return path
       else
        return activity.getLuaDir(path)
      end
    end

    --设置图片
    if viewType == 1 then
      --过滤本地图片
      local img1 = getImgpath(data_main[position+1].icon1)
      local img2 = getImgpath(data_main[position+1].icon2)
      --设置到布局
      Glide.with(activity).load(img1).into(view.icon1)--配置图片到IageView
      Glide.with(activity).load(img2).into(view.icon2)--配置图片到IageView
    end




  end
}))

Recycler_main.setAdapter(adapter).setLayoutManager(StaggeredGridLayoutManager(2,StaggeredGridLayoutManager.VERTICAL))


--延迟执行
task(50,function()
  --添加数据
  table.insert(data_main,{mtype=2,title="这是标题",content="这个世界苦不堪言"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=2,title="这是标题",content="这个世界苦不堪言"})
  table.insert(data_main,{mtype=2,title="这是标题",content="这个世界苦不堪言"})

  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})
  table.insert(data_main,{mtype=1,title="这是标题",content="Forum Exchange",icon1="icon/icon_1.png",icon2="icon/icon_2.png"})

  --添加空白项目
  for i=1, 2 do
    table.insert(data_main,{mtype=0})
  end

  --通知适配器更新
  adapter.notifyDataSetChanged()
end)


--设置数据表
local data_tools={}
--设置适配器
adapter_tools=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #data_tools
  end,
  getItemViewType=function(position)
    return data_tools[position+1].mtype
  end,
  onCreateViewHolder=function(parent,viewType)
    --判断布局样式类型
    switch viewType
     case 0
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_0",views))
      holder.view.setTag(views)
      return holder
     case 1
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_3",views))
      holder.view.setTag(views)
      return holder
     case 2
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout("layout.items.item_4",views))
      holder.view.setTag(views)
      return holder
    end
  end,
  onBindViewHolder=function(holder,position)
    local view=holder.view.getTag()
    local viewType=data_tools[position+1].mtype

    --设置文本内容
    if viewType ~= 0 then
      --设置标题内容
      view.title.setText(data_tools[position+1].title)--配置数据到适配器
      --设置内容
      view.content.setText(data_tools[position+1].content)--配置数据到适配器
    end

    --配置函数
    local function getImgpath(path)
      if path:find'http' then
        return path
       else
        return activity.getLuaDir(path)
      end
    end

    --设置图片
    if viewType == 1 or viewType == 2 then
      --过滤本地图片
      local img = getImgpath(data_tools[position+1].icon)
      --设置到布局
      Glide.with(activity).load(img).into(view.icon)--配置图片到IageView
      --设置颜色
      view.main.cardBackgroundColor=data_tools[position+1].colors--卡片颜色
    end




  end
}))

Recycler_tools.setAdapter(adapter_tools).setLayoutManager(StaggeredGridLayoutManager(2,StaggeredGridLayoutManager.VERTICAL))

--延迟执行
task(50,function()
  --添加项目
  table.insert(data_tools,{mtype=1,title="这是标题",content="Forum Exchange",icon="img/SQ.png",colors=0xFF8869EB})
  table.insert(data_tools,{mtype=2,title="这是标题",content="Forum Exchange",icon="icon/icon_2.png",colors=0xFFFC9598})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Mass Function",icon="img/Cz.png",colors=0xFF1C9CFF})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Forum Exchange",icon="img/yT.png",colors=0xFF000000})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Forum Exchange",icon="img/Ys.png",colors=0xFFFF666B})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Mass Function",icon="img/iy.png",colors=0xFFFEAF4A})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Forum Exchange",icon="img/yT.png",colors=0xFF00D6C4})
  table.insert(data_tools,{mtype=1,title="这是标题",content="Mass Function",icon="img/iz.png",colors=0xFF9D94FD})

  --添加空白项目
  for i=1, 2 do
    table.insert(data_tools,{mtype=0})
  end

  --通知适配器更新
  adapter_tools.notifyDataSetChanged()

end)

--页面管理器
pagev.setOnPageChangeListener(ViewPager.OnPageChangeListener
{
  onPageSelected=function(v)
    if v==0 then
      --配置状态栏和导航栏颜色
      setBarColor(0xFFFFFFFF,0x0F000000)
      --设置隐藏显示控件
      Title_page1.setVisibility(View.VISIBLE)--显示控件
      Title_page2.setVisibility(View.GONE)--隐藏控件
      Title_page3.setVisibility(View.GONE)--隐藏控件
      Title_page4.setVisibility(View.GONE)--隐藏控件
    end
    if v==1 then
      --配置状态栏和导航栏颜色
      setBarColor(0xFFFFFFFF,0x0F000000)
      --设置隐藏显示控件
      Title_page1.setVisibility(View.GONE)--隐藏控件
      Title_page2.setVisibility(View.VISIBLE)--显示控件
      Title_page3.setVisibility(View.GONE)--隐藏控件
      Title_page4.setVisibility(View.GONE)--隐藏控件
    end
    if v==2 then
      --配置状态栏和导航栏颜色
      setBarColor(0xFFFFFFFF,0x0F000000)
      --设置隐藏显示控件
      Title_page1.setVisibility(View.GONE)--隐藏控件
      Title_page2.setVisibility(View.GONE)--隐藏控件
      Title_page3.setVisibility(View.VISIBLE)--显示控件
      Title_page4.setVisibility(View.GONE)--隐藏控件
    end
    if v==3 then
      --配置状态栏和导航栏颜色
      setBarColor(0xFFF8F8F8,0x0F000000)
      --设置隐藏显示控件
      Title_page1.setVisibility(View.GONE)--隐藏控件
      Title_page2.setVisibility(View.GONE)--隐藏控件
      Title_page3.setVisibility(View.GONE)--隐藏控件
      Title_page4.setVisibility(View.VISIBLE)--显示控件
    end
  end;

  onPageScrolled=function(index,offset,ratio)
    if ratio==0 then
      if index==0 then
        Image_page1.setColorFilter(Color.parseColor("#FFFFFF"))
        Image_page2.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page3.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page4.setColorFilter(Color.parseColor("#9B9E9B"))

       elseif index==1 then
        Image_page1.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page2.setColorFilter(Color.parseColor("#FFFFFF"))
        Image_page3.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page4.setColorFilter(Color.parseColor("#9B9E9B"))

       elseif index==2 then
        Image_page1.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page2.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page3.setColorFilter(Color.parseColor("#FFFFFF"))
        Image_page4.setColorFilter(Color.parseColor("#9B9E9B"))

       elseif index==3 then
        Image_page1.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page2.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page3.setColorFilter(Color.parseColor("#9B9E9B"))
        Image_page4.setColorFilter(Color.parseColor("#FFFFFF"))

      end
    end
  end
})


