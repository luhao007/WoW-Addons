# Changelog

## 2.0.6 - 2026-03-21

### Fixed
- Fixed Hunt Table module disable wiring so HuntScanner now honors module state at runtime. When the Hunt module is disabled, HuntScanner now hard-stops noisy event subscriptions, snapshot queueing, refresh/cache passes, and panel rendering instead of continuing to process hunt events through the separate scanner event frame.
- Fixed Bar/Sounds independence in active polling gates. Core polling now remains available for sound-driven prey stage updates when Sounds is enabled, even if Bar is disabled; polling is forced off only when both Bar and sound runtime are disabled.

## 2.0.5 - 2026-03-21

### Performance
- Ported core prey polling to V2-style stage gating: `OnUpdate` is now enabled only while hot prey context exists (quest bootstrap, kill-carry window, ambush alert window, quest-listen burst, edit-mode preview, force-show, or active in-zone prey tracking) and is detached when idle.
- Reduced idle event overhead by making noisy prey-context checks lazy in `Preydator.lua` so non-widget events do not perform unnecessary quest-cache/time probes.
- Reduced Hunt Table event overhead by memoizing per-event hunt-context evaluation in `HuntScanner` so expensive context checks are only computed when a branch needs them.

### Fixed
- Fixed Warband totals row changing when collapsing a realm group. Grand totals now always sum from the filtered character source rows (all shown characters) rather than from post-collapse display rows, so collapse/expand only affects visibility and not totals.
- Fixed Lock/Unlock Bar behavior so toggling lock state from settings immediately refreshes bar interaction state (mouse/drag) without waiting for a later display update.
- Fixed Profiles tab actions by wiring a full profile runtime API (switch/create/delete/reset/copy) to live settings state.

### Changed
- Moved profile management out of `Preydator.lua` monolith into dedicated module `Modules/ProfileManager.lua`, and wired profile loading at addon startup through the new profile system.
- Simplified Profiles page settings logic to rely on module-backed profile APIs directly (removed legacy unavailable-API fallback scaffolding).

## 2.0.4 - 2026-03-20

### Fixed
- Fixed `attempt to compare a secret number value (tainted by 'Preydator')` crash in `LayoutFrame.lua` triggered when hovering AreaPOI tooltips on the world map while a prey quest was active. Root cause: `C_UIWidgetManager.GetAllWidgetsBySetID()` was called with secret-number set IDs returned by `GetTopCenterWidgetSetID()`, `GetObjectiveTrackerWidgetSetID()`, etc., tainting the returned widget table fields (`widgetType`, `widgetID`). Those tainted values then propagated into Blizzard's `DefaultWidgetLayout` comparison in `LayoutFrame.lua`. Fixed by wrapping all three `GetAllWidgetsBySetID` call sites and `widget.widgetType`/`widget.widgetID` field reads in `pcall`, and coercing `widgetID` through `tonumber()` before passing it back to any Blizzard API.
- Fixed locale difficulty detection in Hunt Table parsing so non-English clients no longer collapse hunts into Normal. `ParseDifficulty` now checks localized difficulty strings (`L["Normal"]`, `L["Hard"]`, `L["Nightmare"]`) in addition to English substrings while still returning canonical internal keys (`normal`/`hard`/`nightmare`) for stable sorting and caching. Added locale entries across non-enUS files (with AI-translation notes for native-speaker verification) and confirmed deDE mappings (`Schwer`, `Alptraum`). (Credit: gz2k2)

## 2.0.3 - 2026-03-20

### Changed
- `/pd inspect` output now includes the addon version number (`addon=x.y.z`) alongside the inspect schema version, making it immediately clear from a screenshot whether a player is on the latest release.
- Sound dropdowns now include a `None` option for each stage and Ambush so players can mute specific alerts directly from settings without disabling all sounds. (Credit: SirNorek)

