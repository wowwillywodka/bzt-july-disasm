; $0CBB3C..$0D433B | object-tiles
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$CBB3C
        fail "ROM start moved"
        endif

Episode2ObjectTiles equ $0CBB3C
Episode2ObjectTile01_FireEffect equ $0CBD3C
Episode2ObjectTile02_UnassignedEffect equ $0CBF3C
Episode2ObjectTile03_BioScannerPickup equ $0CC13C
Episode2ObjectTile04_FlashlightPickup equ $0CC33C
Episode2ObjectTile05_LaserAimedGunPickup equ $0CC53C
Episode2ObjectTile06_RocketLauncherOrGunrockPickup equ $0CC73C
Episode2ObjectTile07_NightVisionPickup equ $0CC93C
Episode2ObjectTile08_MineFrame0 equ $0CCB3C
Episode2ObjectTile09_MineFrame1 equ $0CCD3C
Episode2ObjectTile10_BulletproofVestPickup equ $0CCF3C
Episode2ObjectTile11_RetainedPickup equ $0CD13C
Episode2ObjectTile12_ShotgunPickup equ $0CD33C
Episode2ObjectTile13_HandGrenadePickup equ $0CD53C
Episode2ObjectTile14_BuligunPickup equ $0CD73C
Episode2ObjectTile15_SnowmanPickup equ $0CD93C
Episode2ObjectTile16_GunrockPickup equ $0CDB3C
Episode2ObjectTile17_PulseLaserPickup equ $0CDD3C
Episode2ObjectTile18_MedipackPickup equ $0CDF3C
Episode2ObjectTile19_Cell26Frame0 equ $0CE13C
Episode2ObjectTile20_Cell26Frame1 equ $0CE33C
Episode2ObjectTile21_UnassignedCharacterImage equ $0CE53C
Episode2ObjectTile22_UnassignedCharacterImage equ $0CE73C
Episode2ObjectTile23_UnassignedCharacterImage equ $0CE93C
Episode2ObjectTile24_UnassignedCharacterImage equ $0CEB3C
Episode2ObjectTile25_UnassignedCharacterImage equ $0CED3C
Episode2ObjectTile26_UnassignedCharacterImage equ $0CEF3C
Episode2ObjectTile27_UnassignedCharacterImage equ $0CF13C
Episode2ObjectTile28_UnassignedCharacterImage equ $0CF33C
Episode2ObjectTile29_UnassignedCharacterImage equ $0CF53C
Episode2ObjectTile30_UnassignedCharacterImage equ $0CF73C
Episode2ObjectTile31_UnassignedCharacterImage equ $0CF93C
Episode2ObjectTile32_UnassignedCharacterImage equ $0CFB3C
Episode2ObjectTile33_UnassignedCharacterImage equ $0CFD3C
Episode2ObjectTile34_UnassignedCharacterImage equ $0CFF3C
Episode2ObjectTile35_UnassignedCharacterImage equ $0D013C
Episode2ObjectTile36_UnassignedCharacterImage equ $0D033C
Episode2ObjectTile37_UnassignedCharacterImage equ $0D053C
Episode2ObjectTile38_UnassignedCharacterImage equ $0D073C
Episode2ObjectTile39_UnassignedCharacterImage equ $0D093C
Episode2ObjectTile40_UnassignedCharacterImage equ $0D0B3C
Episode2ObjectTile41_UnassignedCharacterImage equ $0D0D3C
Episode2ObjectTile42_UnassignedCharacterImage equ $0D0F3C
Episode2ObjectTile43_UnassignedCharacterImage equ $0D113C
Episode2ObjectTile44_UnassignedCharacterImage equ $0D133C
Episode2ObjectTile45_UnassignedCharacterImage equ $0D153C
Episode2ObjectTile46_TreeCell37 equ $0D173C
Episode2ObjectTile47_TreeCell5C equ $0D193C
Episode2ObjectTile48_FloorLamp equ $0D1B3C
Episode2ObjectTile49_FlashingLampFrame1 equ $0D1D3C
Episode2ObjectTile50_HangingLampBase equ $0D1F3C
Episode2ObjectTile51_ColumnCell60 equ $0D213C
Episode2ObjectTile52_ColumnCell76 equ $0D233C
Episode2ObjectTile53_LampFrame0 equ $0D253C
Episode2ObjectTile54_ColumnCell61 equ $0D273C
Episode2ObjectTile55_FurnitureShared equ $0D293C
Episode2ObjectTile56_HangingLampTop equ $0D2B3C
Episode2ObjectTile57_SmallLamp equ $0D2D3C
Episode2ObjectTile58_FanFrame0 equ $0D2F3C
Episode2ObjectTile59_FanFrame1 equ $0D313C
Episode2ObjectTile60_FlamethrowerPickup equ $0D333C
Episode2ObjectTile61_ProjectilePhase0 equ $0D353C
Episode2ObjectTile62_ProjectilePhases12 equ $0D373C
Episode2ObjectTile63_ImpactFrame0 equ $0D393C
Episode2ObjectTile64_ImpactFrame1 equ $0D3B3C
Episode2ObjectTile65_ImpactFrame2 equ $0D3D3C
Episode2ObjectTile66_UnassignedImage equ $0D3F3C
Episode2ObjectTile67_UnassignedImage equ $0D413C

        incbin "generated/data/0cbb3c.bin"
        ifne *-$D433C
        fail "ROM end moved"
        endif
