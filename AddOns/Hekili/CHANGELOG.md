# Hekili

## [v11.1.0-1.0.15](https://github.com/Hekili/hekili/tree/v11.1.0-1.0.15) (2025-03-28)
[Full Changelog](https://github.com/Hekili/hekili/compare/v11.1.0-1.0.14...v11.1.0-1.0.15) [Previous Releases](https://github.com/Hekili/hekili/releases)

- Elemental APL  
- Merge pull request #4642 from syrifgit/syrif-monk  
    Default Empowerment  
- Merge pull request #4643 from johnnylam88/fix/item-proc-healing  
    fix: item proc name is "healing" not "heal"  
- Merge pull request #4644 from johnnylam88/feat/item-anodized-deflectors  
    feat: add Anodized Deflectors plate wrists on-use effect  
- fix: item proc name is "healing" not "heal"  
- feat: add Anodized Deflectors plate wrists on-use effect  
- words  
- More default empowerment  
    - Add fallback within Core `slot.empower_to` to also check for default.  
    - Set WW slicing winds default to 1, as empowerment only changes distance and the WW APL does not have `empower_to` modifiers in it.  
- Merge pull request #4640 from syrifgit/Affliction  
    Affliction lock - MInor accuracy improvements  
- Merge pull request #3694 from johnnylam88/feat/editorconfig  
    feat: add .editorconfig file  
- Merge pull request #4626 from ctroller/mugzee-exclusions  
    Add Mug'Zee NPC target exclusions  
- Merge pull request #4633 from syrifgit/State-file  
    Clean up after your pets ...  
- Affliction lock - MInor accuracy improvements  
    Tidied up some incorrect models  
- Merge pull request #4639 from syrifgit/Rogue-Fixes  
    Rogue formatting - no functionality/logic changes  
- Merge pull request #4627 from syrifgit/syrif-hunter  
    New SimC Expression for Hunters (boar\_charge)  
- Sub  
- Outlaw  
- Sin Rogue  
- review  
- incorporate feedback  
- Fix fire\_breath\_fixed (heh)  
- Fix snapshot text for empowerment fallthrough  
- Fix empowering when no APL criteria are met  
- Merge pull request #4636 from syrifgit/syrif-mage  
    Intuition spellID  
- undo stale changes  
- Intuition spellID  
    SpellID was changed this patch.  
    https://www.wowhead.com/spell=1223797/intuition  
    ```  
    player\_buffs:  
       id      - name                                 - stacks - remaining duration  
       1459    - arcane\_intellect                     -   1    - 3525.41  
       442983  - viziers\_savvy                        -   1    - 3600.00  
       225787  - sign\_of\_the\_warrior                  -   1    - 3600.00  
       457666  - dawnthread\_lining                    -   1    - 3600.00  
       1217242 - enlightened                          -   1    - 3600.00  
       210126  - arcane\_familiar                      -   1    - 3525.41  
       116267  - incanters\_flow                       -   5    - 3600.00  
       448604  - spellfire\_spheres                    -   5    - 3600.00  
       449322  - mana\_cascade                         -   6    - 8.53  
       383997  - arcane\_tempo                         -   5    - 10.56  
       458388  - aether\_attunement\_stack              -   1    - 3600.00  
       455454  - unstable\_power\_suit\_core             -   1    - 12.47  
       449400  - next\_blast\_spheres                   -   2    - 28.56  
       1223797 - *intuition                           -   1    - 1.56  
    ```  
- Merge remote-tracking branch 'upstream/thewarwithin' into syrif-mage  
- Implement invert logic  
    Co-authored-by: Hekili <Hekili@users.noreply.github.com>  
- Clean up after your pets ...  
- timely  
- Merge remote-tracking branch 'upstream/thewarwithin' into syrif-hunter  
- support new SimC expression  
    May be referenced in survival APL, Putro just made it and Thyminde is experimenting  
- Add Mug'Zee NPC target exclusions  
    There's an additional NPC, https://www.wowhead.com/npc=230312/volunteer-rocketeer, which is only attackable on Heroic and Mythic (instantly dies in LFR/Normal) which would require additional logic  
- Let Scorch be a very fast projectile  
- feat: add .editorconfig file  
    Add a `.editorconfig` file at the top-level of the source tree to  
    maintain consistency for whitespace usage across various editors and  
    IDEs, e.g., VSCode, Notepad++, NeoVim, etc.  
    The current definitions match the existing code conventions of using  
    4-space tabs for indentation.  
