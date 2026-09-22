; $01CF9A..$01D12F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Snowman particle: corresponding local instructions and hit behavior match flamethrower; global current weapon is not rewritten. No freezing status is assigned by this callback itself.
        ifne *-$1CF9A
        fail "ROM start moved"
        endif

UpdateSnowmanParticle:
; Snowman particle: corresponding local instructions and hit behavior match flamethrower; global current weapon is not rewritten. No freezing status is assigned by this callback itself.
        clr.b        ActorUpdateDelay(a0)                          ; $01CF9A
        subq.b       #$1, ActorState(a0)                           ; $01CF9E
        beq.b        loc_01CFD4                                    ; $01CFA2
        move.w       ActorVelocityZ(a0), d0                        ; $01CFA4
        sub.w        d0, ActorZ(a0)                                ; $01CFA8
        addq.w       #$1, ActorVelocityZ(a0)                       ; $01CFAC
        cmpi.w       #$ffe4, ActorZ(a0)                            ; $01CFB0
        blt.b        loc_01CFD4                                    ; $01CFB6
        bsr.w        GetVisibleMapBase                             ; $01CFB8
        move.w       ActorX(a0), d0                                ; $01CFBC
        add.w        ActorMotionX(a0), d0                          ; $01CFC0
        move.w       ActorY(a0), d1                                ; $01CFC4
        add.w        ActorMotionY(a0), d1                          ; $01CFC8
        bsr.w        TestProjectilePointInActiveWindow             ; $01CFCC
        beq.w        loc_01D126                                    ; $01CFD0

loc_01CFD4:
        move.b       #$1, -$55be(a6)                               ; $01CFD4
        move.b       #$1, -$55bd(a6)                               ; $01CFDA
        move.w       ActorX(a0), d0                                ; $01CFE0
        move.w       ActorY(a0), d1                                ; $01CFE4
        clr.w        d5                                            ; $01CFE8
        move.b       ActorFloor(a0), d5                            ; $01CFEA
        move.l       a0, -(a7)                                     ; $01CFEE
        move.w       rActiveActorCount(a6), d7                     ; $01CFF0
        beq.b        loc_01D070                                    ; $01CFF4
        subq.w       #$1, d7                                       ; $01CFF6
        movea.l      rActiveActorHead(a6), a0                      ; $01CFF8

loc_01CFFC:
        movem.w      d0-d1/d5/d7, -(a7)                            ; $01CFFC
        move.l       (a0), -(a7)                                   ; $01D000
        move.w       ActorFlags(a0), d3                            ; $01D002
        andi.w       #$c8, d3                                      ; $01D006
        beq.b        loc_01D066                                    ; $01D00A
        cmp.b        ActorFloor(a0), d5                            ; $01D00C
        bne.b        loc_01D066                                    ; $01D010
        movem.w      d0-d1, -(a7)                                  ; $01D012
        move.w       ActorX(a0), d3                                ; $01D016
        move.w       ActorY(a0), d4                                ; $01D01A
        bsr.w        TraceObstructionInActiveWindow                ; $01D01E
        beq.b        loc_01D02A                                    ; $01D022
        movem.w      (a7)+, d0-d1                                  ; $01D024
        bra.b        loc_01D066                                    ; $01D028

loc_01D02A:
        movem.w      (a7)+, d0-d1                                  ; $01D02A
        sub.w        ActorX(a0), d0                                ; $01D02E
        sub.w        ActorY(a0), d1                                ; $01D032
        move.w       d0, d3                                        ; $01D036
        move.w       d1, d4                                        ; $01D038
        jsr          OctagonalDistance.l                           ; $01D03A
        cmpi.w       #$100, d0                                     ; $01D040
        bcc.b        loc_01D066                                    ; $01D044
        movea.l      ActorHitCallback(a0), a1                      ; $01D046
        move.l       a0, -(a7)                                     ; $01D04A
        move.w       -$6fe0(a6), -(a7)                             ; $01D04C
        move.w       #$10, -$6fe0(a6)                              ; $01D050
        jsr          (a1)                                          ; $01D056
        move.w       (a7)+, -$6fe0(a6)                             ; $01D058
        movea.l      (a7)+, a0                                     ; $01D05C
        clr.w        ActorMotionX(a0)                              ; $01D05E
        clr.w        ActorMotionY(a0)                              ; $01D062

