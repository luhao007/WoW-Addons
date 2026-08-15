# Preydator

Preydator is a focused Prey Hunt companion addon for World of Warcraft, featuring Predator-inspired audio cues, a customizable hunt progress bar, and stage-based tracking built from Blizzard quest/widget APIs.

Current release: `v2.0.6`

## What Preydator tracks

- Active prey quest and stage transitions in real time
- Out-of-zone state and fallback labels
- Stage-based progress display using Blizzard's exposed stage model

Important: Blizzard does not expose a true percent completion for Prey Hunts. Preydator uses stage transitions and fallback stage percentages.

- `Quarters`: `25 / 50 / 75 / 100`
- `Thirds`: `33 / 66 / 100` (default for new installs)

## Stage flow

1. **Scent in the Wind**
2. **Blood in the Shadows**
3. **Echoes of the Kill**
4. **Feast of the Fang**

## UI and layout features (2.0.3)

- New module runtime controls for Bar, Sounds, Currency, Hunt Table, and Warband
- Module-aware settings locking with reload detection when module state changes
- CPU optimizations for zone caching and reduced unnecessary update routes
- New installs start with the bar unlocked for quick placement; lock it in Options when finished
- 4K display support with corrected dropdown scaling and UI-scale normalization
- Account-wide prey unlock tracking for Nightmare difficulty
- Bar position persistence across reloads with resilient backup coordinate sync
- New Currency Tracker window for approved Prey currencies
- New Warband currency table with sortable columns and realm grouping
- Hunt Table tracker with grouping/sorting, reward icons, collapsible headers, and direct accept/open actions
- Warband `Prey Track (Alts)` with `N/H/Ni` available/completed modes and weekly-aware tracking snapshots
- Session delta tracking for approved Prey currencies
- Theme support in currency windows: `Light`, `Brown`, `Dark`
- One-time What's New splash for currency launch (with Show Again in Advanced tab)
- Currencies tab now includes direct controls for tracker/warband visibility, tracked currency selection, random hunt cost context, and panel layout sliders

- Modular tabbed settings panel: `General`, `Display`, `Text`, `Audio`, `Advanced`
- Compact Edit Mode quick-settings window
- Edit Mode click-to-open behavior on the Preydator element
- Outside-click dismiss behavior while Edit Mode quick-settings is open
- Lock/unlock positioning and persistent center-relative coordinates
- Display controls: width, height, scale, font size
- Vertical bar mode controls: orientation, fill direction, vertical scale, dedicated width/height, text side/alignment, and vertical percent controls

## Display customization

- Texture presets
- Color controls:
	- Fill color
	- Background color
	- Title color
	- Percent color
	- Tick mark color
	- Border color (optional linked-to-fill behavior)
- Percent display modes:
	- In Bar
	- Above Bar
	- Above Ticks
	- Under Ticks
	- Below Bar
	- Off
- Text Display mode for stage names: `Above Bar` or `Below Bar`
- Tick mark labels can be used as the percent display in vertical mode (`Show Percentage at Tick Marks`)
- `Display Spark Line` toggle (default: off)
- Fill and tick rendering inset so visuals stay inside the border at all scales

## Text and label system

- Full stage label editing for all 4 stages
- Prefix + suffix label system
- Dedicated `Out of Zone Prefix` and `Ambush Prefix`
- Ambush custom override text
- Label modes:
	- Centered
	- Left (Prefix only)
	- Left (Suffix only)
	- Right (Suffix only)
	- Right (Prefix only)
	- Separate (Prefix + Suffix)
	- No Text

## Audio features

- Stage 1-4 sound selection
- Ambush sound selection
- Sound channel selection
- Sound enhancement control
- Stage sound test buttons (1-4) and Ambush test button
- Custom sound file add/remove in settings UI
- Protected default sound files cannot be removed

Bundled default files:

- `predator-alert.ogg`
- `predator-ambush.ogg`
- `predator-torment.ogg`
- `predator-kill.ogg`

## Visibility and icon behavior

- `Only show in prey zone`
- `Show in Edit Mode preview`
- `Disable Default Prey Icon`
- Stage 4 map-open fallback behavior when icon is disabled

## Diagnostics and debug

- `/pd inspect` live diagnostic output
- `/pd mem` memory snapshot
- Debug system defaults to off
- Advanced tab `Enable Debug` toggle
- Slash debug controls remain available:
	- `/pd debug on`
	- `/pd debug off`
	- `/pd debug show`
	- `/pd debug clear`

## Roadmap progress snapshot

- Epic 1: Approved Currency Ledger (MVP) - Completed and expanded through `v1.7.0`
- Epic 2: Hunt Source Scanner - Planned
- Epic 3: Weekly Hunt Cap Tracker - Planned
- Epic 4: Prey Achievement Gap Highlighter - Planned
- Epic 5: Reward Intelligence and Cost Context - In progress

## Slash commands

- `/pd options` or `/preydator options` - open settings
- `/pd inspect` - print live diagnostics
- `/pd inspect bs` - send inspect diagnostics to BugSack
- `/pd show` - force show bar
- `/pd hide` - return to auto visibility
- `/pd toggle` - toggle force show
- `/pd mem` - print memory usage snapshot
- `/pd debug <on|off|show|clear>` - debug logging tools

## Optional custom audio

Place your own `.ogg` files in:

```text
Interface/AddOns/Preydator/sounds/
```

Then add/select them in settings and run `/reload` if needed.

Accepted input formats in the custom file field:

- bare name (example: `my-alert`)
- explicit `.ogg` filename (example: `my-alert.ogg`)
- full path starting with `Interface\AddOns\Preydator\sounds\`

## Issues and feedback

Please report bugs, feature requests, or visual/audio issues at:

**[https://github.com/RagingAltoholic/Preydator/issues](https://github.com/RagingAltoholic/Preydator/issues)**
