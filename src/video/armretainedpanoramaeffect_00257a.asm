; $00257A..$0025C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Mark legacy panorama effect active, reset its frame and
; sound flag, randomize X phase, then copy 368 longwords (46 tiles) from
; HealthNumberMaskTiles to VRAM $0000. No normal caller for the old sprite
; renderer has been found; arming does not prove that the sprites are drawn.
        ifne *-$257A
        fail "ROM start moved"
        endif

ArmRetainedPanoramaEffect:
        move.b       #$ff, rRetainedPanoramaEffectActive(a6)                              ; $00257A
        clr.b        rRetainedPanoramaEffectFrame(a6)                                    ; $002580
        clr.b        rRetainedPanoramaEffectPending(a6)                                    ; $002584
        move.b       #$4, rRetainedPanoramaEffectPreset(a6)                               ; $002588
        jsr          NextRandom.l                                  ; $00258E
        swap         d2                                            ; $002594
        andi.w       #$78, d2                                      ; $002596
        move.b       d2, rRetainedPanoramaHorizontalPhase(a6)                                ; $00259A

loc_00259E:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00259E
        bne.b        loc_00259E                                    ; $0025A2
        move.l       #$40000000, VDP_CONTROL.l                     ; $0025A4
        lea.l        HealthNumberMaskTiles.l, a0                             ; $0025AE
        move.w       #$16f, d7                                     ; $0025B4

loc_0025B8:
        move.l       (a0)+, VDP_DATA.l                             ; $0025B8
        dbra         d7, loc_0025B8                                ; $0025BE
        rts                                                        ; $0025C2
        ifne *-$25C4
        fail "ROM end moved"
        endif
