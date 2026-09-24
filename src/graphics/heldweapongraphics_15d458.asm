; $15D458..$15F5B7 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$15D458
        fail "ROM start moved"
        endif

UnarmedAttackDmaPrefix equ $15D458
UnarmedHeldWeaponGraphics equ $15D6D8
LaserAimedGunHeldGraphics equ $15DB78
RetainedCloseRange04HeldGraphics equ $15DE18
ShotgunHeldGraphics equ $15E0B8
HandGrenadeHeldGraphics equ $15E358
PulseLaserProjectileHeldGraphics equ $15E5F8
BuligunHeldGraphics equ $15E898
RocketAndGunrockHeldGraphics equ $15EB38
PulseLaserImmediateHeldGraphics equ $15EDD8
FlamethrowerHeldGraphics equ $15F078
SnowmanHeldGraphics equ $15F318

        incbin "generated/data/15d458.bin"
        ifne *-$15F5B8
        fail "ROM end moved"
        endif
