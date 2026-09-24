; $01D25A..$01D305 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1D25A
        fail "ROM start moved"
        endif

RetainedActorNeighborProbe:
        bsr.w        GetVisibleMapBase                             ; $01D25A
        move.w       ActorX(a0), d0                                ; $01D25E
        asr.w        #$8, d0                                       ; $01D262
        adda.w       d0, a1                                        ; $01D264
        move.w       ActorY(a0), d0                                ; $01D266
        clr.b        d0                                            ; $01D26A
        asr.w        #$3, d0                                       ; $01D26C
        adda.w       d0, a1                                        ; $01D26E
        tst.b        (a1)                                          ; $01D270
        beq.b        loc_01D2AA                                    ; $01D272
        subq.w       #$1, a1                                       ; $01D274
        tst.b        (a1)                                          ; $01D276
        beq.b        loc_01D2AA                                    ; $01D278
        addq.w       #$2, a1                                       ; $01D27A
        tst.b        (a1)                                          ; $01D27C
        beq.b        loc_01D2AA                                    ; $01D27E
        suba.w       #$21, a1                                      ; $01D280
        tst.b        (a1)                                          ; $01D284
        beq.b        loc_01D2AA                                    ; $01D286
        adda.w       #$40, a1                                      ; $01D288
        tst.b        (a1)                                          ; $01D28C
        beq.b        loc_01D2AA                                    ; $01D28E
        subq.w       #$1, a1                                       ; $01D290
        tst.b        (a1)                                          ; $01D292
        beq.b        loc_01D2AA                                    ; $01D294
        addq.w       #$2, a1                                       ; $01D296
        tst.b        (a1)                                          ; $01D298
        beq.b        loc_01D2AA                                    ; $01D29A
        suba.w       #$40, a1                                      ; $01D29C
        tst.b        (a1)                                          ; $01D2A0
        beq.b        loc_01D2AA                                    ; $01D2A2
        subq.w       #$2, a1                                       ; $01D2A4
        tst.b        (a1)                                          ; $01D2A6
        bne.b        loc_01D304                                    ; $01D2A8

loc_01D2AA:
        lea.l        rCellIndexByType(a6), a2                      ; $01D2AA
        clr.w        d0                                            ; $01D2AE
        move.b       ActorCorpseCellProfile(a0), d0                ; $01D2B0
        cmpa.l       #$ffa5fa, a1                                  ; $01D2B4
        bcs.b        loc_01D2C4                                    ; $01D2BA
        cmpa.l       #$ffe5fa, a1                                  ; $01D2BC
        bcs.b        loc_01D2CA                                    ; $01D2C2

loc_01D2C4:
        movea.l      #$ffa9fa, a1                                  ; $01D2C4

loc_01D2CA:
        move.b       (a2, d0.w), (a1)                              ; $01D2CA
        move.l       a0, -(a7)                                     ; $01D2CE
        movea.l      a1, a0                                        ; $01D2D0
        jsr          CommitMapCellAndSendLink.l                    ; $01D2D2
        movea.l      (a7)+, a0                                     ; $01D2D8
        tst.w        rLinkRole(a6)                                 ; $01D2DA
        beq.w        RemoveActor                                   ; $01D2DE
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01D2E2
        move.b       #$5, (a1)                                     ; $01D2E6
        move.b       ActorLinkId(a0), $1(a1)                       ; $01D2EA
        movem.l      d0-d7/a0-a3, -(a7)                            ; $01D2F0
        movea.l      a1, a0                                        ; $01D2F4
        jsr          QueueLinkCommand.l                            ; $01D2F6
        movem.l      (a7)+, d0-d7/a0-a3                            ; $01D2FC
        bra.w        RemoveActor                                   ; $01D300

loc_01D304:
        rts                                                        ; $01D304
        ifne *-$1D306
        fail "ROM end moved"
        endif
