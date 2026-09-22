; $013F36..$01417B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Flamethrower: save OLD phase; old1/2/3 emit particles. Hold at old3 keeps phase3 and costs $40 per continuation. Release still emits final old3 particle; old4 clears without emission.
        ifne *-$13F36
        fail "ROM start moved"
        endif

DrawAndEmitFlamethrower:
; Flamethrower: save OLD phase; old1/2/3 emit particles. Hold at old3 keeps phase3 and costs $40 per continuation. Release still emits final old3 particle; old4 clears without emission.
        addi.w       #$d9, d0                                      ; $013F36
        addi.w       #$114, d1                                     ; $013F3A
        move.w       rWeaponActionPhase(a6), d7                    ; $013F3E
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $013F42
        move.w       rWeaponActionPhase(a6), d3                    ; $013F46
        beq.b        loc_013F64                                    ; $013F4A
        move.b       (a0, d3.w), d2                                ; $013F4C
        ext.w        d2                                            ; $013F50
        add.w        d2, d0                                        ; $013F52
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013F54
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013F58
        bne.b        loc_013F64                                    ; $013F5E
        clr.w        rWeaponActionPhase(a6)                        ; $013F60

loc_013F64:
        movea.l      -$7fc2(a6), a2                                ; $013F64
        move.w       d0, (a2)+                                     ; $013F68
        move.w       -$7fbe(a6), d2                                ; $013F6A
        ori.w        #$b00, d2                                     ; $013F6E
        addq.w       #$1, -$7fbe(a6)                               ; $013F72
        move.w       d2, (a2)+                                     ; $013F76
        move.w       #$a4ef, (a2)+                                 ; $013F78
        move.w       d1, (a2)+                                     ; $013F7C
        move.l       a2, -$7fc2(a6)                                ; $013F7E
        tst.w        rPlayerDeathTicks(a6)                         ; $013F82
        bne.w        loc_01417A                                    ; $013F86
        cmpi.w       #$2, d7                                       ; $013F8A
        beq.w        loc_01403E                                    ; $013F8E
        cmpi.w       #$3, d7                                       ; $013F92
        beq.b        loc_013FBC                                    ; $013F96
        cmpi.w       #$1, d7                                       ; $013F98
        bne.w        loc_01417A                                    ; $013F9C
        clr.w        -$55a0(a6)                                    ; $013FA0
        clr.w        -$559e(a6)                                    ; $013FA4
        move.w       #$37, d0                                      ; $013FA8
        jsr          SoundRoutine_00DF84.l                         ; $013FAC
        move.w       #$14, -$559e(a6)                              ; $013FB2
        bra.w        loc_01403E                                    ; $013FB8

loc_013FBC:
        btst.b       #$4, rControllerState(a6)                     ; $013FBC
        beq.b        loc_01403E                                    ; $013FC2
        move.w       #$3, rWeaponActionPhase(a6)                   ; $013FC4

loc_013FCA:
        tst.w        -$7ffe(a6)                                    ; $013FCA
        bne.b        loc_013FCA                                    ; $013FCE
        clr.w        d0                                            ; $013FD0
        move.b       rSelectedInventorySlot(a6), d0                ; $013FD2
        lsl.w        #$8, d0                                       ; $013FD6
        lsl.w        #$1, d0                                       ; $013FD8
        addi.w       #$93e0, d0                                    ; $013FDA
        move.w       d0, d5                                        ; $013FDE
        movea.l      #VDP_DATA, a4                                 ; $013FE0
        lea.l        rInventorySlots(a6), a0                       ; $013FE6
        clr.w        d0                                            ; $013FEA
        move.b       rSelectedInventorySlot(a6), d0                ; $013FEC
        mulu.w       #$4, d0                                       ; $013FF0
        cmpi.w       #$40, $2(a0, d0.w)                            ; $013FF4
        bhi.b        loc_014008                                    ; $013FFA
        bsr.w        ExhaustSelectedItemAndEraseHud                ; $013FFC
        move.w       #$4, rWeaponActionPhase(a6)                   ; $014000
        bra.b        loc_01403E                                    ; $014006

loc_014008:
        subi.w       #$40, $2(a0, d0.w)                            ; $014008
        move.w       $2(a0, d0.w), -(a7)                           ; $01400E
        move.w       d5, d0                                        ; $014012
        addi.w       #$68, d0                                      ; $014014
        move.w       d0, d1                                        ; $014018
        andi.w       #$3fff, d1                                    ; $01401A
        ori.w        #$4000, d1                                    ; $01401E
        swap         d1                                            ; $014022
        lsr.w        #$8, d0                                       ; $014024
        lsr.w        #$6, d0                                       ; $014026
        move.w       d0, d1                                        ; $014028
        move.l       d1, VDP_CONTROL.l                             ; $01402A
        move.w       (a7)+, d0                                     ; $014030
        subq.w       #$1, d0                                       ; $014032
        lsr.w        #$8, d0                                       ; $014034
        addq.w       #$1, d0                                       ; $014036
        jsr          UiRoutine_020944.l                            ; $014038

