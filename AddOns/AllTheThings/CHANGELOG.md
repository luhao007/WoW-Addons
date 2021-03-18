# AllTheThings

## [Shadowlands-2.2.9](https://github.com/DFortun81/AllTheThings/tree/Shadowlands-2.2.9) (2021-03-14)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/2.2.8...Shadowlands-2.2.9) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- some ashran + formatting updates  
- Kyrian quest fixes/cleanup  
- Sylvanas' Strongbox coords added, description updated. Another sourceQuest added for Gahrron's Withering Cauldron  
- updated to the right profession-id instead of item id :)  
- added missing quest in highmountain for leatherworking  
- A few Argus treasure coordinate additions/tweaks for pin-point accuracy  
- fixed a typo  
- added new kul tiran version of 'fear no evil' in northshire  
    updated some colors with more accurate codes  
- Various minor fixes  
- Various maps & quest provider updates  
- finished bound shadehound secret  
- Some more localized deDE object names  
- update zhCN (#724)  
- Added missing providers and alphabetized a few Tirigarde quests  
- Greatly improved mount collection performance  
- Applied proper modID to the Relinquished-only Cloaks  
- hqt  
- Fixed showing 'Failed to acquire information. This quest...." on various Item tooltips  
- Adjusted search priority for links to be: ItemID+ModID > ItemID > SourceID this way anything referencing the ItemID of an Item which has a Source will still show properly on that Item's tooltip  
- Redesigned some in-game Source haresvting logic for better performance and accuracy  
    Changed Hammer of Expertise to not be collectible rather than ignoring its SourceID  
    Reverted temp modID changes on some SL craftable cosmetic items  
    SourceID Harvest  
- Modified Profession list logic to only pull in Things which are considered 'Collectible' (at the time of being opened) (fixes #722)  
- Removed listing of Pet Charms under a general category  
    Added class-tagging for Revendreth Zone Boots since the BoP component will only drop for the respective class  
    Adjusted 'Collectible As Cost' logic to prevent showing Items which are under 'saved' Things (fixes #723)  
- started working on bound shadehound (commented for now)  
    just pushing to minimize localization collisions later  
- missing bastion treasure + localization for it and other objects w/ the same name  
- added desire's battle gargon  
- Fixed lost newline  
- Fixed Netherstorm coord oops  
- Unlocalized some strings for better diagnostic by contribs  
- Updated all Netherstorm quests/achievements to modern formatting so they look like the other Outland zones.  
- Ru localization (#721)  
- zeep zop  
- Eye of Command horde version marked obtainable.  The Horrors of Pollution changed to modern format.  
- Marked Bruce mount as unobtainable  
- final tahonta update  
- done with 'squirrels' crs  
- more 'squirrels' crs, moves some hqts to get rid of 'unsorted' crate of battlefield goods  
- class filters for venthyr mirror network cloaks  
    more 'to all the squirrels' crs  
- meep morp  
- #errors, some 'to all the squirrels' crs  
    a couple missing gladiator's sanctum quests for the draenor garrisons  
- started adding 'to all the squirrels' achievements  
    only crs added to crit for earlier ones since they're in an absurd amount of zones.  added actual crit to zones for later achieves, will add crs to those in a later commit  
    corrected description for courage based on new information that it only requires a group of 5, not 9  
- added courage's npcID to crs  
- fix (possibly temp) for some sl cosmetic items  
- Added Brightscale Hatchling to Queen's Conservatory Cache  
- Courage quest id added  
- Marked Courage as obtainable and added to Bastion rare section. Added note for Lost Featherling.  
- Removed modID from Thaumaturge Vashreen (fixes #719)  
    Removed a bunch of search logic concerning modIDs which should be having no effect at this point in the addon  
- Violet Dredwing Pup added to Queen's Conservatory Cache  
- Legion DK Class Hall HQTs  
- Adjusted some collectiblity logic for Appearances and CollectibleByCost (fixes #720)  
- 2 ember court 'best friend' quests  
- update zhCN (#716)  
- Fixed sourceQuest for Whitebark's Memory  
