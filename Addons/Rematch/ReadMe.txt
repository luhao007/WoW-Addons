Rematch is a pet journal alternative for managing pets and teams.

Features

- Save and load teams per target.
- Store unlimited teams in up to 12 user-defined tabs.
- Manage and automatically slot leveling pets with the Leveling Queue.
- Find counters with extended pet filters such as Strong Vs and Tough Vs.
- Search for abilities and text within abilities.
- Add notes to teams or pets as reminders or to find later with search.
- Send teams to other Rematch users or share with plain-text exported teams.
- Use integrated with the journal or in a minimizable standalone window.
- And much, much more!

How to use

Rematch initially replaces your default pet journal. You can switch back to the default journal anytime by unchecking the Rematch checkbox at the bottom of the journal.

A minimizable standalone window can be summoned a few ways:

- From a key binding defined in the default key binding interface.
- /rematch macro command.
- "Use Minimap Button" in options will create a minimap button.
- From its LDB button if you have a Broker infobar addon.

Tooltips explain many parts of the addon. Poke around and experiment! Check out the options. There are several views and a lot of features to the addon you can discover over time.

Teams

You can save an unlimited number of teams in up to 12 user-defined tabs.

- When saving a team, if you choose a target, Rematch will know what team to load when you interact with that target later.
- Teams that contain a target are named in white. Teams without a target are named in gold.
- In options you can choose to automatically load these team when you interact with their target, or to prompt instead for more control over when their teams load.
- The standard behavior of a team tab is to sort all teams alphabetically. You can rearrange the order of teams by right-clicking its tab and checking "Custom Sort". While checked, right-click teams within the tab to move them around.
- You can add notes to a team from its right-click menu. These notes can be used for strategies, for tagging purposes (search will include these notes) or any other information you want. Notes can be up to 4k in length.

Pets

To help make these teams, Rematch has expanded filter options, a TypeBar (opened by clicking the arrow next to the search box) for easily finding counters, and enhanced search ability.

If you open the TypeBar there are three tabs: Types, Strong Vs and Tough Vs:
- Types allows you to quickly filter to a specific type or group of types.
- Strong Vs will filter the list to pets that do increased damage to the chosen types. For instance choosing Magic will list all pets with attacks that are strong against Magic (all pets with Dragonkin attacks).
- Tough Vs will filter the list to pets that receive reduced damage to the chosen types. For instance choosing Magic will list all Mechanical pets.
- You can combine these to find double counters: For instance Chi-Chi, Hatchling of Chi-Ji is a flying pet with all elemental attacks. If you select Strong Vs Flying and Tough Vs Elemental you'll get a list of snails and other critters with magic attacks.

In the search box, you can not only search for the names of pets and their source, you can also search for:
- Abilities ("Call Lightning" will list all pets that have this ability.)
- Text within abilities ("Bleed" will list all pets that cause a target to Bleed or is affected by Bleeding.)
- Level ranges ("level=25" or "level>10" or "level=8-13" will display specific levels or a range of levels.)
- Stat ranges ("health>700" or "speed=250-350" or "power>276" are some examples.)

Also:
- Information about pets are found in a pet card that acts like a tooltip.
- Clicking a pet while viewing its card will lock the card in place so you can mouseover parts of the card for more details.
- While viewing a pet card, hold <Alt> to flip the card to its back for its lore and where the pet can be found. You can also mouseover the icons at the top of the card to flip it over.
- Like teams, pets can have notes attached to them from their right-click menu. You can use these notes for anything you want to remember about them, or for tagging purposes: add "#find" in notes for pets you want to find, and then search for "#find" to list all pets with this tag.

Leveling Queue

Rematch has a robust system for leveling pets with the leveling queue. The queue is a place to put all the pets you want to level.

- You can order the queue however you like, or let the addon sort the queue for you.
- To mark a slot for leveling pets, right-click one of the three loaded slots and choose "Put Leveling Pet Here".
- When a team is saved with these designated leveling slots, the slots will be filled by the top-most pets from the queue (or the most preferred, see below).
- You can also right-click a pet in the team list and choose "Put Leveling Pet Here" to convert a slot in an already-saved team into a leveing pet.
- When a pet reaches level 25 (gratz!) it will automatically leave the queue and the next leveling pet will take its place.
- In the Queue button menu, you can fill the queue with many pets at once. For instance: in the pet panel, filter pets to High Level (15-24) and Rare, then choose Fill Queue to add level 15-24 rares to the queue.
- For some opponents, just grabbing the top pet from the queue can kill your low level pets, or you want finer control over what pets load for a specific target. If you right-click a team that contains a leveling pet, you can click "Set Preferences" to choose various health and level ranges to refine which pet the queue will pick when a team loads.

