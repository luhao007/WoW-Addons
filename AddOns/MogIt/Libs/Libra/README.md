# Libra

Library to facilitate some common tasks. Not necessarily designed to be infinitely flexible or applicable for any given situation.

```
local Libra = LibStub("Libra")
```


### Libra:NewAddon(addonName, addonTable)

Table with module and event handling functions.

- addonName
  - String identifying the addon object. should be the same as your addon folder name.
- addonTable
  - An existing table to use as the addon object. If not provided, will create a new table.

```
local addon = Libra:NewAddon("MyAddon", {})
```


### Libra:EmbedWidgets(target)

Embeds all widget creation functionality on the target table, allowing you to directly create widgets.

```
local MyAddon = Libra:NewAddon("MyAddon")
Libra:EmbedWidgets(MyAddon)

local dropdown = MyAddon:CreateDropdown("Menu")
```


### Libra:CreateDropdown(type, parent)

Dropdown with a wrapper API around the FrameXML API, working around known taint issues and adding certain features such as scrollable and fully refreshable menus.

- type
  - "Menu" for a standalone menu, "Frame" for a list frame which in turns summons the menu
- parent
  - parent frame if "Frame" type


### Libra:CreateEditbox()


### Libra:CreateScrollFrame(type, parent, name)

- type
  - "Faux" or "Hybrid"
- parent
  - parent frame
- name
  - frame name


### Libra:CreateUIPanel(name)

ButtonFrameTemplate frame closable with escape and pushable by other frames.

- name
  - Name to use for the frame. If not provided, will use an automatically generated name.
