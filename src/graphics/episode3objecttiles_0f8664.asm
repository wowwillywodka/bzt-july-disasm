; $0F8664..$100E63 | object-tiles
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F8664
        fail "ROM start moved"
        endif

Episode3ObjectTiles equ $0F8664
Episode3ObjectTile01_FireEffect equ $0F8864
Episode3ObjectTile02_UnassignedEffect equ $0F8A64
Episode3ObjectTile03_BioScannerPickup equ $0F8C64
Episode3ObjectTile04_FlashlightPickup equ $0F8E64
Episode3ObjectTile05_LaserAimedGunPickup equ $0F9064
Episode3ObjectTile06_RocketLauncherOrGunrockPickup equ $0F9264
Episode3ObjectTile07_NightVisionPickup equ $0F9464
Episode3ObjectTile08_MineFrame0 equ $0F9664
Episode3ObjectTile09_MineFrame1 equ $0F9864
Episode3ObjectTile10_BulletproofVestPickup equ $0F9A64
Episode3ObjectTile11_RetainedPickup equ $0F9C64
Episode3ObjectTile12_ShotgunPickup equ $0F9E64
Episode3ObjectTile13_HandGrenadePickup equ $0FA064
Episode3ObjectTile14_BuligunPickup equ $0FA264
Episode3ObjectTile15_SnowmanPickup equ $0FA464
Episode3ObjectTile16_GunrockPickup equ $0FA664
Episode3ObjectTile17_PulseLaserPickup equ $0FA864
Episode3ObjectTile18_MedipackPickup equ $0FAA64
Episode3ObjectTile19_Cell26Frame0 equ $0FAC64
Episode3ObjectTile20_Cell26Frame1 equ $0FAE64
Episode3ObjectTile21_UnassignedCharacterImage equ $0FB064
Episode3ObjectTile22_UnassignedCharacterImage equ $0FB264
Episode3ObjectTile23_UnassignedCharacterImage equ $0FB464
Episode3ObjectTile24_UnassignedCharacterImage equ $0FB664
Episode3ObjectTile25_UnassignedCharacterImage equ $0FB864
Episode3ObjectTile26_UnassignedCharacterImage equ $0FBA64
Episode3ObjectTile27_UnassignedCharacterImage equ $0FBC64
Episode3ObjectTile28_UnassignedCharacterImage equ $0FBE64
Episode3ObjectTile29_UnassignedCharacterImage equ $0FC064
Episode3ObjectTile30_UnassignedCharacterImage equ $0FC264
Episode3ObjectTile31_UnassignedCharacterImage equ $0FC464
Episode3ObjectTile32_UnassignedCharacterImage equ $0FC664
Episode3ObjectTile33_UnassignedCharacterImage equ $0FC864
Episode3ObjectTile34_UnassignedCharacterImage equ $0FCA64
Episode3ObjectTile35_UnassignedCharacterImage equ $0FCC64
Episode3ObjectTile36_UnassignedCharacterImage equ $0FCE64
Episode3ObjectTile37_UnassignedCharacterImage equ $0FD064
Episode3ObjectTile38_UnassignedCharacterImage equ $0FD264
Episode3ObjectTile39_UnassignedCharacterImage equ $0FD464
Episode3ObjectTile40_UnassignedCharacterImage equ $0FD664
Episode3ObjectTile41_UnassignedCharacterImage equ $0FD864
Episode3ObjectTile42_UnassignedCharacterImage equ $0FDA64
Episode3ObjectTile43_UnassignedCharacterImage equ $0FDC64
Episode3ObjectTile44_UnassignedCharacterImage equ $0FDE64
Episode3ObjectTile45_UnassignedCharacterImage equ $0FE064
Episode3ObjectTile46_TreeCell37 equ $0FE264
Episode3ObjectTile47_TreeCell5C equ $0FE464
Episode3ObjectTile48_FloorLamp equ $0FE664
Episode3ObjectTile49_FlashingLampFrame1 equ $0FE864
Episode3ObjectTile50_HangingLampBase equ $0FEA64
Episode3ObjectTile51_ColumnCell60 equ $0FEC64
Episode3ObjectTile52_ColumnCell76 equ $0FEE64
Episode3ObjectTile53_LampFrame0 equ $0FF064
Episode3ObjectTile54_ColumnCell61 equ $0FF264
Episode3ObjectTile55_FurnitureShared equ $0FF464
Episode3ObjectTile56_HangingLampTop equ $0FF664
Episode3ObjectTile57_SmallLamp equ $0FF864
Episode3ObjectTile58_FanFrame0 equ $0FFA64
Episode3ObjectTile59_FanFrame1 equ $0FFC64
Episode3ObjectTile60_FlamethrowerPickup equ $0FFE64
Episode3ObjectTile61_ProjectilePhase0 equ $100064
Episode3ObjectTile62_ProjectilePhases12 equ $100264
Episode3ObjectTile63_ImpactFrame0 equ $100464
Episode3ObjectTile64_ImpactFrame1 equ $100664
Episode3ObjectTile65_ImpactFrame2 equ $100864
Episode3ObjectTile66_UnassignedImage equ $100A64
Episode3ObjectTile67_UnassignedImage equ $100C64

        incbin "generated/data/0f8664.bin"
        ifne *-$100E64
        fail "ROM end moved"
        endif
