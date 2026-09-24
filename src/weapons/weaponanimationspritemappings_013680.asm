; $013680..$0136EF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$13680
        fail "ROM start moved"
        endif

UnarmedAnimationSpriteMappings equ $013680
UnarmedAnimationSpriteMapping01 equ $013688
UnarmedAnimationSpriteMapping02 equ $013690
UnarmedAnimationSpriteMapping03 equ $013698
UnarmedAnimationSpriteMapping04 equ $0136A0
UnarmedAnimationSpriteMapping05 equ $0136A8
UnarmedAnimationSpriteMapping06 equ $0136B0
UnarmedAnimationSpriteMapping08 equ $0136C0
UnarmedAnimationSpriteMapping09 equ $0136C8
UnarmedAnimationSpriteMapping10 equ $0136D0
UnarmedAnimationSpriteMapping11 equ $0136D8
UnarmedAnimationSpriteMapping12 equ $0136E0
UnarmedAnimationSpriteMapping13 equ $0136E8

        incbin "generated/data/013680.bin"
        ifne *-$136F0
        fail "ROM end moved"
        endif
