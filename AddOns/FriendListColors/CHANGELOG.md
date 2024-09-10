# FriendListColors

## [v11.0.2.240908](https://github.com/Vladinator/wow-addon-friendlistcolors/tree/v11.0.2.240908) (2024-09-08)
[Full Changelog](https://github.com/Vladinator/wow-addon-friendlistcolors/commits/v11.0.2.240908) [Previous Releases](https://github.com/Vladinator/wow-addon-friendlistcolors/releases)

- TOC bump.  
- TOC bump  
- - TOC bump.  
    - Added support for `timerunner` (the season ID) and `timerunnerIcon` variables.  
    - Fixed minor bug in 11 with settings panel.  
- Merge branch 'master' of https://github.com/Vladinator/wow-addon-friendlistcolors  
- - TOC bump.  
    - Added support for `timerunner` (the season ID) and `timerunnerIcon` variables.  
- - TOC bump.  
    - Added support for `timerunner` (the season ID) and `timerunnerIcon` variables.  
- Update release.yml  
- Preparation for 11.0  
- Added TOC files for the other clients.  
- TOC bump for 10.1  
- Remember to update the TOC  
- Merge branch 'master' of github.com:Vladinator89/wow-addon-friendlistcolors  
- Updated for 10.0.0  
- Update README.md  
- TOC bump.  
- - Added hint to press Enter to save when editing.  
    - When editing, we backup the format and if we don't save we restore it back to how it was originally.  
    - Storing empty format will reset it back to how it was before the user started editing.  
- Added back the backdrop on the edit box for the sake of clarity.  
- Replaced the hook style from replacing `SetText` to hooking it and only setting the text when applicable, without recursion.  
- Code rewrite for better legacy and future support (#2)  
    * First rewrite  
    * Added old UI, will need some rework  
    * Fixed ref issue  
    * Finalize settings code  
    * Class color fix and avoided old collision by alias  
    * Don't override if the colors already are defined.  
    * - Finalized alias system and didn't add name=characterName for legacy support.  
    - Added `~=` syntax example and updated the variables used.  
    * TOC version bump  
- TOC bump  
- Removed debug print.  
- DF support  
- Added back Classic support so the addon works with both clients.  
- Improved alias replacement handling in messages, but needs more BNet work to get that working properly. Also need to look at the popup notifications containing the BNet names.  
- Added new tags to readme file.  
- Forgot to bump the version before releasing this update.  
- - Adjusted some of the friends data for SL so we shouldn't show the wrong information at the wrong places anymore.  
    - Added inverse logic blocks like `[if~=noteText]Person has no note text[/if]` and the contents would only show if `noteText` tag was empty.  
    - Added the tag `battleTagName` that only shows the first part of the battle tag so "Ola#1234" becomes "Ola".  
    - Added limited support for `race` for your character friends, it's not originally a variable from the API, but figured I could try add it in case someone was missing that information.  
- Correct TOC bump for SL pre-patch.  
- Cleaned up deprecated file.  
- Create release.yml  
- Added deprecated API handling to avoid errors.  
- BfA and Shadowlands support.  
- TOC bump  
- Just to be super safe, ignore the travis file by name.  
- TOC bump and WoWInterface automatic packaging.  
- Added back Classic support along with the 8.2.5 changes.  
- Patch 8.2.5 changed the friend list so this patch accommodates for that change and makes the addon functional again.  
- TOC bump.  
- Fixed an issue with deprecated API missing in the later patches. This fix solves issues both on Classic and Retail.  
- TOC bump  
- Replaced the friend list info deprecated API with the new one that also works on Classic.  
- Fallback the class color logic if a class name is provided as color value.  
- Updated for BfA.  
- Patch 7.2 update.  
- Moved alias extracting code to a more natural location.  
- - TOC bump and fixed issue with RealID/Bnet friends. The editbox should now properly insert the custom nick note.  
- - Corrected the .pkgmeta entry.  
    - Drafting a way to alter the name with the alias name where ever it is used by the UI.  
- Updated the readme file. Added the ignored toon related variables for BNet friends on the options screen.  
- Cleaned up TOC  
- Initial Legion commit. Recoded the entire addon. Has backwards compatibility for Warlords of Draenor, despite it appearing as "Out of date"  
- Fixed issue with patterns not matching properly.  
- Updated libraries.  
- License change. Get in touch with me if you wish to discuss.  
- Fixed an error.  
