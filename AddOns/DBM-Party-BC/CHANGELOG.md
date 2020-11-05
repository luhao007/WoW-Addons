# <DBM> Dungeons (BC)

## [r22](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r22) (2020-11-05)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r21...r22) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- Actually fix gossip options so they don't spam nil errors when npcs don't have gossip options. C\_GossipInfo.GetOptions() always returns a table, even when there are no options, it's empty but [1] still exists, so it needs to make sure name does too. nilling checking both for good measure  
- This should correct chorush to not classify him turning friendly as a whipe, as well as make sure he's never engaged when fiendly either.  
