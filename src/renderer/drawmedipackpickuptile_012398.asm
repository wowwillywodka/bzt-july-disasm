; $012398..$01242F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Tile 18, medipack: selected by world type $25 and dispatcher alias $85. Common small-tile anchor at $01264C.
        ifne *-$12398
        fail "ROM start moved"
        endif

DrawMedipackPickupTile:
; Tile 18, medipack: selected by world type $25 and dispatcher alias $85. Common small-tile anchor at $01264C.
        movea.l      rZoneObjectTiles(a6), a1                      ; $012398
        adda.w       #ObjectTileOffset18_MedipackPickup, a1        ; $01239C
        bra.w        DrawSmallObjectTile                           ; $0123A0

loc_0123A4:
; World-table type $26 selects tiles 19/20 by tick bit 1. The visible-cell handler for type $26 is a spawn handler, not the ordinary billboard queue: table presence alone is not reachability.
        sub.w        d5, d2                                        ; $0123A4
        move.w       d5, d0                                        ; $0123A6
        asr.w        #$1, d0                                       ; $0123A8
        move.w       d0, d3                                        ; $0123AA
        asr.w        #$2, d3                                       ; $0123AC
        sub.w        d3, d0                                        ; $0123AE
        move.w       d0, d4                                        ; $0123B0
        asr.w        #$1, d4                                       ; $0123B2
        move.w       d4, d3                                        ; $0123B4
        asr.w        #$1, d3                                       ; $0123B6
        sub.w        d3, d1                                        ; $0123B8
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $0123BA
        movea.l      rZoneObjectTiles(a6), a1                      ; $0123BE
        adda.w       #ObjectTileOffset19_Cell26Frame0, a1          ; $0123C2
        btst.b       #$1, rGameTickLow(a6)                               ; $0123C6
        beq.w        ScaleAndDrawSoftwareSpriteTile                ; $0123CC
        movea.l      rZoneObjectTiles(a6), a1                      ; $0123D0
        adda.w       #ObjectTileOffset20_Cell26Frame1, a1          ; $0123D4
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0123D8

loc_0123DC:
        movea.l      #StananSpriteBank, a1                         ; $0123DC
        move.w       #$0, d0                                       ; $0123E2
        clr.w        d3                                            ; $0123E6
        clr.w        d7                                            ; $0123E8
        jmp          DrawExplicitAnimationFrame.l                  ; $0123EA

loc_0123F0:
        movea.l      #BloodBodySpriteBank, a1                      ; $0123F0
        move.w       #$0, d0                                       ; $0123F6
        clr.w        d3                                            ; $0123FA
        clr.w        d7                                            ; $0123FC
        jmp          DrawExplicitAnimationFrame.l                  ; $0123FE

loc_012404:
        movea.l      #BloodBodySpriteBank, a1                      ; $012404
        move.w       #$6, d0                                       ; $01240A
        move.w       #$5, d3                                       ; $01240E
        clr.w        d7                                            ; $012412
        jmp          DrawExplicitAnimationFrame.l                  ; $012414

loc_01241A:
        movea.l      #BloodBodySpriteBank, a1                      ; $01241A
        move.w       #$4, d0                                       ; $012420
        move.w       #$2, d3                                       ; $012424
        clr.w        d7                                            ; $012428
        jmp          DrawExplicitAnimationFrame.l                  ; $01242A
        ifne *-$12430
        fail "ROM end moved"
        endif