### Fixed
- Dropdown popup menus now scale correctly on 4K / high-DPI monitors. `UIDropDownMenuTemplate` popup lists (`DropDownList1`) are parented to UIParent and do not automatically inherit the effective scale of the Settings panel; on 4K where UI scale is low (≈0.64), popups appeared too small and misaligned. Fixed by hooking `ToggleDropDownMenu` to normalize dropdown list scale to the effective scale ratio of the opening frame on every open event. (Credit: npi6666)
- HuntScanner reward probing now avoids raw arithmetic/coercion on protected Blizzard quest reward values, preventing `MoneyFrame_Update` secret-number taint when hovering world-map quest rewards.
- Core/Currency/Debug inspect paths now use protected numeric/string coercion for Blizzard API payload fields to reduce secret-value taint spillover outside HuntScanner-specific reward probes.
- Fixed a core dropdown localization regression (`attempt to index global 'L'`) by routing the `None` sound option label through `_G.PreydatorL` in `Preydator.lua`.
- Hardened bar position persistence so backup coordinates are only synced on explicit position changes (drag/save/reset), preventing generic apply/refresh paths from rewriting cached coordinates and causing post-reset/reload jumps.
- Backup restore now only repairs missing/invalid bar point data and no longer overwrites valid saved coordinates during load.
- Bar position clamping during login/world-enter no longer modifies saved coordinates; clamp is applied only to the live frame placement, preventing login-time screen metrics from reducing valid saved Y coordinates (e.g., 472 → 362). Position reapplies on `PLAYER_ENTERING_WORLD` to settle final UI dimensions.
- Panels tab spacing was increased in Currency/Warband sections to remove tight stacking/overlap, including a targeted +8px downward offset for `Show Quest Reward Icons`.

## 2.0.2 - 2026-03-20

### Fixed
- Bar drag position now persists reliably across reloads. Added resilient backup sync for saved bar coordinates and load-time restoration so position no longer snaps back to default `y=472` after moving.
- Corrected bar position restore order on load so backup coordinates are restored before normalization and not overwritten during startup.
- **Critical:** Bar visibility broken for non-enUS clients due to localization-dependent difficulty keys in hunted rewards and counts caching.
  - Root cause: `ParseDifficulty` was returning localized strings (`L["Normal"]`, `L["Hard"]`, `L["Nightmare"]`) which were then used as dictionary keys in persisted `difficultyRewardCache`, `questDifficultyByID`, and snapshot `mapDifficultyCounts`.
  - When players switched client locales or used addon with different locale clients, cached data keys became invalid because localization strings differ by language (enUS `"Normal"` vs deDE varies, etc.).
  - Solution: Changed `ParseDifficulty` to return canonical non-localized names (`"normal"`, `"hard"`, `"nightmare"`) for all internal data structures;  added `GetDifficultyDisplayName()` for UI display purposes; implemented `MigrateDifficultyKeysFromLocalizedToCanonical()` to convert existing persisted data on load.
  - Data flow now: WoW API → `ParseDifficulty` (canonical) → stored/cached (canonical) → migrated on load (canonical old → canonical new) → `GetDifficultyDisplayName` for UI display (localized labels).
- HuntScanner no longer queues or processes hunt-table snapshot work while the player is inside restricted instance content (`party`, `raid`, `scenario`, `delve`, `pvp`, `arena`).
- Ambush chat scanning now requires a fresh live prey quest match and refreshes zone state before evaluating prey-zone ambush logic, preventing stale prey state from firing inside delves or after prey context has ended.
- Hunt Table difficulty sorting now uses canonical difficulty rank instead of alphabetic string order, so ordering is consistently `N/H/Ni` (least to most) rather than locale/text-dependent variants.
- Currency and Warband windows now use stronger opacity and explicit frame layering so overlap does not visually blend the two panels into one block.

### Changed
- Ambush sound alerts now use a 45-second cooldown between plays to prevent rapid repeat firing from clustered ambush chat events.
- Stage-4 click navigation now prefers super-tracking the active prey quest (default-icon style behavior) and only falls back to user map waypoint pinning when quest super-track APIs are unavailable.
- Bar defaults updated: default position now uses `x=0` and `y=472`, and the bar is locked by default again.
- Hunt Table group headers now order difficulty groups hardest-first (`Nightmare > Hard > Normal`) when grouped by difficulty.
- Edit Mode window now anchors to the right side of Blizzard HUD Edit Mode with the same offset values.

