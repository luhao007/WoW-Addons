# Delve Companion — agent context summary

## Purpose

Delve Companion is a World of Warcraft addon focused on Delves. It enhances the built-in Delves experience by adding a dedicated Delves tab to the Adventure Guide/Encounter Journal, extending the Delve Encounter UI, improving the Delves gossip flow, and tracking progress while a Delve is active.

The addon is intentionally lightweight and built directly on WoW APIs and Blizzard frame XML. It uses a small set of common community libraries only where necessary (LibStub, CallbackHandler, LibDataBroker, LibDBIcon).

---

## High-level architecture

The addon is organized around a central master table, `AddonTbl.DelveCompanion`, which exposes the main subsystems:

- `Logger` – lightweight logging helper.
- `Config` – static config, game IDs, Delve definitions, and saved-data defaults.
- `Variables` – runtime state such as Delve metadata, optional dependency availability, and frame references.
- `Definitions` – enums, event names, and shared constants.
- `AddonSettings` – account/character settings handling.
- `EJExtension` – integration with the Encounter Journal / Adventure Guide UI.
- `ProgressTracker` – scenario-based Delve lifecycle tracking.
- `InDelveWidget` – temporary frame shown during Delves.
- `GossipExtension` – auto-enter and Delves gossip enhancements.
- `MinimapIcon` – optional minimap access point.

Bootstrapping happens in two phases via `Source/Bootstrap.lua`:

1. `ADDON_LOADED` – initialize saved variables, optional dependencies, and preload UI frames.
2. `PLAYER_LOGIN` – initialize settings, minimap icon, progress tracker, in-delve widget, gossip extension, and refresh Delve metadata.

---

## Repository navigation

### Root
- [README.md](README.md) – short project description.
- [DelveCompanion_Mainline.toc](DelveCompanion_Mainline.toc) – addon manifest and load order.
- [.github/AGENTS.md](.github/AGENTS.md) – this file, agent-oriented repository summary.

### Data and configuration
- [Data/Config.lua](Data/Config.lua) – game IDs, currency IDs, Delve definitions, saved-data schema, and expansion-specific content.
- [Data/Definitions.lua](Data/Definitions.lua) – shared enums, dependency addon names, event identifiers, and layout constants.
- [Data/Variables.lua](Data/Variables.lua) – runtime state and feature flags.

### Core bootstrap and shared infrastructure
- [Source/Bootstrap.lua](Source/Bootstrap.lua) – addon startup, dependency detection, and initialization sequence.
- [Source/Core/Core.lua](Source/Core/Core.lua) – central runtime data logic for Delves (initialization and refresh of per-Delve state).
- [Source/Core/Logger.lua](Source/Core/Logger.lua) – logging utility.

### UI modules
- [Source/Modules/EJExtension](Source/Modules/EJExtension) – Encounter Journal integration.
  - Adds a custom Delves tab to the Adventure Guide / Encounter Journal.
  - Injects a dedicated Delves list frame and its expansion dropdown logic.
- [Source/Modules/EJExtension/DelveEncounter](Source/Modules/EJExtension/DelveEncounter) – enhancements for the built-in Delve Encounter window.
  - Exp bar, companion config panel, bountiful/consumables/gilded stash frame hooks, and loot-info controls.
- [Source/Modules/GossipExtension](Source/Modules/GossipExtension) – Delves gossip integration.
  - Detects Delves difficulty picker / tiered entrance UI, displays story status, and offers auto-enter automation.
- [Source/Modules/ProgressTracker](Source/Modules/ProgressTracker) – lifecycle tracking for active Delves.
  - Monitors scenario state, completion events, respawn events, and exit transitions.
  - Drives the In-Delve widget.
- [Source/Modules/TooltipExtension](Source/Modules/TooltipExtension) – tooltip post-processing for game items and currencies.

### Utility components
- [Source/Utility/CustomActionWidget.lua](Source/Utility/CustomActionWidget.lua) – generic widget used to render icons, item/currency/spell/achievement/toy data, and optional click behavior.
- [Source/Utility/WaypointTracker.lua](Source/Utility/WaypointTracker.lua) – waypoint setting support for SuperTrack, TomTom, and MapPinEnhanced.
- [Source/Utility/MinimapIcon.lua](Source/Utility/MinimapIcon.lua) – optional minimap entry point.
- [Source/Utility/SlashCmd.lua](Source/Utility/SlashCmd.lua) – slash command handling.
- [Source/Utility/LootInfo](Source/Utility/LootInfo) – reusable loot info frame shown from multiple UI surfaces.
- [Source/Utility/DelveOBotWidget.lua](Source/Utility/DelveOBotWidget.lua) – separate helper/widget component.
- [Source/Utility/ScrollUtilHelper.lua](Source/Utility/ScrollUtilHelper.lua) – scroll helper used by some UI frames.

### Settings and localization
- [Source/Settings](Source/Settings) – settings UI and saved-variable synchronization.
- [Locale](Locale) – localization files and XML registration.
- [Release Notes](Release Notes) – release notes and packaging helpers.

---

## Module breakdown

### 1) Delves List
Location: [Source/Modules/EJExtension/DelvesList](Source/Modules/EJExtension/DelvesList)

This is the addon’s core feature. It injects a custom Delves tab into the Encounter Journal / Adventure Guide and builds a dedicated Delves list UI. The module is responsible for:

- creating the custom tab button inside the Encounter Journal;
- populating the Delves list by expansion and map;
- wiring the expansion dropdown so the Delves list behaves like a first-class tab;
- preparing list elements for individual Delves.

