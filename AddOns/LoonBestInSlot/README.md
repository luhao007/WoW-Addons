# LoonBestInSlot (Midnight Retail Edition)

A community fork of [LoonBestInSlot](https://www.curseforge.com/wow/addons/loon-best-in-slot) by loonnn_, rebuilt for **WoW Retail, Midnight Season 1**.

The original addon was made for MoP Remix / Classic and hasn't been updated for Retail. I liked it so much I wanted it for Midnight, so here it is, fully updated with current gear data and a fresh coat of paint.

---

## Features

- **All 13 classes, all 40 specs**, including Devourer Demon Hunter
- **530+ items** with accurate item level tooltips
- **Upgrade Track selector**: switch between Champion, Hero, and Great Vault tiers to see how your gear scales
- **Modern dropdown menus** that match the current WoW UI style
- **Tooltip integration**: hover over any item anywhere in-game to see which specs it's BIS for

## Tabs

- **Items**: full BIS gear list filterable by slot, source, and zone
- **Gems**: BIS gems per spec
- **Enchants**: BIS enchants per spec
- **Embellishments**: BIS crafted gear and embellishment pairings per spec

## Filtering

- Filter by **Slot** (Head, Chest, Trinket, etc.)
- Filter by **Source** (Drop, Raid, Crafted)
- Filter by **Zone**: all 8 M+ dungeons and 3 raids

## Supported Dungeons & Raids

**Mythic+ Dungeons:** Skyreach, Pit of Saron, Seat of the Triumvirate, Algeth'ar Academy, Windrunner Spire, Magisters' Terrace, Nexus-Point Xenas, Maisara Caverns

**Raids:** The Voidspire, The Dreamrift, March on Quel'Danas

---

## Slash Commands

`/lbis`: Open the BIS browser
`/lbis minimap`: Toggle minimap button

---

## Data Sources & Credits

- **Original Addon:** [LoonBestInSlot](https://www.curseforge.com/wow/addons/loon-best-in-slot) by loonnn_. All credit for the original addon design and framework.
- **BIS Data:** [Archon](https://www.archon.gg) via PeaversBestInSlotData
- **Embellishment Data:** [Wowhead](https://www.wowhead.com)

---

## Changelog

### v1.0.8
- Added 10 new items from the latest data update, with slots verified against in-game data.
- Corrected several mislabeled items (thanks Brandeth!):
  - Shadow of the Empyrean Requiem: now correctly shown as a Trinket
  - World Tender's Barkclasp: now correctly shown as Crafted (Leatherworking)
  - Primal Sentry's Cinch: now correctly shown as a Tier / Catalyst piece
  - Hara'ti Defender's Belt: now correctly shown as a Reputation reward
- Corrected the source label on 26 tier set pieces that were showing as raid or dungeon drops. They now correctly show as Tier / Catalyst items.
- Fixed item slot labels across all class guides for non-English clients (could previously cause display or sorting issues).

### v1.0.7
Localization overhaul. The addon now works correctly on non-English clients.

- Items tab now populates correctly on non-English clients (German verified).
- Class colors restored in the spec dropdown on non-English clients.
- Dungeon, raid, and boss names now display in your client's language.
- Added translations for source-type words (Raid, Crafted, Enchanting, Jewelcrafting, and more).
- Fixed a Lua error that could appear on non-English clients.
- Fixed a tooltip issue affecting Druid specs on non-English clients.
- Settings carried over from older versions are now corrected automatically on load.
- Added a `/bis debug` command for troubleshooting.

### v1.0.2
- Added 6 new items from the data update.

### v1.0.0 (Initial CurseForge Release)
- Full port from Classic to Retail Midnight
- 530+ items with correct item level display across all upgrade tracks
- Upgrade Track selector (Champion / Hero / Great Vault)
- Updated UI to match modern WoW style
- New Embellishments tab
- Tooltip BIS overlay on all items in-game
- Source color coding (orange = Raid, blue = Crafted, purple = Drop)
- Proper boss and dungeon names for all item sources