loc_01403E:
        jsr          AllocateActor.l                               ; $01403E
        beq.w        loc_01417A                                    ; $014044
        move.b       #$ff, $38(a0)                                 ; $014048
        move.l       a0, -(a7)                                     ; $01404E
        move.w       #$8, d1                                       ; $014050
        move.w       -$71b0(a6), d2                                ; $014054
        addi.w       #$40, d2                                      ; $014058
        jsr          SelectPlayerWeaponAimTarget.l                 ; $01405C
        movea.l      (a7)+, a0                                     ; $014062
        cmpa.l       #$0, a1                                       ; $014064
        beq.b        loc_0140A8                                    ; $01406A
        tst.w        rLinkRole(a6)                                 ; $01406C
        beq.b        loc_014080                                    ; $014070
        cmpa.l       #$ff123a, a1                                  ; $014072
        bne.b        loc_014080                                    ; $014078
        clr.w        d0                                            ; $01407A
        clr.w        d1                                            ; $01407C
        bra.b        loc_01408C                                    ; $01407E

loc_014080:
        move.w       $2e(a1), d0                                   ; $014080
        lsl.w        #$2, d0                                       ; $014084
        move.w       $30(a1), d1                                   ; $014086
        lsl.w        #$2, d1                                       ; $01408A

loc_01408C:
        add.w        $24(a1), d0                                   ; $01408C
        sub.w        rPlayerX(a6), d0                              ; $014090
        add.w        $26(a1), d1                                   ; $014094
        sub.w        rPlayerY(a6), d1                              ; $014098
        bsr.w        OctagonalDistance                             ; $01409C
        asr.w        #$7, d0                                       ; $0140A0
        addq.b       #$1, d0                                       ; $0140A2
        move.b       d0, $38(a0)                                   ; $0140A4

loc_0140A8:
        clr.b        $23(a0)                                       ; $0140A8
        move.l       #UpdateFlamethrowerParticle, ActorUpdateCallback(a0) ; $0140AC
        move.l       #loc_01CBA4, ActorDrawCallback(a0)            ; $0140B4
        move.w       -$71f2(a6), d0                                ; $0140BC
        asr.w        #$2, d0                                       ; $0140C0
        move.w       d0, $2e(a0)                                   ; $0140C2
        add.w        rPlayerX(a6), d0                              ; $0140C6
        move.w       d0, $24(a0)                                   ; $0140CA
        move.w       -$71f0(a6), d0                                ; $0140CE
        asr.w        #$2, d0                                       ; $0140D2
        move.w       d0, $30(a0)                                   ; $0140D4
        add.w        rPlayerY(a6), d0                              ; $0140D8
        move.w       d0, $26(a0)                                   ; $0140DC
        jsr          NextRandom.l                                  ; $0140E0
        asr.w        #$8, d2                                       ; $0140E6
        andi.w       #$1f, d2                                      ; $0140E8
        subi.w       #$10, d2                                      ; $0140EC
        add.w        d2, $2e(a0)                                   ; $0140F0
        swap         d2                                            ; $0140F4
        andi.w       #$1f, d2                                      ; $0140F6
        subi.w       #$10, d2                                      ; $0140FA
        add.w        d2, $30(a0)                                   ; $0140FE
        move.w       -$71d8(a6), d0                                ; $014102
        sub.w        -$6e4c(a6), d0                                ; $014106
        subi.w       #$c, d0                                       ; $01410A
        move.w       d0, $28(a0)                                   ; $01410E
        move.w       #$fffe, $32(a0)                               ; $014112
        jsr          ObjectsRoutine_00A3D2.l                       ; $014118
        beq.b        loc_014128                                    ; $01411E
        move.l       #$1c902, ActorUpdateCallback(a0)              ; $014120

loc_014128:
        tst.w        rLinkRole(a6)                                 ; $014128
        beq.b        loc_01417A                                    ; $01412C
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $01412E
        move.l       #$1edfe, ActorLinkCallback(a0)                ; $014136
        lea.l        -$6fdc(a6), a1                                ; $01413E
        move.b       #$4, (a1)+                                    ; $014142
        move.b       $42(a0), (a1)+                                ; $014146
        move.w       $24(a0), (a1)+                                ; $01414A
        move.w       $26(a0), (a1)+                                ; $01414E
        move.b       $29(a0), (a1)+                                ; $014152
        move.b       $5(a0), d0                                    ; $014156
        ori.w        #$20, d0                                      ; $01415A
        move.b       d0, (a1)+                                     ; $01415E
        move.b       $36(a0), (a1)+                                ; $014160
        move.b       #$4, (a1)+                                    ; $014164
        move.w       $2e(a0), (a1)+                                ; $014168
        move.w       $30(a0), (a1)+                                ; $01416C
        lea.l        -$6fdc(a6), a0                                ; $014170
        jsr          QueueLinkCommand.l                            ; $014174

loc_01417A:
        rts                                                        ; $01417A
        ifne *-$1417C
        fail "ROM end moved"
        endif