Sharing Teams

Teams can be shared with friends directly in-game or through an export/import feature.

To share a team in-game with another Rematch user, right-click a team and choose Share->Send Team. A dialog will ask for a name, which can be either an online character or a battle.net friend. If it reports the team was succesfully sent, the recipient now has a popup with your team they can save.

You can also share teams by exporting them either in Plain Text or as a String from the same Share menu. If you paste this text or string elsewhere, someone else can import your team by copy and pasting it into the Import Teams dialog.

You can share with yourself too! If you don't regularly backup your SavedVariables and want an easy way to backup your teams, right-click a team tab and Export Tab. It will export the whole tab in string format. Paste this text in an email to yourself or in a text file someplace to keep a backup of your teams.

Other Addons

A major goal with Rematch is to make it behave well regardless of what other battle pet addons you're using.

- If you have one of the addons Battle Pet Breed ID, PetTracker Breeds (included with PetTracker), or LibPetBreedInfo-1.0, Remach will display the breed alongside each pet and a list of possible breeds on the pet card. Other breed-specific features become available too, like filtering and viewing potential stats as a 25 rare.
- If you have the addon Pet Battle Teams enabled, "Import From Pet Battle Teams" is added to the Teams button menu to copy all of your PBT teams to Rematch, repairing them if need be.
- If you choose to continue using PBT alongside Rematch (many do!), make sure you lock your PBT teams or auto save in PBT is disabled. The default behavior of PBT is to change the pets in your currently-selected team to whatever is loaded.
- If you have a Broker infobar addon or TitanPanel, it will create a button on your bars to toggle Rematch.
- If Rematch is hiding an addon you want to access on the default journal, remember to uncheck "Rematch" at the bottom of the journal. You can turn Rematch back on whenever you want, or use the standalone Rematch window and leave the default journal and other addons alone.

Future Plans

Long-time users will know that features get added (and occasionally removed!) over time. I'm always open to suggestions for new features, but with a careful scope to prevent the addon from becoming a bloated behemoth.

The scope of the addon is limited to features that would make sense in a pet journal or in the manipulation of teams. Rematch will stay out of battles and avoid features not related to pets or teams.

At the moment a new rewrite is happening for Rematch 5.0, though admittedly development will be slowed as I'll be playing Legion more than writing addons for it. UI-wise, this won't be nearly as dramatic a change as 3.x was to 4.x.

Goals with 5.0 include:
- Remove unnecessary fluff that's no longer relevant. Like the pullout "current leveling pet" slot and pullout loaded team bit are definitely going.
- "Flatten" the UI to make it more ammenable to skinning and reduce frame/texture use.
- Offload parts some users may never use to a load-on-demand module. This may include the collection stats, win records, import/export/sharing, script filters, the safari hat reminder thing, etc.
- Allow outside modules to add their own tabs and add their own stats to pet cards. Such as a separate module to track the battle success of all of your individual pets.
- Allow a single team to store multiple targets. So if you have one team you use for many tamers you don't need to save a copy for each tamer.
- A "team builder" mode that lets you build teams without actually owning the pets.
- No more sanctuary system. This may or may not require Rematch have its own breed module, but instead of recording stats it will attach only the breed with the teams and the leveling queue.
- And a very big goal, to make 5.0 have a smaller operational footprint than 4.5.  While I'm pleased overall with 4.x's size given all it can do, getting rid of fluff and offloading stuff to load-on-demand will produce a more compact and efficient addon.

In addition to the above, some other features loosely planned in a lower priority:
- Options to adjust max level preferences due to xp buffs/events.
- Supporting breeds on export/import.
- Multiple search terms at once.
- Allow multiple targets to be stored in a team.
- Understudy on pet card for loading an alternative pet if it's dead or injured.
- A method of choosing alternate teams if the saved team has dead or injured pets.

Localization

A big thanks to Aranesh Lothar-EU from wow-petguide.com for providing the German (deDE) translation!
Also to gaspy10 from curse.com for the Chinese (zhTW) translation!
And to Yonshuo from curse.com for the Simplified Chinese (zhCN) translation!

In Conclusion

There's a great deal more to Rematch. Play around with it and experiment. See if you can create new team combos that have never been tried before. Thanks for using it!

If you have any suggestions, feedback, bugs to report or anything else you'd like to share, feel free to leave a comment here.