### Fixed
- Warband Prey Track (`N/H/Ni`) now uses account-shared availability propagation with level gating, so updates captured on one character are reflected across all characters.
- Weekly reset fallback now reinitializes prey availability correctly by level: `78-89 => 4/-/-`, `90+ => 4/4/-` (or `4/4/4` once Nightmare has been permanently unlocked on the account).
- Added permanent saved unlock behavior for Nightmare in currency DB fallback logic; once unlocked, post-reset level-90 snapshots keep Nightmare availability enabled.

### Changed
- Corrected the fallback Warband prey model so live availability remains per-character, while only Nightmare unlock is shared account-wide.

## 2.0.1 - 2026-03-20

### Changed
- Module inspect output now includes instance/map diagnostics (`inInstance`, `instanceType`, `playerMapType`) and prey-zone cache diagnostics (`preyZoneMapID`, `preyZoneName`, `zoneCacheDirty`) for easier screenshot-based troubleshooting.
- Module inspect output removed the center-dot diagnostic row to keep reports focused on live visibility/state issues.
- Shared slider helpers were centralized in `Preydator.API` (`Clamp`, `RoundToStep`, `NormalizeSliderValue`) and consumed by `Settings` and `EditMode` to reduce helper drift.

### Fixed
- `Only show in prey zone` visibility now correctly hides the bar whenever `inPreyZone == false`, including fallback paths where a prey zone map ID is unavailable.
- Delve/instance bar gating was hardened with a restricted-instance check plus dungeon map-type fallback, preventing bar visibility in restricted instance content while preserving Edit Mode preview.
- Zone transition recovery was improved to prevent stale out-of-zone state after Delve exit:
  - registered `PLAYER_ENTERING_WORLD` for zone cache invalidation,
  - added periodic retry refresh while `inPreyZone == false`,
  - forced hierarchy rebuild on stale retry checks.
- HuntScanner snapshot/caching paths were hardened against protected Blizzard values by switching quest-ID numeric coercion to safe conversion helpers.

### Cleanup
- Removed unused `CurrencyTracker` local `OpenColorPicker` helper.
- Removed stale `HuntScanner` compatibility branch referencing `ZoneGateV2` (non-present module path in this repo).

## 2.0.0 - 2026-03-19

### Added
- Introduced module runtime controls for `Bar`, `Sounds`, `Currency`, `Hunt Table`, and `Warband` with reload-aware settings UX.
- Added module-aware settings gating across top-strip controls, Sounds page, Panels page sections, Currency matrix controls, and Theme controls.
- Added quest-focused inspect diagnostics (`/pd inspectquest`, `/pd inspectquestbug`, `/pd inspectquestboth`) with BugSack-compatible payload output.

### Changed
- Updated one-time splash/version gate to `2.0.0` and refreshed release messaging.
- First-load guidance now explicitly states the bar starts unlocked and should be locked in Options after positioning.
- Updated release metadata/version touchpoints (`Preydator.toc`, build script default, README, CurseForge description).

### Fixed
- Bar module gating now correctly preserves disabled state (removed false-to-true coercion paths) and enforces disabled behavior at runtime.
- Sounds module disable now blocks stage/ambush playback at core sound entry path (`TryPlaySound`).
- Currency and Warband module disable now force-close windows, prevent reopen toggles, and stop live refresh/update paths when disabled.
- Zone detection fallback for prey quests now uses quest log `isOnMap` when task-zone map IDs are unavailable.

### Performance
- Reduced unnecessary prey zone recomputation by caching zone status and refreshing only on relevant zone/quest transitions.
- Kept module-disabled refresh routes short-circuited to avoid avoidable UI and currency update work.

## 1.7.4 - 2026-03-19

