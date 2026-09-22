; $09D7F8..$0A5FF7 | object-tiles
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9D7F8
        fail "ROM start moved"
        endif

Episode1ObjectTiles equ $09D7F8
Episode1ObjectTile01_FireEffect equ $09D9F8
Episode1ObjectTile02_UnassignedEffect equ $09DBF8
Episode1ObjectTile03_BioScannerPickup equ $09DDF8
Episode1ObjectTile04_FlashlightPickup equ $09DFF8
Episode1ObjectTile05_LaserAimedGunPickup equ $09E1F8
Episode1ObjectTile06_RocketLauncherOrGunrockPickup equ $09E3F8
Episode1ObjectTile07_NightVisionPickup equ $09E5F8
Episode1ObjectTile08_MineFrame0 equ $09E7F8
Episode1ObjectTile09_MineFrame1 equ $09E9F8
Episode1ObjectTile10_BulletproofVestPickup equ $09EBF8
Episode1ObjectTile11_RetainedPickup equ $09EDF8
Episode1ObjectTile12_ShotgunPickup equ $09EFF8
Episode1ObjectTile13_HandGrenadePickup equ $09F1F8
Episode1ObjectTile14_BuligunPickup equ $09F3F8
Episode1ObjectTile15_SnowmanPickup equ $09F5F8
Episode1ObjectTile16_GunrockPickup equ $09F7F8
Episode1ObjectTile17_PulseLaserPickup equ $09F9F8
Episode1ObjectTile18_MedipackPickup equ $09FBF8
Episode1ObjectTile19_Cell26Frame0 equ $09FDF8
Episode1ObjectTile20_Cell26Frame1 equ $09FFF8
Episode1ObjectTile21_UnassignedCharacterImage equ $0A01F8
Episode1ObjectTile22_UnassignedCharacterImage equ $0A03F8
Episode1ObjectTile23_UnassignedCharacterImage equ $0A05F8
Episode1ObjectTile24_UnassignedCharacterImage equ $0A07F8
Episode1ObjectTile25_UnassignedCharacterImage equ $0A09F8
Episode1ObjectTile26_UnassignedCharacterImage equ $0A0BF8
Episode1ObjectTile27_UnassignedCharacterImage equ $0A0DF8
Episode1ObjectTile28_UnassignedCharacterImage equ $0A0FF8
Episode1ObjectTile29_UnassignedCharacterImage equ $0A11F8
Episode1ObjectTile30_UnassignedCharacterImage equ $0A13F8
Episode1ObjectTile31_UnassignedCharacterImage equ $0A15F8
Episode1ObjectTile32_UnassignedCharacterImage equ $0A17F8
Episode1ObjectTile33_UnassignedCharacterImage equ $0A19F8
Episode1ObjectTile34_UnassignedCharacterImage equ $0A1BF8
Episode1ObjectTile35_UnassignedCharacterImage equ $0A1DF8
Episode1ObjectTile36_UnassignedCharacterImage equ $0A1FF8
Episode1ObjectTile37_UnassignedCharacterImage equ $0A21F8
Episode1ObjectTile38_UnassignedCharacterImage equ $0A23F8
Episode1ObjectTile39_UnassignedCharacterImage equ $0A25F8
Episode1ObjectTile40_UnassignedCharacterImage equ $0A27F8
Episode1ObjectTile41_UnassignedCharacterImage equ $0A29F8
Episode1ObjectTile42_UnassignedCharacterImage equ $0A2BF8
Episode1ObjectTile43_UnassignedCharacterImage equ $0A2DF8
Episode1ObjectTile44_UnassignedCharacterImage equ $0A2FF8
Episode1ObjectTile45_UnassignedCharacterImage equ $0A31F8
Episode1ObjectTile46_TreeCell37 equ $0A33F8
Episode1ObjectTile47_TreeCell5C equ $0A35F8
Episode1ObjectTile48_FloorLamp equ $0A37F8
Episode1ObjectTile49_FlashingLampFrame1 equ $0A39F8
Episode1ObjectTile50_HangingLampBase equ $0A3BF8
Episode1ObjectTile51_ColumnCell60 equ $0A3DF8
Episode1ObjectTile52_ColumnCell76 equ $0A3FF8
Episode1ObjectTile53_LampFrame0 equ $0A41F8
Episode1ObjectTile54_ColumnCell61 equ $0A43F8
Episode1ObjectTile55_FurnitureShared equ $0A45F8
Episode1ObjectTile56_HangingLampTop equ $0A47F8
Episode1ObjectTile57_SmallLamp equ $0A49F8
Episode1ObjectTile58_FanFrame0 equ $0A4BF8
Episode1ObjectTile59_FanFrame1 equ $0A4DF8
Episode1ObjectTile60_FlamethrowerPickup equ $0A4FF8
Episode1ObjectTile61_ProjectilePhase0 equ $0A51F8
Episode1ObjectTile62_ProjectilePhases12 equ $0A53F8
Episode1ObjectTile63_ImpactFrame0 equ $0A55F8
Episode1ObjectTile64_ImpactFrame1 equ $0A57F8
Episode1ObjectTile65_ImpactFrame2 equ $0A59F8
Episode1ObjectTile66_UnassignedImage equ $0A5BF8
Episode1ObjectTile67_UnassignedImage equ $0A5DF8

        incbin "generated/data/09d7f8.bin"
        ifne *-$A5FF8
        fail "ROM end moved"
        endif