loc_01D066:
        movea.l      (a7)+, a0                                     ; $01D066
        movem.w      (a7)+, d0-d1/d5/d7                            ; $01D068
        dbra         d7, loc_01CFFC                                ; $01D06C

loc_01D070:
        cmp.w        rCurrentFloor(a6), d5                         ; $01D070
        bne.b        loc_01D0B2                                    ; $01D074
        movem.w      d0-d1, -(a7)                                  ; $01D076
        move.w       rPlayerX(a6), d3                              ; $01D07A
        move.w       rPlayerY(a6), d4                              ; $01D07E
        bsr.w        TraceObstructionInVisibleMap                  ; $01D082
        beq.b        loc_01D08E                                    ; $01D086
        movem.w      (a7)+, d0-d1                                  ; $01D088
        bra.b        loc_01D0B2                                    ; $01D08C

loc_01D08E:
        movem.w      (a7)+, d0-d1                                  ; $01D08E
        sub.w        rPlayerX(a6), d0                              ; $01D092
        sub.w        rPlayerY(a6), d1                              ; $01D096
        move.w       d0, d3                                        ; $01D09A
        move.w       d1, d4                                        ; $01D09C
        jsr          OctagonalDistance.l                           ; $01D09E
        cmpi.w       #$30, d0                                      ; $01D0A4
        bcc.w        loc_01D0B2                                    ; $01D0A8
        jsr          UiRoutine_00E000.l                            ; $01D0AC

loc_01D0B2:
        clr.b        -$55be(a6)                                    ; $01D0B2
        clr.b        -$55bd(a6)                                    ; $01D0B6
        move.w       #$38, d0                                      ; $01D0BA
        jsr          SoundRoutine_00DF64.l                         ; $01D0BE
        movea.l      (a7)+, a0                                     ; $01D0C4
        clr.b        ActorUpdateDelay(a0)                          ; $01D0C6
        clr.b        ActorEffectCounter(a0)                        ; $01D0CA
        move.l       #$1cd78, ActorUpdateCallback(a0)              ; $01D0CE
        move.l       #$1cdb0, ActorDrawCallback(a0)                ; $01D0D6
        move.w       #$ffe0, ActorZ(a0)                            ; $01D0DE
        clr.b        ActorUpdateDelay(a0)                          ; $01D0E4
        clr.b        ActorEffectCounter(a0)                        ; $01D0E8
        andi.w       #$ff37, ActorFlags(a0)                        ; $01D0EC
        tst.w        rLinkRole(a6)                                 ; $01D0F2
        bne.b        loc_01D0FA                                    ; $01D0F6
        rts                                                        ; $01D0F8

loc_01D0FA:
        move.l       #$1ee78, ActorLinkCallback(a0)                ; $01D0FA
        lea.l        -$6fdc(a6), a1                                ; $01D102
        move.b       #$12, (a1)+                                   ; $01D106
        move.b       ActorLinkId(a0), (a1)+                        ; $01D10A
        move.w       ActorFlags(a0), d0                            ; $01D10E
        ori.w        #$20, d0                                      ; $01D112
        move.b       d0, (a1)+                                     ; $01D116
        move.b       ActorFloor(a0), (a1)+                         ; $01D118
        lea.l        -$6fdc(a6), a0                                ; $01D11C
        jmp          QueueLinkCommand.l                            ; $01D120

loc_01D126:
        move.w       d0, ActorX(a0)                                ; $01D126
        move.w       d1, ActorY(a0)                                ; $01D12A
        rts                                                        ; $01D12E
        ifne *-$1D130
        fail "ROM end moved"
        endif
