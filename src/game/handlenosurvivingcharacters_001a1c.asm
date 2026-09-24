; $001A1C..$001A4F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; All five characters unavailable: optional link command $17, disabled briefing reason 5, return D7=0. Normal caller returns to hardware/title initialization.
        ifne *-$1A1C
        fail "ROM start moved"
        endif

HandleNoSurvivingCharacters:
; All five characters unavailable: optional link command $17, disabled briefing reason 5, return D7=0. Normal caller returns to hardware/title initialization.
        tst.w        rLinkRole(a6)                                 ; $001A1C
        beq.b        loc_001A36                                    ; $001A20
        lea.l        rSharedScratchBuffer(a6), a0                                ; $001A22
        move.b       #$17, (a0)                                    ; $001A26
        jsr          QueueLinkCommand.l                            ; $001A2A
        jsr          ServiceLinkUntilTxQueueEmpty.l                         ; $001A30

loc_001A36:
        move.w       #$5, d0                                       ; $001A36
        movea.l      #ActorNoOp, a1                                ; $001A3A
        jsr          DisabledBriefingEntry.l                       ; $001A40
        bsr.w        InitializeVdpRegisters                        ; $001A46
        move.w       #$0, d7                                       ; $001A4A
        rts                                                        ; $001A4E
        ifne *-$1A50
        fail "ROM end moved"
        endif
