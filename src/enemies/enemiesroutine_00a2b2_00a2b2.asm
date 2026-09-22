; $00A2B2..$00A3D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [аналог June 9EE0] СПАВН-КЛЕТКА ct 0x26 July: спавн врага при приближении
        ifne *-$A2B2
        fail "ROM start moved"
        endif

EnemiesRoutine_00A2B2:
        tst.w        -$715a(a6)                                    ; $00A2B2
        bne.w        BuildEmptyCellProfile                         ; $00A2B6
        movem.w      d0-d2, -(a7)                                  ; $00A2BA
        add.w        rPlayerCellX(a6), d0                          ; $00A2BE
        lsl.w        #$8, d0                                       ; $00A2C2
        addi.w       #$80, d0                                      ; $00A2C4
        sub.w        rPlayerX(a6), d0                              ; $00A2C8
        add.w        rPlayerCellY(a6), d1                          ; $00A2CC
        lsl.w        #$8, d1                                       ; $00A2D0
        addi.w       #$80, d1                                      ; $00A2D2
        sub.w        rPlayerY(a6), d1                              ; $00A2D6
        bsr.w        OctagonalDistance                             ; $00A2DA
        cmpi.w       #$a00, d0                                     ; $00A2DE
        bcs.b        loc_00A2F2                                    ; $00A2E2
        movem.w      (a7)+, d0-d2                                  ; $00A2E4
        jsr          QueueProjectedWorldObject.l                   ; $00A2E8
        clr.w        d3                                            ; $00A2EE
        rts                                                        ; $00A2F0

loc_00A2F2:
        movem.w      (a7)+, d0-d2                                  ; $00A2F2
        movem.l      d0/a0-a1, -(a7)                               ; $00A2F6
        cmpa.l       #$ffa5fa, a0                                  ; $00A2FA
        bcs.b        loc_00A30A                                    ; $00A300
        cmpa.l       #$ffe5fa, a0                                  ; $00A302
        bcs.b        loc_00A310                                    ; $00A308

loc_00A30A:
        movea.l      #$ffa9fa, a0                                  ; $00A30A

loc_00A310:
        clr.b        (a0)                                          ; $00A310
        jsr          CommitMapCellAndSendLink.l                    ; $00A312
        move.w       d0, d3                                        ; $00A318
        jsr          AllocateActor.l                               ; $00A31A
        beq.w        loc_00A3C4                                    ; $00A320
        clr.b        $23(a0)                                       ; $00A324
        move.l       #UpdateProximityWallCharge, ActorUpdateCallback(a0) ; $00A328
        move.l       #loc_01DEE4, ActorDrawCallback(a0)            ; $00A330
        move.l       #$1dfbc, ActorHitCallback(a0)                 ; $00A338
        move.l       #EnvironmentRoutine_01E040, ActorExitCallback(a0) ; $00A340
        ori.w        #$84, $4(a0)                                  ; $00A348
        move.w       #$64, $3a(a0)                                 ; $00A34E
        add.w        rPlayerCellX(a6), d3                          ; $00A354
        lsl.w        #$8, d3                                       ; $00A358
        addi.w       #$80, d3                                      ; $00A35A
        move.w       d3, $24(a0)                                   ; $00A35E
        move.w       d1, d3                                        ; $00A362
        add.w        rPlayerCellY(a6), d3                          ; $00A364
        lsl.w        #$8, d3                                       ; $00A368
        addi.w       #$80, d3                                      ; $00A36A
        move.w       d3, $26(a0)                                   ; $00A36E
        clr.w        $28(a0)                                       ; $00A372
        clr.b        $38(a0)                                       ; $00A376
        move.b       rCurrentFloorLow(a6), $36(a0)                 ; $00A37A
        tst.w        rLinkRole(a6)                                 ; $00A380
        beq.b        loc_00A3BC                                    ; $00A384
        movem.l      d0-d7/a0-a3, -(a7)                            ; $00A386
        lea.l        -$6fdc(a6), a1                                ; $00A38A
        move.b       #$4, (a1)+                                    ; $00A38E
        move.b       $42(a0), (a1)+                                ; $00A392
        move.w       $24(a0), (a1)+                                ; $00A396
        move.w       $26(a0), (a1)+                                ; $00A39A
        move.b       $29(a0), (a1)+                                ; $00A39E
        move.b       #$a4, (a1)+                                   ; $00A3A2
        move.b       rCurrentFloorLow(a6), (a1)+                   ; $00A3A6
        move.b       #$7, (a1)+                                    ; $00A3AA
        lea.l        -$6fdc(a6), a0                                ; $00A3AE
        jsr          QueueLinkCommand.l                            ; $00A3B2
        movem.l      (a7)+, d0-d7/a0-a3                            ; $00A3B8

loc_00A3BC:
        movem.l      (a7)+, d0/a0-a1                               ; $00A3BC
        clr.w        d3                                            ; $00A3C0
        rts                                                        ; $00A3C2

loc_00A3C4:
        movem.l      (a7)+, d0/a0-a1                               ; $00A3C4
        jsr          QueueProjectedWorldObject.l                   ; $00A3C8
        clr.w        d3                                            ; $00A3CE
        rts                                                        ; $00A3D0
        ifne *-$A3D2
        fail "ROM end moved"
        endif
