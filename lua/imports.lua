require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

import "java.io.File"
import "com.bumptech.glide.Glide"
import "android.graphics.Typeface"
import "android.graphics.Color"
import "android.animation.LayoutTransition"
import "android.view.animation.TranslateAnimation"
import "android.provider.MediaStore"
import "android.content.Intent"

import "androidx.viewpager.widget.ViewPager"
import "androidx.core.widget.NestedScrollView"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "androidx.cardview.widget.CardView"

import "github.daisukiKaffuChino.AdapterCreator"
import "github.daisukiKaffuChino.LuaCustRecyclerAdapter"
import "github.daisukiKaffuChino.LuaCustRecyclerHolder"

import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.textview.MaterialTextView"
import "com.google.android.material.appbar.MaterialToolbar"
import "com.google.android.material.shape.ShapeAppearanceModel"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.google.android.material.snackbar.Snackbar"
import "com.google.android.material.dialog.MaterialAlertDialogBuilder"



--隐藏顶栏
this.supportActionBar.hide()

--设置主题
activity.setTheme(R.style.AppTheme)

--配置MDC_R主题
MDC_R=luajava.bindClass "com.google.android.material.R$style"
--activity.setTheme(MDC_R.Theme_Material3_DynamicColors_Light)

--定义状态栏和导航栏颜色函数
----------------------
function setBarColor(colors1,colors2)
  local window = activity.getWindow()
  window.setStatusBarColor(colors1)
  window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
  window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
  window.setNavigationBarColor(colors2)
end

--配置ShapeAppearanceModel函数
function makeShapeAppearanceModel(topLeft,topRight,bottomLeft,bottomRight)
  local function dp2px(dp)
    return math.floor(dp*activity.resources.displayMetrics.density+0.5)
  end
  return ShapeAppearanceModel.builder()
  .setTopLeftCornerSize(dp2px(topLeft))
  .setTopRightCornerSize(dp2px(topRight))
  .setBottomLeftCornerSize(dp2px(bottomLeft))
  .setBottomRightCornerSize(dp2px(bottomRight))
  .build()
end

--重写ViewPager控件
function MyViewPager()
  return luajava.override(ViewPager,{
    onInterceptTouchEvent=function(super,event)
      return false
    end,
    onTouchEvent=function(super,event)
      return false
    end
  })
end

--波纹函数
function 波纹函数(id,颜色)
  import "android.content.res.ColorStateList"
  local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  ripple=typedArray.getResourceId(0,0)
  Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色})))
end

--配置状态栏和导航栏颜色
setBarColor(0xFFFFFFFF,0xFFF8F8F8)

function makeSnack(content,condition)
  local Snackbar = luajava.bindClass "com.google.android.material.snackbar.Snackbar"
  local anchor=activity.findViewById(android.R.id.content)
  if condition ==true then
    Snackbar.make(anchor, tostring(content), Snackbar.LENGTH_LONG).show()
   else
    Snackbar.make(anchor, tostring(content), Snackbar.LENGTH_SHORT).show()
  end
end

--弹出Toast消息提示
function makeToast(content,condition)
  local Toast = luajava.bindClass "android.widget.Toast"
  if condition ==true then
    Toast.makeText(activity,tostring(content),Toast.LENGTH_LONG).show()
   else
    Toast.makeText(activity,tostring(content),Toast.LENGTH_SHORT).show()
  end
end
