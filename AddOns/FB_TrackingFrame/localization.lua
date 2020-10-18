-- default to American English

FB_TFTranslations = {};
FB_TFTranslations["enUS"] = {
   NAME = "Fishing Buddy - Tracking Frame",
   DESCRIPTION = "Collect data about cycle fish.",

   -- Tab labels and tooltips
   TRACKING_INFO = "Show #NAME# cycle fish information",
   TRACKING_TAB = "Tracking",

   FILTER_TAB = "Filter",

   TRACK = "track",
   NOTRACK = "notrack",
   TRACKING = "tracking",

   TRACKINGFRAME = "Tracking Frame",
   TRACKINGFRAME_RIGHTCLICK = "Right-click to draw graphs for fish",
   TRACKINGFRAME_LEFTCLICK = "Left-click to choose fish to track",
-- TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
   TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#",

   TRACKFISHHOURLY = "Track this fish hourly",
   TRACKFISHWEEKLY = "Track this fish weekly",

   -- messages
   TRACKINGMSG = "Tracking '%s' %s.",
   NOTRACKERRMSG = "Can't remove default cycle fish.",
   NOTRACKMSG = "Removed cycle fish '%s'.",

   -- months for Tracking frame
   ABBREV_JANUARY = "Jan",
   ABBREV_APRIL = "Apr",
   ABBREV_JULY = "Jul",
   ABBREV_OCTOBER = "Oct",
   ABBREV_DECEMBER = "Dec",

   TOOLTIP_HOURLY = "Track this fish by hour when set",
   TOOLTIP_WEEKLY = "Track this fish by week when set",

   CONFIG_TRACKHIDDEN_ONOFF = "Track hidden",
   CONFIG_TRACKHIDDEN_INFO = "Continue tracking fish even if they're not displayed on the graph",

   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "Toggle #NAME# Tracking Pane",
};

FB_TFTranslations["enUS"].TRACKING_HELP = {
      "|c#GREEN#/fb #TRACKING#|r",
      "    a really bad display of when tracked fish were caught",
};

FB_TFTranslations["enUS"].TRACK_HELP = {
      "|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r or |c#GREEN##WEEKLY#|r] |c#PURPLE#<fish link>|r",
      "    track the catch times for the specified fish (a shift click link)",
};

FB_TFTranslations["enUS"].NOTRACK_HELP = {
      "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
      "    remove the specified fish (a shift click link) from the tracker",
};