### Changed
- New installs now default to an unlocked Preydator bar (`locked = false`) for easier first-time positioning.
- Added inspect shorthand support: `/pd inspect bs` now routes inspect output to BugSack mode.

### Fixed
- Fixed multiple runtime regressions from stale bar/options references after internal UI state refactor (`barFrame`/`barFill`/options category references), resolving repeated nil-index errors in live updates and settings refresh flows.
- Fixed Advanced settings reset actions to target live anchor settings:
  - `Reset Bar Position` now resets `point` anchor/x/y.
  - `Reset Tracker Positions` now resets tracker point tables and hunt panel side/anchor settings.

### Performance
- Reduced idle CPU churn by tightening prey update/event gates:
  - Removed redundant CurrencyTracker quest-log polling path and kept currency refresh event-driven.
  - Suppressed noisy widget/module fanout when there is no prey context.
  - Added strict ambush scan gating to active prey + in-zone + pre-stage-4 only.
  - Added out-of-zone fast-path handling to skip expensive widget/objective scans while a prey quest is active but player is outside prey zone.
  - Added one-attempt stage sound guard to prevent repeated failed stage-4 sound retry loops after reload.

## 1.7.3 - 2026-03-15

### Fixed
- Fixed a CurrencyTracker Lua scoping regression where `ToggleWarbandWindow()` could call `EnsureWarbandWindow` before its local function declaration was in scope, causing `attempt to call global 'EnsureWarbandWindow' (a nil value)` when opening Warband from settings.
- Fixed HuntScanner callback spam outside real Hunt Table usage by tightening context detection, cancelling queued follow-up passes when the panel closes, and ignoring passive widget/quest churn unless Hunt Table context, mission frame, or explicit preview is active.
- Fixed HuntScanner reward-cache invalidation flow by moving prey-completion cache clearing to an explicit hook from `Preydator.lua`, so accepted prey quests no longer rely on broad background scan churn to clear stale hunt rewards.
- Hardened HuntDebug snapshot/report formatting against protected Blizzard strings so debug payload generation no longer trips secret-string conversion failures in restricted contexts.

## 1.7.2 - 2026-03-15

### Changed
- Removed dead gossip-path code from HuntScanner: `GatherGossipQuests`, `IsLikelyPreyTitle`, all legacy gossip/quest-greeting API locals, and the gossip-based fallback rows in `BuildQuestRows`. Hunt data is sourced exclusively from adventure map pins; gossip scanning was a holdover from earlier implementation attempts and called taint-prone secure APIs on every scan pass.
- `IsHuntTableContext` now only checks target NPC ID, interaction type 3, and the Hunt Table controller spell ID option — no gossip quest title scanning.
- Removed `QUEST_ACCEPTED` event registration from HuntScanner (unused after pin-based system).

## 1.7.1 - 2026-03-15

### Fixed
- HuntScanner no longer fires gossip/quest scan passes inside battlegrounds, arenas, dungeons, raids, or delves, eliminating repeated "snapshot error: attempt to perform string conversion on a secret string value" spam caused by Blizzard taint in restricted instances.

## 1.7.0 - 2026-03-15

### Added
- Added an alt-aware prey progress chart in Currency settings (`Prey Track (Alts)`) showing character, zone, and rank snapshot data.
- Added prey snapshot persistence per character to SavedVariables so alt progress remains visible between sessions and reloads.
- Added a Hunt Table companion panel that appears during hunt-table interactions and lists available prey quests with reward summaries while preserving Blizzard's default quest/model panel.
- Added General-tab controls for Hunt Table tracking and side placement (`Left` / `Right`).
- Added dedicated `Hunt Table` and `Warband` settings tabs to begin separating hunt and warband controls from broad general settings.
- Added troubleshooting slash command `/pd huntdebug` to print captured hunt-table payload details (available quests, active quests, options, NPC/spell context).
- Expanded Hunt Table diagnostics to capture modern interaction-manager and quest-detail API paths, plus recent event traces, to support non-gossip hunt-table flows.
- Hunt Table capture now supports observed alternate NPC context (`246231`) and performs short delayed re-scan passes after interaction events to catch fast-populated quest payloads before UI close.

