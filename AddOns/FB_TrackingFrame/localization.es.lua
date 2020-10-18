-- Spanish Translation by Winderfind (winderfind@gmail.com) Drakkari

FB_TFTranslations["esES"] = {
	NAME									= "Fishing Buddy - Pesta\195\177a de b\195\186squeda",
	DESCRIPTION								= "Recolecta informaci\195\179n sobre la pesca c\195\173clica.",

	-- Tab labels and tooltips
	TRACKING_INFO							= "#NAME#: Muestra informaci\195\179on sobre la pesca c\195\173clica.",
	TRACKING_TAB							= "Seguimiento",

	--aca irian los comandos, y claro, no se traducen

	TRACKINGFRAME							= "Pesta\195\177a de b\195\186squeda",
	TRACKINGFRAME_RIGHTCLICK				= "Click-Dcho para dibujar la gr\195\161fica del pez",
	TRACKINGFRAME_LEFTCLICK					= "Click-Izq para seleccionar el pez a buscar.",
--	TRACKINGFRAME_CLICKS					= "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
	TRACKINGFRAME_CLICKS					= "#TRACKINGFRAME_RIGHTCLICK#",

	TRACKFISHHOURLY							= "Buscar por hora este pez.",
	TRACKFISHWEEKLY							= "Buscar por semana este pez.",

	-- messages
	TRACKINGMSG								= "Segumiento de '%s' %s.",
	NOTRACKERRMSG							= "No puede borrarse la pesca c\195\173clica.",
	NOTRACKMSG								= "Pesca c\195\173clica borrada '%s'.",

	-- months for Tracking frame
	ABBREV_JANUARY							= "Ene",
	ABBREV_APRIL							= "Abr",
	ABBREV_JULY								= "Jul",
	ABBREV_OCTOBER							= "Oct",
	ABBREV_DECEMBER							= "Dic",
		
	CONFIG_TRACKHIDDEN_ONOFF				= "Ocultar b\195\186squeda",
	CONFIG_TRACKHIDDEN_INFO					= "Seguir rastreando el pescado incluso si no aparece en el gr\195\161fico.",

	BINDING_NAME_TOGGLEFISHINGBUDDY_TRK		= "Mantener el panel de b\195\186squeda de #NAME#.",
};

FB_TFTranslations["esMX"] = FB_TFTranslations["esES"];

FB_TFTranslations["esES"].TRACK_HELP = {
	"|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r or |c#GREEN##WEEKLY#|r] |c#PURPLE#<fish link>|r",
	"    buscar la cantidad de veces que se pesc\195\179 el pez seleccionado (link con Click-Izq).",
};

FB_TFTranslations["esMX"].TRACK_HELP = FB_TFTranslations["esES"].TRACK_HELP;

FB_TFTranslations["esES"].NOTRACK_HELP = {
	"|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
	"    eliminar el pez seleccionado (link con Click-Dcho) del Registro.",
};

FB_TFTranslations["esMX"].NOTRACK_HELP = FB_TFTranslations["esES"].NOTRACK_HELP;

