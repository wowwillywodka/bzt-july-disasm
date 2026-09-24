; $00BBEA..$00BC21 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Request current floor +1; the transition record supplies actual target floor, which may jump by more than one or stay on the same floor. Link packet writes current floor -1 in this original path.
        ifne *-$BBEA
        fail "ROM start moved"
        endif

RequestHigherFloorTransition:
; Request current floor +1; the transition record supplies actual target floor, which may jump by more than one or stay on the same floor. Link packet writes current floor -1 in this original path.
        movem.l      d0-d1/a0-a1, -(a7)                            ; $00BBEA
        tst.w        rLinkRole(a6)                                 ; $00BBEE
        beq.b        loc_00BC14                                    ; $00BBF2
        lea.l        rSharedScratchBuffer(a6), a1                                ; $00BBF4
        move.b       #$12, (a1)+                                   ; $00BBF8
        clr.b        (a1)+                                         ; $00BBFC

loc_00BBFE:
        move.b       #$fa, (a1)+                                   ; $00BBFE
        move.b       rCurrentFloorLow(a6), d0                      ; $00BC02
        subq.b       #$1, d0                                       ; $00BC06
        move.b       d0, (a1)+                                     ; $00BC08
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00BC0A
        jsr          QueueLinkCommand.l                            ; $00BC0E

loc_00BC14:
        movem.l      (a7)+, d0-d1/a0-a1                            ; $00BC14
        move.w       rCurrentFloor(a6), d0                         ; $00BC18
        addq.w       #$1, d0                                       ; $00BC1C
        bra.w        ResolvePlayerFloorTransition                  ; $00BC1E
        ifne *-$BC22
        fail "ROM end moved"
        endif
