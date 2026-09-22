; $023B9E..$023C15 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$23B9E
        fail "ROM start moved"
        endif

RetainedMenuReturnToTitle:
        move.w       #$1, -$778c(a6)                               ; $023B9E
        move.w       #$0, rLegacyEpisodeSelection(a6)              ; $023BA4
        move.w       #$1, rDemoMode(a6)                            ; $023BAA
        jsr          WaitForVBlank.l                               ; $023BB0
        move.w       #$8124, VDP_CONTROL.l                         ; $023BB6
        jsr          InitializeVdpRegisters.l                      ; $023BBE
        move.l       #$c0000000, VDP_CONTROL.l                     ; $023BC4
        movea.l      #VDP_DATA, a4                                 ; $023BCE
        moveq        #$0, d6                                       ; $023BD4
        move.w       #$1f, d7                                      ; $023BD6

loc_023BDA:
        move.l       d6, (a4)                                      ; $023BDA
        dbra         d7, loc_023BDA                                ; $023BDC
        move.l       #$7c000002, VDP_CONTROL.l                     ; $023BE0
        move.l       d6, (a4)                                      ; $023BEA
        move.l       #$40000010, VDP_CONTROL.l                     ; $023BEC
        move.l       d6, (a4)                                      ; $023BF6
        move.l       #$78000002, VDP_CONTROL.l                     ; $023BF8
        move.l       d6, (a4)                                      ; $023C02
        move.l       d6, (a4)                                      ; $023C04
        jsr          WaitForVBlank.l                               ; $023C06
        move.w       #$8164, VDP_CONTROL.l                         ; $023C0C
        rts                                                        ; $023C14
        ifne *-$23C16
        fail "ROM end moved"
        endif
