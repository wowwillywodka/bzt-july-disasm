; $028B98..$028BB5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Copy the first 9 bytes of the scene-label buffer, append NUL in RAM, then call PrintCenteredText. Does not select a retained ROM floor-name string.
        ifne *-$28B98
        fail "ROM start moved"
        endif

PrintFirstSceneLabel:
; Copy the first 9 bytes of the scene-label buffer, append NUL in RAM, then call PrintCenteredText. Does not select a retained ROM floor-name string.
        lea.l        rSharedScratchBuffer(a6), a0                                ; $028B98
        move.w       d1, -(a7)                                     ; $028B9C
        bsr.w        CopyFirstSceneLabel                           ; $028B9E
        clr.b        (a0)+                                         ; $028BA2
        lea.l        rSharedScratchBuffer(a6), a0                                ; $028BA4
        move.w       #$eb00, d0                                    ; $028BA8
        jsr          PrintCenteredText.l                           ; $028BAC
        move.w       (a7)+, d1                                     ; $028BB2
        rts                                                        ; $028BB4
        ifne *-$28BB6
        fail "ROM end moved"
        endif