### Changed
- Mapped the new alt prey progress tracking work into the roadmap Epic 3 direction (weekly/prey progress visibility).
- Hunt Table tracker now uses Blizzard Adventure Map quest pins as the primary hunt source and warms per-quest reward data asynchronously from the quest-choice dialog, with retry-safe timeouts for empty payloads.
- Hunt reward warming now samples one representative quest per difficulty (plus active quests) to reduce visible quest-choice dialog flicker during cache warm-up.
- Hunt reward lines now include reward icons and normalize numeric experience rewards to include `XP` text.
- `/pd huntdebug bs` now uses BugGrabber APIs directly when available and no longer routes through error-handler paths that attach large local-variable dumps.
- Improved `/pd huntdebug bs` compatibility by trying multiple BugGrabber/BugSack call styles and auto-opening BugSack when a payload is delivered.
- Hunt panel quest rows are now clickable and open the corresponding Blizzard quest dialog on the adventure map.
- Hunt reward cache now persists in SavedVariables, refreshes on the first login of each day by invalidating stale entries, and reuses shared difficulty rewards when quests return after abandon.
- Completing prey stage 4 now invalidates cached rewards for that difficulty so the next Hunt Table visit refills updated rewards.
- Hunt Table actions are blocked while a prey quest is active, and row-level `Accept` now uses a hidden non-zoom dialog flow to avoid leaving the adventure map stuck on a zone zoom.
- Reward hydration now waits for fuller quest-choice reward widget population before committing cache, preventing premature XP-only snapshots; reward icon extraction also supports additional widget field variants.
- Advanced Debug now includes a `Refresh Hunt Cache` action, and Hunt settings includes direct cache/table refresh controls wired to `HuntScanner` refresh APIs.
- Hunt reward extraction now falls back to item-based fields (`itemID` / `itemLink`) for name/icon/count resolution, improving capture of chest/cache rewards that omit direct reward text fields.
- Currency settings have been decoupled from Warband controls: Warband toggles/grouping/layout controls no longer live on the Currencies page.
- Warband now has a dedicated option to show/hide `Prey Track (Alts)` directly inside the Warband window instead of the Currencies tab.
- Hunt Table warm-up now samples one representative quest per difficulty again, and Hunt settings now include grouping/sorting controls (`Group Hunts By`, `Sort Hunts By`) for zone/difficulty/title organization.
- Fixed HuntScanner reward API errors by passing the required `isChoice` argument to `C_QuestLog.GetQuestRewardCurrencyInfo`, eliminating repeated snapshot error spam.
- Clicking an already-open Hunt Table quest row now closes the quest details and attempts to reset zoom, improving map navigation UX.
- Hunt panel now supports settings for width, height, scale, font size, and side-anchor vertical alignment (`Top`, `Middle`, `Bottom`).
- Hunt grouped headers (zone/difficulty) are now collapsible directly from the Hunt panel.
- Warband tab now uses an open/close button flow, removes the link shortcut to Currencies, and includes tracked-currency toggles.
- Warband prey rows now show an `N/H/Ni` column with mode toggle (`available` or `completed`) and keep rank visible in a dedicated column.
- Hunt Table preview can now be shown directly from Options, with independent Hunt theme selection and cleaner grouped row titles that no longer append difficulty/zone suffixes.
- Hunt grouping now buckets by group first and sorts within each group, preventing duplicate zone/difficulty headers when sort order changes.
- Warband runtime now honors its own tracked-currency list and theme settings, and grouped character rows fill the `N/H/Ni` column instead of adding separate prey rows.
- Hunt availability counts now preserve cached values at login and update automatically on first Hunt Table interaction, removing the need to manually click the table before Warband difficulty tracking refreshes.
- Hunt Table defaults for new installs are now `Match Currency Theme = On`, `Group Hunts By = Difficulty`, and `Sort Hunts By = Zone`.
- Removed the Hunt Table bottom debug helper text from the live panel for a cleaner in-game presentation.
- Updated one-time splash content and release metadata for `1.7.0` (TOC, build script default version, and What's New version gate).

### Fixed
- Prevented prey availability snapshots from being overwritten with nil scanner values during early login refresh timing, so cached N/H/Ni values remain visible until live hunt data arrives.
- Kept localization bootstrap/fallback flow release-safe for ship builds while updating the splash body/title copy used in `1.7.0`.

## 1.6.5 - 2026-03-14

### Fixed
- Restored semantic localization fallback text assignments so settings hints and currency splash body no longer display raw keys (`HINT_PANEL_SUBTITLE`, `HINT_VERTICAL_PERCENT_OFFSET`, `HINT_VERTICAL_LOCK`, `HINT_AUDIO_SLIDER`, `HINT_ADVANCED_NOTES`, `WHATS_NEW_BODY`).
- Reworked fallback minimap button behavior for clients without icon managers:
  - corrected full-circle drag math using quadrant-safe angle handling;
  - restored proper icon asset source (`media/Preydator_64.png` from project asset copy);
  - stabilized Blizzard-style circular button presentation.

## 1.6.4 - 2026-03-14

### Fixed
- Removed `local L` alias from `Preydator.lua` main chunk to stay under Lua's hard 200-local-variable limit. Locale lookups now reference `_G.PreydatorL` directly inline. This also resolves the cascading `RegisterModule` nil errors in `Settings.lua`, `EditMode.lua`, and `CurrencyTracker.lua` that occurred because `Preydator.lua` was aborting before `_G.Preydator` was created.

## 1.6.3 - 2026-03-14

### Added
- Localization infrastructure: `Locales/Locales.lua` creates the `PreydatorL` global with a metatable fallback so untranslated keys safely return the key itself.
- `Locales/enUS.lua` — full translator reference guide documenting every key, format-string pattern, and semantic hint key.
- Stub locale files for deDE, frFR, esES, esMX, ptBR, itIT, ruRU, koKR, zhCN, zhTW — ready for community translation.

### Changed
- All UI strings in `Preydator.lua`, `Settings.lua`, `CurrencyTracker.lua`, and `EditMode.lua` routed through `L["key"]` lookup.
- TOC updated to version 1.6.3; all 12 locale files load before `Preydator.lua`.

### Fixed
- Ambush detection double-trigger: removed English `"ambush"` string check from `IsAmbushSystemMessage`; detection now relies solely on prey name matching, eliminating the duplicate sound that fired from both `CHAT_MSG_SYSTEM` and `CHAT_MSG_MONSTER_SAY`.

## 1.6.0 - 2026-03-14

### Added
- New Currency Tracker system for approved Prey currencies (`3392`, `3316`, `3383`, `3341`, `3343`).
- New Warband currency window with sortable columns and optional realm grouping/subtotals.
- New currency-focused options page controls for tracked IDs, random hunt cost context, gain/spend delta colors, and layout controls.
- New one-time "What's New" splash for the currency feature rollout.
- New Advanced-tab action button: `Show What's New`.

### Changed
- Currency and Warband windows now default to OFF for fresh installs.
- Currency theme naming cleaned up (`Light` instead of `Light (Tan)`).
- Currency options panel streamlined to keep core controls in one place, including a local theme selector.
- Release metadata updated for `1.6.0`.

### Fixed
- Light theme readability improved for text/title contrast.
- Currency window now expands and contracts correctly with tracked-row count.
- Warband table columns remain inside window bounds and auto-fit tracked currency columns.
- Warband sizing now grows and contracts with content demand without forcing manual slider correction.

## 1.5.5 - 2026-03-13

### Added
- Expanded vertical bar setup in Display settings with dedicated controls for orientation, fill direction, vertical scale, text side/alignment, and vertical percent behavior.
- Added vertical tick-percent workflow so percent labels can be shown at tick marks and replace the single vertical percent text when enabled.

### Changed
- Repurposed Display tab control from `Tick Mark Layer` to `Text Display` (`Above Bar` / `Below Bar`) for prefix/suffix stage name placement.
- `Vertical Percent Side` is now focused on tick-mark behavior (`Vertical Percent Tick Mark`) and no longer drives single percent placement logic.
- `Above Ticks` percent mode now renders tick-mark percentages above the bar instead of showing one top-aligned percent value.
- Tick mark rendering now stays above fill by default for consistent readability.

### Fixed
- Corrected a Lua syntax regression in display settings normalization caused by an incomplete conditional branch (`Missed symbol 'then'`).

## 1.5.1 - 2026-03-13

### Added
- New label modes for combined output on one side: `Left (Prefix + Suffix)` and `Right (Prefix + Suffix)`.
- New percent display modes: `Above Bar` and `Above Ticks`.
- New text layout control: `Prefix/Suffix Row` with `Above Bar` or `Below Bar` placement.
- New orientation controls in Display settings: `Bar Orientation` (`Horizontal` or `Vertical`) and `Vertical Fill Direction` (`Fill Up` or `Fill Down`).

### Changed
- Text tab right column is now aligned with left-column prefix/suffix sections for a more symmetrical layout.
- Vertical orientation now supports vertical prefix/suffix rendering while percent text remains horizontal.

### Notes
- Vertical mode is implemented as a practical beta-style option due Blizzard UI constraints around true font rotation; labels are rendered in stacked vertical text.

## 1.5.0 - 2026-03-13

### Added
- New settings checkbox: **Show in Edit Mode preview** so the Preydator bar remains visible while Blizzard Edit Mode is open.
- New setting: **Tick Mark Layer** with `Above Fill` or `Below Fill` modes.
- Expanded **Percent Display** modes with explicit in-bar layering: `In Bar (Above Fill)` and `In Bar (Below Fill)`.
- New modular **tabbed settings UI** that replaces the old single long-form options layout.
- New compact **Edit Mode quick settings** window for common layout controls while Blizzard Edit Mode is open.
- Sliders now include a live value field that can also be typed into directly.
- **Label Mode** dropdown with centered, left-only, right-only, separate prefix/suffix, and no-text layouts.
- Prefix and suffix label support for all four stages, plus dedicated out-of-zone and ambush prefix fields.
- **Border Color** picker with optional link-to-fill behavior.
- **Tick Mark Color** picker in Display settings.
- Static spark line at the right edge of the fill bar for clearer fill-end visibility.

### Changed
- Layering behavior for in-bar percent text is now driven directly by the selected percent display mode.
- Options layout now stays within a strict two-column structure across tabs instead of expanding into an overlong stacked panel.
- Default bar size updated to match the preferred in-game look: **Width 160, Height 29, Scale 0.9**. Existing installs keep their saved values.
- Default **Progress Segments** changed from Quarters to **Thirds**. Existing installs keep their saved value.
- Fill bar and tick marks are inset inside the border so scaling, texture changes, and color changes do not bleed outside the frame.

### Compatibility
- Existing installs keep current saved values; new settings defaults are only applied when a key is missing in `PreydatorDB`.

### Note for users reporting "bar shows 25% at stage start"
This is expected behavior. Blizzard only exposes a stage number (1–4), not a true percent. Stage 1 = entered prey zone = 25% (or 33% in Thirds mode) is the first meaningful progress state the addon can report. Stage 4 = prey visible on map = 100%.

## 1.1.2 - 2026-03-06

### Changed
- Release polish pass for stage-4 prey encounter behavior and map-open fallback interactions.
- Core slash help now only lists user-facing commands.
- Encounter suppression gating tightened to active prey hunt flow only (`active quest` + `in zone` + `stage > 1`).

### Fixed
- Stage-4 bar click fallback no longer depends on waypoint availability; map opening proceeds even when quest coordinates are unavailable.
- Prevented duplicate map toggles from mouse down/up double execution in stage-4 fallback mode.
- Hardened widget suppression paths against restricted/forbidden table access and animation-group API misuse.

### Dev / Internal
- Debug inspect slash handling moved out of core command flow and delegated to optional modules.
- Added optional debug module: `Modules/DebugInspect.lua` (not loaded by default in `Preydator.toc`).

## 1.1.1 - 2026-03-06

### Added
- New settings checkbox: **Disable Default Prey Icon**.
- Stage 4 quick-navigation: click the default prey encounter icon to open the world map and set a waypoint for the active prey quest.
- Stage 4 fallback when icon is hidden: click the locked Preydator bar to open the world map and set prey quest waypoint.

### Fixed
- Resolved startup/runtime Lua error from calling `NormalizeSoundSettings` before local function initialization.
- Resolved a second ordering regression where `GetSoundPathForKey` could be called before local function initialization.
- Added explicit forward declarations for both helpers to prevent nil global-call failures during early settings normalization paths.
- Hardened ambush chat detection against tainted/secret chat strings to avoid `attempt to compare local 'message'` runtime errors.
- Disabled ambush chat scanning while in `party`, `raid`, `scenario`, or `delve` instances where Blizzard restricts actionable chat payloads.
- Disabled ambush chat scanning when no active prey quest is tracked.
- Improved default prey icon toggle behavior by scanning prey widget frame regions so icon hide/show applies more reliably across widget containers.
- Default prey encounter suppression now only applies during active prey hunt stages (in-zone or while progress data is active).

## 1.1.0 - 2026-03-05

### Added
- Ambush alert system updates: configurable ambush sound/visual toggles and custom ambush text override support.
- In-settings **Custom Sound Files** tools to add and remove entries without slash commands.
- Flexible custom sound input handling: accepts names without spaces, optional `.ogg`, and optional full addon sound path prefix.

### Changed
- Ambush sound default is now `predator-kill.ogg`.
- Sound failure warning text now points to the current custom file workflow.
- Debug logging now defaults to **off** at startup.

### Fixed
- Removal logic now handles legacy malformed custom sound entries more reliably (without enabling space-containing names).

## 1.0.2 - 2026-03-04

### Changed
- `Only show in prey zone` behavior now works as: unchecked = bar visible, checked = hide unless active prey is in-zone.
- Progress tick marks now show only `25`, `50`, and `75` (removed `0`).

## 1.0.1 - 2026-03-04

### Added
- New settings option: **Only show in prey zone** to hide the bar while you are outside the active prey zone.

### Changed
- Replaced **Show when no active prey** with **Only show in prey zone** for clearer visibility behavior.
- README now clarifies out-of-zone visibility behavior and the new zone-gated display option.

### Fixed
- `/preydator options` and `/pd options` now open the settings category using a valid numeric category ID in modern Settings API flows.
- Resolved Lua error: `bad argument #1 to 'OpenSettingsPanel'` caused by passing a string category name to `Settings.OpenToCategory`.

## 1.0.0 - 2026-03-03

### Added
- Full settings panel for bar visuals, fonts, colors, labels, and sound behavior.
- Stage sound test buttons directly in settings.
- `/pd inspect` diagnostics for live quest/widget/bar state.
- Full reset-to-defaults support from settings.

### Changed
- Stage model finalized to 4 hunt stages:
  1. Scent in the Wind
  2. Blood in the Shadows
  3. Echoes of the Kill
  4. Feast of the Fang
- Final stage display is locked to 100% for consistent end-stage feedback.
- Bar scaling behavior updated to resize around a stable center anchor.
- README refreshed for release usage and customization guidance.

### Fixed
- Color picker callback/session handling issues across multiple swatches.
- Reset workflow now refreshes controls and values correctly in the settings UI.
- Bar position persistence/lock behavior regressions during iterative tuning.

### Removed
- Redundant slash sound test commands (replaced by settings test buttons).
- Redundant slash reset command (replaced by settings reset controls).
- Nameplate texture preset from texture options.
