; $01229A..$0122FF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Tile 0: flame billboard; horizontal mirror toggles on GameTick bit 0. Pixel bank is ROM, not a framebuffer.
        ifne *-$1229A
        fail "ROM start moved"
        endif

DrawWorldFlameTile:
; Tile 0: flame billboard; horizontal mirror toggles on GameTick bit 0. Pixel bank is ROM, not a framebuffer.
        move.w       d5, d0                                        ; $01229A
        sub.w        d5, d2                                        ; $01229C
        move.w       d5, d4                                        ; $01229E
        asr.w        #$1, d4                                       ; $0122A0
        move.w       d4, d3                                        ; $0122A2
        asr.w        #$2, d3                                       ; $0122A4
        add.w        d3, d4                                        ; $0122A6
        move.w       d4, d3                                        ; $0122A8
        asr.w        #$1, d3                                       ; $0122AA
        sub.w        d3, d1                                        ; $0122AC
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122AE
        move.w       rGameTick(a6), d3                             ; $0122B2
        andi.w       #$1, d3                                       ; $0122B6
        move.w       d3, rSoftwareSpriteMirrorFlag(a6)                                ; $0122BA
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0122BE

loc_0122C2:
        rts                                                        ; $0122C2

loc_0122C4:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122C4
        adda.w       #ObjectTileOffset60_FlamethrowerPickup, a1    ; $0122C8
        bra.w        DrawHalfHeightObjectTile                      ; $0122CC

loc_0122D0:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122D0
        adda.w       #ObjectTileOffset03_BioScannerPickup, a1      ; $0122D4
        bra.w        DrawHalfHeightObjectTile                      ; $0122D8

loc_0122DC:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122DC
        adda.w       #ObjectTileOffset08_MineFrame0, a1            ; $0122E0
        bra.w        DrawSmallObjectTile                           ; $0122E4

loc_0122E8:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122E8
        adda.w       #ObjectTileOffset17_PulseLaserPickup, a1      ; $0122EC
        bra.w        DrawSmallObjectTile                           ; $0122F0

loc_0122F4:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0122F4
        adda.w       #ObjectTileOffset10_BulletproofVestPickup, a1 ; $0122F8
        bra.w        DrawSmallObjectTile                           ; $0122FC
        ifne *-$12300
        fail "ROM end moved"
        endif
