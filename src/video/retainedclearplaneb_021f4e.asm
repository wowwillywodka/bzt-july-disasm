; $021F4E..$021F8B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$21F4E
        fail "ROM start moved"
        endif

RetainedClearPlaneB:
        move.l       d0, -(a7)                                     ; $021F4E
        move.w       #$0, d0                                       ; $021F50
        move.w       #$0, d1                                       ; $021F54
        move.w       #$40, d2                                      ; $021F58
        jsr          CalculateTilemapAddress(pc)                   ; $021F5C
        adda.l       #$e000, a1                                    ; $021F60
        move.l       a1, d4                                        ; $021F66
        lsl.l        #$2, d4                                       ; $021F68
        lsr.w        #$2, d4                                       ; $021F6A
        swap         d4                                            ; $021F6C
        bset.l       #$1e, d4                                      ; $021F6E
        andi.l       #$7fff0003, d4                                ; $021F72
        move.l       d4, VDP_CONTROL.l                             ; $021F78
        move.l       (a7)+, d0                                     ; $021F7E
        move.l       #$1000, d1                                    ; $021F80
        jsr          FillVdpWords(pc)                              ; $021F86
        rts                                                        ; $021F8A
        ifne *-$21F8C
        fail "ROM end moved"
        endif
