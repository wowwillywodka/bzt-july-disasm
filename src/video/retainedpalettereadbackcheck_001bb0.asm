; $001BB0..$001C41 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1BB0
        fail "ROM start moved"
        endif

RetainedPaletteReadbackCheck:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $001BB0
        bne.b        RetainedPaletteReadbackCheck                  ; $001BB4
        move.w       rGameTick(a6), d0                             ; $001BB6
        andi.w       #$ff, d0                                      ; $001BBA
        bne.b        loc_001BE6                                    ; $001BBE
        move.l       #$700020, VDP_CONTROL.l                       ; $001BC0
        move.w       VDP_DATA.l, d0                                ; $001BCA
        jsr          DelayVdpAccess.l                              ; $001BD0
        andi.w       #$eee, d0                                     ; $001BD6
        movea.l      rZoneScenePalette(a6), a0                     ; $001BDA
        cmp.w        $70(a0), d0                                   ; $001BDE
        bne.b        loc_001C10                                    ; $001BE2
        rts                                                        ; $001BE4

loc_001BE6:
        move.l       #$600020, VDP_CONTROL.l                       ; $001BE6
        movea.l      rZoneScenePalette(a6), a0                     ; $001BF0
        adda.w       #$60, a0                                      ; $001BF4
        move.w       #$f, d7                                       ; $001BF8

loc_001BFC:
        move.w       VDP_DATA.l, d0                                ; $001BFC
        andi.w       #$eee, d0                                     ; $001C02
        cmp.w        (a0)+, d0                                     ; $001C06
        bne.b        loc_001C10                                    ; $001C08
        dbra         d7, loc_001BFC                                ; $001C0A
        rts                                                        ; $001C0E

loc_001C10:
        bsr.w        WaitForVBlank                                 ; $001C10
        cmpi.w       #$ffff, rNightVisionInventorySlotIndex(a6)                            ; $001C14
        bne.b        loc_001C22                                    ; $001C1A
        movea.l      rZoneScenePalette(a6), a0                     ; $001C1C
        bra.b        loc_001C26                                    ; $001C20

loc_001C22:
        movea.l      rZoneEffectPalette(a6), a0                    ; $001C22

loc_001C26:
        move.l       #$c0000000, VDP_CONTROL.l                     ; $001C26
        movea.l      #VDP_DATA, a4                                 ; $001C30
        move.w       #$1f, d0                                      ; $001C36

loc_001C3A:
        move.l       (a0)+, (a4)                                   ; $001C3A
        dbra         d0, loc_001C3A                                ; $001C3C
        rts                                                        ; $001C40
        ifne *-$1C42
        fail "ROM end moved"
        endif
