# Raider.IO Mythic Plus, Raiding, and Recruitment

## [v202601220614](https://github.com/RaiderIO/raiderio-addon/tree/v202601220614) (2026-01-22)
[Full Changelog](https://github.com/RaiderIO/raiderio-addon/compare/v202601210603...v202601220614) [Previous Releases](https://github.com/RaiderIO/raiderio-addon/releases)

- [Raider.IO] Database Refresh  
- Tooltip re-rendering might error in secure situations where the unit is a secret, but the execution path is tainted. We abort the routine to avoid the potential error which would occur when calling `UnitIsPlayer`.  
- fixed addon block error upon startup  
