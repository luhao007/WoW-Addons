--[======[ File
Starts the Titan developer documention.
--]======]

--[======[ Titan Documentation Beginning

This document will introduce Titan essentials for a Titan developer. 
The intent is simplify what may appear to be a daunting experience. 

We suggest you grab your favorite beverage, read this doc, and relax! 
Many Titan mysteries will be explained. 🙂

The Titan team and its users are available to answer questions.
The two most used ways are : 
- The Titan Discord community
- Curse comments under Titan Panel addon

====== IDE Tools used:
For small changes to Titan, an editor with syntax highlighting and code folding features such as NotepadPlusPlus can be used.

For larger changes or ongoing maintenance an IDE is suggested.

This is the one used at the moment:
Visual Studio Code - https://code.visualstudio.com/

Additional IDE plugins are used for Lua and WoW API.

Lua Language Server (LLS) - https://marketplace.visualstudio.com/items?itemName=sumneko.lua
	https://github.com/LuaLS/lua-language-server
WoW API - LLS extension - https://marketplace.visualstudio.com/items?itemName=ketho.wow-api
	https://github.com/Ketho/vscode-wow-api

Other IDEs accept Lua Language Server, see if your prefered IDE will accept LLS.

Note: 
    - The WoW API plugin is geared to Retail. 
    There was no option to automatically include 'Classic' deprecated routines.
    - Diagnostic annotations are used to ignore some warnings. 
    Ignore warning annotations were limited as much as practical to 'this line' to point out usage of Classic routines.
    - Files or folders for the IDE such as .vscode; Titan.code-workspace; and others are included in the TItan release.

The file _TitanIDE.lua contains Titan specific IDE Intellisense definitions.
These defintions tell the IDE that we know what we are doing, often providing coding assistance.
It is NOT included in the TOC file.

====== Documentation blocks
These are created from annotations in the Lua files.

--[===[ File
Contains ...
--]===]
Each file has a terse description of its contents.

---API
These are routines Titan will keep stable.
Changes to these varibles and routines will be broadcast to developers via Discord at a minimum.

---Titan 
These are global routines Titan uses. These may change at any time per Titan needs and design.

--[===[ Var 
...
--]===]
These are critical tables and info used within Titan.
Unless specifically marked otherwise, treat these as "---Titan".

---local
These are local routines that may change at any time.
--]======]

--[======[ Titan Start editing

Before you start changing any code, it is HIGHLY recommended to install the following WoW addons:
- BugGrabber : Grabs errors and stores them
- BugSack : The visual part of BugGrabber
- WowLua : This allows you to try Lua code directly in WoW.

Small changes are recommended; then test your coding.
When testing, just start or reload WoW. All versions now check and load new files on reload.

Reload is /reload in game chat.

Regardless of tools used, please update any annotations and comments as changes are made!!!

====== Additional Help For You
A good Lua resource is https://www.lua.org/docs.html
NOTE: WoW uses Lua version 5.1 as its base.
NOTE: WoW does restrict, add, or even remove some Lua features. For example the file routines and many OS routines are not available to an addon.

There are sites that have deeper explanations about addon development, such as
- Wowhead.com
- Wiki wow wiki (Warcraft.Wiki.gg).
Please use these or other sites for more detailed addon and API information. 
The API information changes as Blizzard adds features, changes API methods, or any other reason.

====== Folder Structure
Inside the Titan folder you will notice :
- Artwork folder : Contains skins used by Titan
- libs : Library routines Titan uses
- A .toc file
- Many .lua files including this file
- An XML file : Containing Titan templates mainly for plugins
- This file


====== .toc
The site https://warcraft.wiki.gg/wiki/TOC_format contains more info than you will ever need on TOC format.

The folder and the .toc files MUST have the same name!
Sort of... the name prior to the underscore(_) must be the same as the folder name. 
The part after (postfix) has meaning to the WoW addon loader tells the loader the expansions the addon should be loaded for.

Titan uses at least one postfix value - _Vanilla - for Classic Era version to load Ammo and Regen for CE only.

====== .toc internals
Each .toc file begins with 'directives' which start with "##".

The ## Interface value should match the current interface value of the corresponding WoW version.
In BattleNet this is typically shown below the 'Play' button.
For example, DragonFlight 10.02.05 is represented without dots - 100207 - in the .toc.

If the interface value is higher or lower, WoW will complain that you are running 'out of date' addons.

The Interface value can be a list of WoW versions.

After the TOC directives, Titan lists the files in the order they are to be parsed.
This is important for Titan (or any addon) to load properly.

TitanGame.Lua specifies TITAN_ID used throughout Titan.

Then the Ace libraries. Note Titan does not use all the Ace libraries.
_Titan_Lib_Notes shows a running change history of the libraries.

Then all the localization files.

Then the Titan code files.

====== Artwork

WoW tends to use .tga image files.
Lookup TextureBase:SetTexture for current accepted image types.
NOTE: All versions of WoW may not accept all image types.

Most graphic art software can save to these formats. 
We don’t recommend using an online source to convert one image format to another. 
They have a tendency to add additional code or info to the image.
--]======]

