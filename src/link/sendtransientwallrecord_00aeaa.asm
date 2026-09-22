; $00AEAA..$00AED7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Serialize link command $0A: floor, high coordinate bytes, absolute cell pointer and low opening-amount byte. It does not send final cell or mode.
        ifne *-$AEAA
        fail "ROM start moved"
        endif

SendTransientWallRecord:
; Serialize link command $0A: floor, high coordinate bytes, absolute cell pointer and low opening-amount byte. It does not send final cell or mode.
        movem.l      a0-a3, -(a7)                                  ; $00AEAA
        lea.l        -$6fdc(a6), a0                                ; $00AEAE
        move.b       #$a, (a0)+                                    ; $00AEB2
        move.b       WallRecordFloor(a3), (a0)+                    ; $00AEB6
        move.b       WallRecordX(a3), (a0)+                        ; $00AEBA
        move.b       WallRecordY(a3), (a0)+                        ; $00AEBE
        move.l       (a3), (a0)+                                   ; $00AEC2
        move.b       $5(a3), (a0)                                  ; $00AEC4
        lea.l        -$6fdc(a6), a0                                ; $00AEC8
        jsr          QueueLinkCommand.l                            ; $00AECC
        movem.l      (a7)+, a0-a3                                  ; $00AED2
        rts                                                        ; $00AED6
        ifne *-$AED8
        fail "ROM end moved"
        endif
