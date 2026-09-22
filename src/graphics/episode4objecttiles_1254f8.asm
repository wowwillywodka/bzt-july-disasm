; $1254F8..$12DCF7 | object-tiles
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1254F8
        fail "ROM start moved"
        endif

Episode4ObjectTiles equ $1254F8
Episode4ObjectTile01_FireEffect equ $1256F8
Episode4ObjectTile02_UnassignedEffect equ $1258F8
Episode4ObjectTile03_BioScannerPickup equ $125AF8
Episode4ObjectTile04_FlashlightPickup equ $125CF8
Episode4ObjectTile05_LaserAimedGunPickup equ $125EF8
Episode4ObjectTile06_RocketLauncherOrGunrockPickup equ $1260F8
Episode4ObjectTile07_NightVisionPickup equ $1262F8
Episode4ObjectTile08_MineFrame0 equ $1264F8
Episode4ObjectTile09_MineFrame1 equ $1266F8
Episode4ObjectTile10_BulletproofVestPickup equ $1268F8
Episode4ObjectTile11_RetainedPickup equ $126AF8
Episode4ObjectTile12_ShotgunPickup equ $126CF8
Episode4ObjectTile13_HandGrenadePickup equ $126EF8
Episode4ObjectTile14_BuligunPickup equ $1270F8
Episode4ObjectTile15_SnowmanPickup equ $1272F8
Episode4ObjectTile16_GunrockPickup equ $1274F8
Episode4ObjectTile17_PulseLaserPickup equ $1276F8
Episode4ObjectTile18_MedipackPickup equ $1278F8
Episode4ObjectTile19_Cell26Frame0 equ $127AF8
Episode4ObjectTile20_Cell26Frame1 equ $127CF8
Episode4ObjectTile21_UnassignedCharacterImage equ $127EF8
Episode4ObjectTile22_UnassignedCharacterImage equ $1280F8
Episode4ObjectTile23_UnassignedCharacterImage equ $1282F8
Episode4ObjectTile24_UnassignedCharacterImage equ $1284F8
Episode4ObjectTile25_UnassignedCharacterImage equ $1286F8
Episode4ObjectTile26_UnassignedCharacterImage equ $1288F8
Episode4ObjectTile27_UnassignedCharacterImage equ $128AF8
Episode4ObjectTile28_UnassignedCharacterImage equ $128CF8
Episode4ObjectTile29_UnassignedCharacterImage equ $128EF8
Episode4ObjectTile30_UnassignedCharacterImage equ $1290F8
Episode4ObjectTile31_UnassignedCharacterImage equ $1292F8
Episode4ObjectTile32_UnassignedCharacterImage equ $1294F8
Episode4ObjectTile33_UnassignedCharacterImage equ $1296F8
Episode4ObjectTile34_UnassignedCharacterImage equ $1298F8
Episode4ObjectTile35_UnassignedCharacterImage equ $129AF8
Episode4ObjectTile36_UnassignedCharacterImage equ $129CF8
Episode4ObjectTile37_UnassignedCharacterImage equ $129EF8
Episode4ObjectTile38_UnassignedCharacterImage equ $12A0F8
Episode4ObjectTile39_UnassignedCharacterImage equ $12A2F8
Episode4ObjectTile40_UnassignedCharacterImage equ $12A4F8
Episode4ObjectTile41_UnassignedCharacterImage equ $12A6F8
Episode4ObjectTile42_UnassignedCharacterImage equ $12A8F8
Episode4ObjectTile43_UnassignedCharacterImage equ $12AAF8
Episode4ObjectTile44_UnassignedCharacterImage equ $12ACF8
Episode4ObjectTile45_UnassignedCharacterImage equ $12AEF8
Episode4ObjectTile46_TreeCell37 equ $12B0F8
Episode4ObjectTile47_TreeCell5C equ $12B2F8
Episode4ObjectTile48_FloorLamp equ $12B4F8
Episode4ObjectTile49_FlashingLampFrame1 equ $12B6F8
Episode4ObjectTile50_HangingLampBase equ $12B8F8
Episode4ObjectTile51_ColumnCell60 equ $12BAF8
Episode4ObjectTile52_ColumnCell76 equ $12BCF8
Episode4ObjectTile53_LampFrame0 equ $12BEF8
Episode4ObjectTile54_ColumnCell61 equ $12C0F8
Episode4ObjectTile55_FurnitureShared equ $12C2F8
Episode4ObjectTile56_HangingLampTop equ $12C4F8
Episode4ObjectTile57_SmallLamp equ $12C6F8
Episode4ObjectTile58_FanFrame0 equ $12C8F8
Episode4ObjectTile59_FanFrame1 equ $12CAF8
Episode4ObjectTile60_FlamethrowerPickup equ $12CCF8
Episode4ObjectTile61_ProjectilePhase0 equ $12CEF8
Episode4ObjectTile62_ProjectilePhases12 equ $12D0F8
Episode4ObjectTile63_ImpactFrame0 equ $12D2F8
Episode4ObjectTile64_ImpactFrame1 equ $12D4F8
Episode4ObjectTile65_ImpactFrame2 equ $12D6F8
Episode4ObjectTile66_UnassignedImage equ $12D8F8
Episode4ObjectTile67_UnassignedImage equ $12DAF8

        incbin "generated/data/1254f8.bin"
        ifne *-$12DCF8
        fail "ROM end moved"
        endif