--[======[ Titan Addon code flow

First step: ======= Starting WoW
Wow will load Titan along with other addons installed. The order addons are installed is not guaranteed!

The files listed in the TOC will will be loaded and run in the order listed.
Examples:
- TitanGlobal.lua sets up constants and variables used by Titan
- TitanTemplate.xml : Creates the Titan frame - TitanPanelBarButton - used to receive events.
- Titan.lua local variables and registering for some events such as ADDON_LOADED
- Creation of functions
- TitanLDB.lua creates LDBToTitan frame to handle LDB objects

ADDON_LOADED event is fired after every addon WoW loads.
When the ADDON_LOADED event for Titan is received:
- Titan registers for event PLAYER_ENTERING_WORLD
- Titan ensures its saved variables are whole and known player profiles are read.

NOTE: On ADDON_LOADED is the first time addon saved variables should be considered loaded and safe!!
Using addon saved variables before ADDON_LOADED is likely to result in nil(s).

NOTE: The addon saved vars are NOT the Titan plugin saved vars via the registry (.savedVariables)! 
The registry is processed later!

Next: ======= Waiting for WoW
WoW fires a bunch of events as this and other addons are loaded.
Eventually the game and all addons are loaded and PLAYER_ENTERING_WORLD event is sent

Next: ======= Entering world - PLAYER_ENTERING_WORLD (PEW) event
NOTE: This event is sent on both login and reload with a parameter to tell the difference.

When PLAYER_ENTERING_WORLD event is received via OnEvent, the real work begins.
There is NO guarantee PEW events are sent in any order across addons!
See 'Titan Relationship' section below.

The local routine - TitanPanel_PlayerEnteringWorld - is called using pcall.
This ensures Titan reacts to errors rather than leaving Titan, and possibly WoW, in a bad state.
TitanPanel_PlayerEnteringWorld does all the variable and profile setup for the character entering the world.

On login PLAYER_ENTERING_WORLD - not reload - Titan
- Sets character profiles - TitanVariables_InitTitanSettings
- Sets TitanPanel*Anchor for other addons to adjust for Titan
- Creates all Titan bars including right click menu and auto hide frames. See Frames below.
- Registers for events Titan - RegisterForEvents

On login and reload Titan
- Set THIS character profile () - TitanVariables_UseSettings - 
   See TitanVariables file for more details on saved variables; this is a simple concept but touchy to implement.
   The user chosen profile sets the user chosen plugin saved vars for both Titan and any plugins.
   TitanVariables_UseSettings uses
   - TitanPanel_InitPanelBarButton to set the bars the user wants.
   - TitanPanel_InitPanelButtons to set the plugins the user wants on the user selected bars.
- Update the Titan config tables for the config screens - TitanUpdateConfig
- Set Titan font and strata
- Register and set up any Titan plugins.
- Wrap any LDB plugins with a generated Titan plugin- TitanLDBRefreshButton

If the above was successful then all is good
If the above failed then 
- tell user something bad happened along with the error they can pass to the dev team
- attempt to hide all bars as cleanup
- nuke the Titan config tables as cleanup

--]======]

--[======[ Titan Panel relationship to Titan plugins and LDB
Titan plugins list Titan as a dependency. 
This ensures Titan is loaded before the plugin and the plugin has access to Titan routines and libs.
Because Titan registers plugins during PEW, this means Titan calls the plugin OnShow BEFORE the plugin gets its PEW.

A best practice we use in Titan plugins is wait until OnShow to set up resources and processing.
Then nicely shut down those resources and processing in OnHide.
This keeps Titan from using resources when the user is not using a plugin.

A side effect of PEW order and best practice is a Titan plugin gets OnShow before PEW.
In practice this is not harmful but it can be confusing if the plugin relies on PEW to initialize itself.

LDB objects are another source of Titan plugins. 
LDB objects are created by other addons using the LibDataBroker library.
These objects can be created at any point before or after Titan is up and ready.
Titan will wrap each LDB object in a generated Titan plugin so it can be displayed by Titan.
TitanLDB.lua contains more information.
--]======]

