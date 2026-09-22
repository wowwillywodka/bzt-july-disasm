; $00A178..$00A1CF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$A178
        fail "ROM start moved"
        endif

RetainedReplaceInteractionCell:
        move.l       a0, -$42a2(a6)                                ; $00A178
        bsr.w        EnvironmentRoutine_00D166                     ; $00A17C
        cmpa.l       #$ffa5fa, a0                                  ; $00A180
        bcs.b        loc_00A190                                    ; $00A186
        cmpa.l       #$ffe5fa, a0                                  ; $00A188
        bcs.b        loc_00A196                                    ; $00A18E

loc_00A190:
        movea.l      #$ffa9fa, a0                                  ; $00A190

loc_00A196:
        move.b       $c68(a6), (a0)                                ; $00A196
        jsr          CommitMapCellAndSendLink.l                    ; $00A19A
        bra.w        loc_00A298                                    ; $00A1A0

loc_00A1A4:
        move.l       a0, -$42a2(a6)                                ; $00A1A4
        bsr.w        EnvironmentRoutine_00D166                     ; $00A1A8
        cmpa.l       #$ffa5fa, a0                                  ; $00A1AC
        bcs.b        loc_00A1BC                                    ; $00A1B2
        cmpa.l       #$ffe5fa, a0                                  ; $00A1B4
        bcs.b        loc_00A1C2                                    ; $00A1BA

loc_00A1BC:
        movea.l      #$ffa9fa, a0                                  ; $00A1BC

loc_00A1C2:
        move.b       $c6a(a6), (a0)                                ; $00A1C2
        jsr          CommitMapCellAndSendLink.l                    ; $00A1C6
        bra.w        loc_00A298                                    ; $00A1CC
        ifne *-$A1D0
        fail "ROM end moved"
        endif