Note: the info-frame implementation under [Source/Modules/EJExtension/DelvesList/InfoFrame](Source/Modules/EJExtension/DelvesList/InfoFrame) is currently unfinished and should be ignored for now.

Agent note: this is the primary integration point for Adventure Guide UI changes.

### 2) Delve Encounter
Location: [Source/Modules/EJExtension/DelveEncounter](Source/Modules/EJExtension/DelveEncounter)

This module hooks into the existing Delve Encounter window that Blizzard already provides and enriches it with addon-driven panels. It includes:

- an experience bar for the companion progression flow;
- a companion configuration panel for Delve companion-related details;
- UI panels for Bountiful reward info, consumables, and Gilded Stash data;
- a loot info button that opens a dedicated loot information frame.

Agent note: this is the place to look for UI extensions tied to the built-in Delve encounter view.

### 3) Gossip extension
Location: [Source/Modules/GossipExtension/GossipExtension.lua](Source/Modules/GossipExtension/GossipExtension.lua)

This module watches Delves-related gossip UI (`PLAYER_INTERACTION_MANAGER_FRAME_SHOW`) and enhances the Delves difficulty picker window. Its responsibilities include:

- identifying whether the current interaction is a Delve entrance;
- showing story status in the gossip flow when enabled;
- adding a loot-info button and auto-enter controls to the Delves UI;
- allowing the player to enable/disable delayed auto-enter and cancel it while the countdown runs.

Agent note: this module is tightly coupled with Blizzard’s Delves difficulty picker frame.

### 4) Progress Tracker
Location: [Source/Modules/ProgressTracker/ProgressTracker.lua](Source/Modules/ProgressTracker/ProgressTracker.lua)

This module tracks the lifecycle of a Delve session by reacting to scenario and zone events. It determines when:

- a Delve starts;
- the Delve is completed;
- a Delve is exited;
- a respawn is activated.

The tracked state is broadcast through `Definitions.Events.PROGRESS_TRACKER` so other components can react.

Agent note: if you need to add or change behavior tied to “in Delve” state, start here.

### 5) In-Delve Widget
Location: [Source/Modules/ProgressTracker/InDelveWidget](Source/Modules/ProgressTracker/InDelveWidget)

The In-Delve Widget is a separate UI frame shown while the player is inside a Delve. It is driven by the Progress Tracker and can be configured to appear on the left, right, or in a custom position. Its purpose is to present extra information or quick actions during the Delve session.

Agent note: this is mostly a presentation/UX module and depends strongly on the Progress Tracker state.

### 6) Utility components

#### CustomActionWidget
Location: [Source/Utility/CustomActionWidget.lua](Source/Utility/CustomActionWidget.lua)

A reusable UI widget that can display an icon for items, spells, currencies, achievements, or toys. It can optionally behave like a clickable button and can show a label, cooldown overlay, mask, or border.

#### WaypointTracker
Location: [Source/Utility/WaypointTracker.lua](Source/Utility/WaypointTracker.lua)

A small but important utility that sets waypoints to Delve entrances and POIs. It supports:

- Blizzard SuperTrack;
- TomTom; and
- MapPinEnhanced.

It uses Delve metadata from `Variables.delvesData` and the available POI information from the game API.

#### TooltipExtension
Location: [Source/Modules/TooltipExtension/TooltipExtension.lua](Source/Modules/TooltipExtension/TooltipExtension.lua)

A lightweight tooltip enhancement module. At the moment it mainly appends extra information to item tooltips (for example, Bounty Map-related data) via tooltip post-calls.

---

## Data model notes

The addon stores per-Delve runtime data in `Variables.delvesData` and populates it from the definitions in `Config.DELVES_CONFIG` during startup. Each Delve entry includes:

- the Delve’s map and POI IDs;
- whether it is currently Bountiful;
- the current story variant and completion status;
- related achievements and level gating for Nemesis Delves;
- optional coordinates for fallback waypoint generation.

This runtime table is the central source of truth for Delve list rendering, gossip decisions, and waypoint logic.

---

## Important implementation conventions for agents

- The addon is frame-based and XML-driven. Many UI components are created dynamically from XML templates and mixins.
- The central object is `DelveCompanion`, not a classic OOP hierarchy. Modules attach themselves to this table and use methods like `:Init()`, `:Refresh()`, and `:ProcessEvent()`.
- A lot of behavior is tied to events from Blizzard’s Delves UI rather than to custom event buses. Expect hooks around `EncounterJournal`, `DelvesDifficultyPickerFrame`, `JourneysFrame`, and scenario events.
- Settings are persisted via WoW SavedVariables and synced through `AddonSettings`.
- Optional dependency support is explicit: TomTom and MapPinEnhanced are detected at startup and used conditionally.

---

## Suggested starting points

If you are trying to understand or change behavior, the best entry points are:

1. [Source/Bootstrap.lua](Source/Bootstrap.lua) – startup and initialization order.
2. [Source/Modules/EJExtension/EJExtension.lua](Source/Modules/EJExtension/EJExtension.lua) – how the addon integrates with the Encounter Journal.
3. [Source/Modules/GossipExtension/GossipExtension.lua](Source/Modules/GossipExtension/GossipExtension.lua) – Delves gossip and auto-entry behavior.
4. [Source/Modules/ProgressTracker/ProgressTracker.lua](Source/Modules/ProgressTracker/ProgressTracker.lua) – state changes during a Delve run.
5. [Data/Config.lua](Data/Config.lua) – canonical Delve definitions and feature flags.