--[======[ Frames and Frame Scripts
Here we detour into XML. Titan uses XML only to declare virtual frames used throughout Titan.
Virtual frames can only be declared in XML.
They are frame templates used in the 'inherits' parameter of CreateFrame.
We find creating needed frames in Lua cleaner and less confusing.

TitanTemplate.xml contains the frame definitions used by Titan.
- TitanPanelBarButton : This "is" Titan in the sense that all events are attached to this frame.
- Titan_Bar__Display_Template : The template (Button) for a Titan bar.
- TitanPanelBarButtonHiderTemplate : The template (Button) paired to each full width Titan bar;
	Allows hiding and unhiding the paired Titan Bar.
- TitanPanelTooltip : This is used for plugin tool tips.

TitanBarData in TitanVariables.lua holds creation data for each bar.
TitanPanelButton_CreateBar in Titan.lua creates the full width bars and short bars by looping through TitanBarData.
TitanBarDataVars holds the Titan and user settings for each bar.
An initial setup / install uses TitanBarVarsDefaults.

The frame scripts (OnShow, etc) are how WoW and Titan interact with the plugin.

======= OnClick frame scripts - TitanPanelButton_OnClick default behavior :
-- Right click is to open the Titan menu.

-- Left click closes any tooltip and any menu.
Then looks for a control frame - frame with name of "TitanPanel" .. plugin_id .. "ControlFrame".
If a control frame exists, show it.
This is used by Volume and Clock to show sliders which are not possible in a menu.

======= OnDragStart and OnDragStop frame script :
On Short Bars Titan registers only to allow moving them (left mouse button). 
- OnDragStart and OnDragStop (left mouse button) for moving Short Bars

======= OnMouseWheel frame script :
On Short Bars Titan registers to size a Short Bar

======= OnShow frame script :
Not used by Titan bars.

======= OnHide frame script :
Not used by Titan bars.

======= OnEvent frame script :
Titan.lua sets the OnEvent stript for TitanPanelBarButton to redirect events to TitanPanelBarButton:<registered event> 
See local function RegisterForEvents for the list of eventsand their usage.

======= OnEnter frame script :
Used to show the plugin tooltip.
With the addition of 'secret' values in 12.0.0 (Midnight) Titan does not use the Blizzard GameTooltip.
Titan was blamed for 'secret' value access errors within and shortly after instances.

Also used by Titan Hider Bars to show the hidden Titan Bar.

======= OnHide frame script :
Used to hide the plugin tooltip.

Also used by Titan Hider Bars these are used to hide the Titan Bar.
--]======]

--[======[ Plugin .registry

====== Titan plugins
Plugins are the heart of Titan. They provide the information and features users want to see.
The routine - TitanUtils_RegisterPluginList - starts the plugin registry process.

See TitanBag.lua for a LOT more detail.

====== LDB objects : See LDBTitan.lua for many more details.
The OnEvent script of LDBToTitan frame processes the PLAYER_LOGIN event.
This starts the process to convert all known LDB objects into Titan plugins.

Note: PLAYER_LOGIN occurs at same time or very close to PLAYER_ENTERING_WORLD.
This event was chosen by the orignal developer.

Each object found calls TitanLDBCreateObject using pcall to protect Titan.

Before Titan is initialized (first PLAYER_ENTERING_WORLD) the LDB object will be added to the plugin list.
As part of the PEW event processing, TitanUtils_RegisterPluginList will be used iteratively on each found LDB object.
Most LDB objects are created on loading by addons. There may be an issue for addons that create many LDB objects on demand.
--]======]

