; $0974FA..$09754F | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$974FA
        fail "ROM start moved"
        endif

UpdatePlayerCellCoordinates:
        move.w       rPlayerX(a6), d0                              ; $0974FA
        asr.w        #$8, d0                                       ; $0974FE
        move.w       d0, rPlayerCellX(a6)                          ; $097500
        move.w       rPlayerY(a6), d0                              ; $097504
        asr.w        #$8, d0                                       ; $097508
        move.w       d0, rPlayerCellY(a6)                          ; $09750A
        move.w       rPlayerX(a6), d0                              ; $09750E
        andi.w       #$ff, d0                                      ; $097512
        move.w       d0, -$71e4(a6)                                ; $097516
        neg.w        d0                                            ; $09751A
        addi.w       #$ff, d0                                      ; $09751C
        move.w       d0, -$71e8(a6)                                ; $097520
        move.w       rPlayerY(a6), d0                              ; $097524
        andi.w       #$ff, d0                                      ; $097528
        move.w       d0, -$71e2(a6)                                ; $09752C
        neg.w        d0                                            ; $097530
        addi.w       #$ff, d0                                      ; $097532
        move.w       d0, -$71e6(a6)                                ; $097536
        movea.l      rVisibleMapBasePointer(a6), a0                ; $09753A
        adda.w       rPlayerCellX(a6), a0                          ; $09753E
        move.w       rPlayerCellY(a6), d0                          ; $097542
        lsl.w        #$5, d0                                       ; $097546
        adda.w       d0, a0                                        ; $097548
        move.l       a0, rPlayerCellPointer(a6)                    ; $09754A
        rts                                                        ; $09754E
        ifne *-$97550
        fail "ROM end moved"
        endif
