# <DBM> Outlands

## [r677](https://github.com/DeadlyBossMods/DBM-BCVanilla/tree/r677) (2020-11-05)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-BCVanilla/compare/r676...r677) [Previous Releases](https://github.com/DeadlyBossMods/DBM-BCVanilla/releases)

- Actually fix gossip options so they don't spam nil errors when npcs don't have gossip options. C\_GossipInfo.GetOptions() always returns a table, even when there are no options, it's empty but [1] still exists, so it needs to make sure name does too. nilling checking both for good measure  
- Fixed a bug where revisions were incorrectly set in DBM-Outlands  