--[======[ Saved Variables
WoW allows saved variables to be 'by account' or 'by character'.
'by account' is a little misleading - it is 'by account' per WoW version.
Retail and Classic Era are distinct and can not reference each other!


See TitanVariables.lua for additional detail.

NOTE: Titan routines have used 1 as true since inception so be careful on 'true checks'. 
As an example
if ShowUsedSlots then 
*should* work fine if ShowUsedSlots is true or 1

====== Where are these saved variables?????
The saved variables can be found here: .../World of Warcraft/_retail_/WTF/Account/<account name>/SavedVariables/Titan.lua
There is a Titan.lua.bak which is the prior save (logout / exit / reload).

NOTE : _retail_ is for Retail WoW. 
Classic and other WoW versions will have different folder names, such as _classic_era_, _beta_, _*ptr_, etc.

The saved variables are specified in the Titan toc :
## SavedVariables: TitanAll, TitanSettings, TitanSkins

This will cause WoW to create a file - Titan.lua - with a table for each saved variable entry.
Where "Titan" is the addon folder and .toc name.


TitanSettings contains all the plugin saved variables.
Titan uses the single table structure to store the saved variables across characters.
This makes the setup code rather cumbersome and not straight forward - just warning...

It is HIGHLY recommended opening the saved variables file in an 
editor that can handle large files and with code folding features! 

I have 20+ characters on one server. Even though I do not use many addons, my file is nearly 90,000 lines long!
A plugin such as Titan Panel [Reputation] can create 100+ plugins.

Say we want to find a character named Embic on Staghelm which you are using for testing.
This would under
TitanSettings = {
	["Players"] = {
		["Embic@Staghelm"] = {
			["Panel"] = {
				-- Holds all the Titan settings for this character
				}
			["BarVars"] = {
				-- Holds all the Titan bar settings for this character
				}
			["Plugins"] = {
				-- Each registered plugin will be here
					["Starter"] = { 
						["notes"] = "Adds bag and free slot information to Titan Panel.\n",
						["menuTextFunction"] = nil,
						["id"] = "Starter",
						["menuText"] = "Bag",
						["iconWidth"] = 16,
						["savedVariables"] = {
							["ShowColoredText"] = 1,
							["CustomLabel3Text"] = "",
							["ShowIcon"] = 1,
							["OpenBags"] = false,
							["CustomLabel3TextShow"] = false,
							["CustomLabelTextShow"] = false,
							["CustomLabel4Text"] = "",
							["CustomLabel2Text"] = "",
							["OpenBagsClassic"] = "new_install",
							["ShowLabelText"] = 1,
							["CustomLabel4TextShow"] = false,
							["CountProfBagSlots"] = false,
							["ShowUsedSlots"] = 1,
							["DisplayOnRightSide"] = false,
							["ShowDetailedInfo"] = false,
							["CustomLabel2TextShow"] = false,
							["CustomLabelText"] = "",
						},
						["controlVariables"] = {
							["DisplayOnRightSide"] = true,
							["ShowColoredText"] = true,
							["ShowIcon"] = true,
							["ShowLabelText"] = true,
						},
						["version"] = "1.0.0",
						["category"] = "Information",
						["buttonTextFunction"] = nil ,
						["tooltipTextFunction"] = nil ,
						["icon"] = "Interface\\AddOns\\TitanPlugin\\Artwork\\TitanStarter",
						["tooltipTitle"] = "Bags Info",
					},
				}
			["Adjust"] = {
				-- Holds offsets for frames the user may adjust - Retail and Classic have different list of frames
				}
			["Register"] = {
				-- Holds data as each plugin and LDB is attempted to be registered. 
				-- There may be helpful debug data here under your plugin name if the plugin is not shown as expected. 
				-- Titan > Configuration > Attempts shows some of this data, including errors.
				}
...
TitanAll = {
["OrderHall"] = true,
["TimerAdjust"] = 1,
["GlobalProfileUse"] = false,
["TimerPEW"] = 4,
["TooltipModiferAlt"] = false,
["TimerLDB"] = 2,
["TimerVehicle"] = 1,
["UseTooltipModifer"] = false,
["GlobalProfileName"] = "<>",
["Silenced"] = false,
["TooltipModiferCtrl"] = false,
["TooltipModiferShift"] = false,
["TimerDualSpec"] = 2,
["Registered"] = false,
}
TitanSkins = {
{
["titan"] = true,
["path"] = "Interface\\AddOns\\Titan\\Artwork\\",
["name"] = "Titan Default",
},
{
["titan"] = true,
["path"] = "Interface\\AddOns\\Titan\\Artwork\\Custom\\AllBlack Skin\\",
["name"] = "AllBlack",
},
...
}
--]======]
