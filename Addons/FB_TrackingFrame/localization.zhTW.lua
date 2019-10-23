-- default to American English

FB_TFTranslations["zhTW"] = {
   NAME = "釣魚助手-追蹤框",
   DESCRIPTION = "收集迴游魚類資料",

   -- Tab labels and tooltips
   TRACKING_INFO = "顯示迴游魚類資料",
   TRACKING_TAB = "追蹤框",

-- 參數,別動.
   TRACK = "track",
   NOTRACK = "notrack",
   TRACKING = "tracking",
   UNKNOWN = "unknown",
   WEEKLY = "weekly",
   HOURLY = "hourly",
   
-- 參數,別動.

   TRACKINGFRAME = "追蹤框",
   TRACKINGFRAME_RIGHTCLICK = "點右鍵對魚種繪製紀錄圖",
   TRACKINGFRAME_LEFTCLICK = "點左鍵選擇追蹤魚種",
-- TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
   TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#",

   TRACKFISHHOURLY = "以小時為單位追蹤這種魚",
   TRACKFISHWEEKLY = "以週為單位追蹤這種魚",

   -- messages
   TRACKINGMSG = "正在追蹤 '%s' %s.",
   NOTRACKERRMSG = "不能移除預設的迴游魚類",
   NOTRACKMSG = "迴游魚類 '%s' 已移除",

   -- months for Tracking frame
   ABBREV_JANUARY = "一月",
   ABBREV_APRIL = "四月",
   ABBREV_JULY = "七月",
   ABBREV_OCTOBER = "十月",
   ABBREV_DECEMBER = "年終",
   
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "切換至 #NAME# ",
};

FB_TFTranslations["zhTW"].TRACKING_HELP = {
      "|c#GREEN#/fb #TRACKING#|r",
      "    不是很容易看得懂的捕獲時段紀錄圖...Orz",
};

FB_TFTranslations["zhTW"].TRACK_HELP = {
      "|c#GREEN#/fb #TRACK#|r [ |c#GREEN##HOURLY#|r or |c#GREEN##WEEKLY#|r ]  |c#PURPLE#<fish link>|r",
      "    追蹤特定魚種的捕獲時間(按shift＋滑鼠鍵連結)",
};

FB_TFTranslations["zhTW"].NOTRACK_HELP = {
      "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
      "    從追蹤表上移除特定魚種(按shift＋滑鼠鍵連結) ",
};
