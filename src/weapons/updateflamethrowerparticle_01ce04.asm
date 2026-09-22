; $01CE04..$01CF99 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Flamethrower particle: byte fuse, Z-=VelocityZ then VelocityZ++; Z<-28 or blocked next point finishes. Finish scans same-floor flags&C8, single ray and distance<$100, invokes hit under temporary FF1020=16, clears target XY motion, then becomes ground-fire effect.
        ifne *-$1CE04
        fail "ROM start moved"
        endif

UpdateFlamethrowerParticle:
; Flamethrower particle: byte fuse, Z-=VelocityZ then VelocityZ++; Z<-28 or blocked next point finishes. Finish scans same-floor flags&C8, single ray and distance<$100, invokes hit under temporary FF1020=16, clears target XY motion, then becomes ground-fire effect.
        clr.b        ActorUpdateDelay(a0)                          ; $01CE04
        subq.b       #$1, ActorState(a0)                           ; $01CE08
        beq.b        loc_01CE3E                                    ; $01CE0C
        move.w       ActorVelocityZ(a0), d0                        ; $01CE0E
        sub.w        d0, ActorZ(a0)                                ; $01CE12
        addq.w       #$1, ActorVelocityZ(a0)                       ; $01CE16
        cmpi.w       #$ffe4, ActorZ(a0)                            ; $01CE1A
        blt.b        loc_01CE3E                                    ; $01CE20
        bsr.w        GetVisibleMapBase                             ; $01CE22
        move.w       ActorX(a0), d0                                ; $01CE26
        add.w        ActorMotionX(a0), d0                          ; $01CE2A
        move.w       ActorY(a0), d1                                ; $01CE2E
        add.w        ActorMotionY(a0), d1                          ; $01CE32
        bsr.w        TestProjectilePointInActiveWindow             ; $01CE36
        beq.w        loc_01CF90                                    ; $01CE3A

loc_01CE3E:
        move.b       #$1, -$55be(a6)                               ; $01CE3E
        move.b       #$1, -$55bd(a6)                               ; $01CE44
        move.w       ActorX(a0), d0                                ; $01CE4A
        move.w       ActorY(a0), d1                                ; $01CE4E
        clr.w        d5                                            ; $01CE52
        move.b       ActorFloor(a0), d5                            ; $01CE54
        move.l       a0, -(a7)                                     ; $01CE58
        move.w       rActiveActorCount(a6), d7                     ; $01CE5A
        beq.b        loc_01CEDA                                    ; $01CE5E
        subq.w       #$1, d7                                       ; $01CE60
        movea.l      rActiveActorHead(a6), a0                      ; $01CE62

loc_01CE66:
        movem.w      d0-d1/d5/d7, -(a7)                            ; $01CE66
        move.l       (a0), -(a7)                                   ; $01CE6A
        move.w       ActorFlags(a0), d3                            ; $01CE6C
        andi.w       #$c8, d3                                      ; $01CE70
        beq.b        loc_01CED0                                    ; $01CE74
        cmp.b        ActorFloor(a0), d5                            ; $01CE76
        bne.b        loc_01CED0                                    ; $01CE7A
        movem.w      d0-d1, -(a7)                                  ; $01CE7C
        move.w       ActorX(a0), d3                                ; $01CE80
        move.w       ActorY(a0), d4                                ; $01CE84
        bsr.w        TraceObstructionInActiveWindow                ; $01CE88
        beq.b        loc_01CE94                                    ; $01CE8C
        movem.w      (a7)+, d0-d1                                  ; $01CE8E
        bra.b        loc_01CED0                                    ; $01CE92

loc_01CE94:
        movem.w      (a7)+, d0-d1                                  ; $01CE94
        sub.w        ActorX(a0), d0                                ; $01CE98
        sub.w        ActorY(a0), d1                                ; $01CE9C
        move.w       d0, d3                                        ; $01CEA0
        move.w       d1, d4                                        ; $01CEA2
        jsr          OctagonalDistance.l                           ; $01CEA4
        cmpi.w       #$100, d0                                     ; $01CEAA
        bcc.b        loc_01CED0                                    ; $01CEAE
        movea.l      ActorHitCallback(a0), a1                      ; $01CEB0
        move.l       a0, -(a7)                                     ; $01CEB4
        move.w       -$6fe0(a6), -(a7)                             ; $01CEB6
        move.w       #$10, -$6fe0(a6)                              ; $01CEBA
        jsr          (a1)                                          ; $01CEC0
        move.w       (a7)+, -$6fe0(a6)                             ; $01CEC2
        movea.l      (a7)+, a0                                     ; $01CEC6
        clr.w        ActorMotionX(a0)                              ; $01CEC8
        clr.w        ActorMotionY(a0)                              ; $01CECC

loc_01CED0:
        movea.l      (a7)+, a0                                     ; $01CED0
        movem.w      (a7)+, d0-d1/d5/d7                            ; $01CED2
        dbra         d7, loc_01CE66                                ; $01CED6

loc_01CEDA:
        cmp.w        rCurrentFloor(a6), d5                         ; $01CEDA
        bne.b        loc_01CF1C                                    ; $01CEDE
        movem.w      d0-d1, -(a7)                                  ; $01CEE0
        move.w       rPlayerX(a6), d3                              ; $01CEE4
        move.w       rPlayerY(a6), d4                              ; $01CEE8
        bsr.w        TraceObstructionInVisibleMap                  ; $01CEEC
        beq.b        loc_01CEF8                                    ; $01CEF0
        movem.w      (a7)+, d0-d1                                  ; $01CEF2
        bra.b        loc_01CF1C                                    ; $01CEF6

loc_01CEF8:
        movem.w      (a7)+, d0-d1                                  ; $01CEF8
        sub.w        rPlayerX(a6), d0                              ; $01CEFC
        sub.w        rPlayerY(a6), d1                              ; $01CF00
        move.w       d0, d3                                        ; $01CF04
        move.w       d1, d4                                        ; $01CF06
        jsr          OctagonalDistance.l                           ; $01CF08
        cmpi.w       #$30, d0                                      ; $01CF0E
        bcc.w        loc_01CF1C                                    ; $01CF12
        jsr          UiRoutine_00E000.l                            ; $01CF16

loc_01CF1C:
        clr.b        -$55be(a6)                                    ; $01CF1C
        clr.b        -$55bd(a6)                                    ; $01CF20
        move.w       #$38, d0                                      ; $01CF24
        jsr          SoundRoutine_00DF64.l                         ; $01CF28
        movea.l      (a7)+, a0                                     ; $01CF2E
        clr.b        ActorUpdateDelay(a0)                          ; $01CF30
        clr.b        ActorEffectCounter(a0)                        ; $01CF34
        move.l       #$1cd78, ActorUpdateCallback(a0)              ; $01CF38
        move.l       #$1cdb0, ActorDrawCallback(a0)                ; $01CF40
        move.w       #$ffe0, ActorZ(a0)                            ; $01CF48
        clr.b        ActorUpdateDelay(a0)                          ; $01CF4E
        clr.b        ActorEffectCounter(a0)                        ; $01CF52
        andi.w       #$ff37, ActorFlags(a0)                        ; $01CF56
        tst.w        rLinkRole(a6)                                 ; $01CF5C
        bne.b        loc_01CF64                                    ; $01CF60
        rts                                                        ; $01CF62

loc_01CF64:
        move.l       #$1ee78, ActorLinkCallback(a0)                ; $01CF64
        lea.l        -$6fdc(a6), a1                                ; $01CF6C
        move.b       #$12, (a1)+                                   ; $01CF70
        move.b       ActorLinkId(a0), (a1)+                        ; $01CF74
        move.w       ActorFlags(a0), d0                            ; $01CF78
        ori.w        #$20, d0                                      ; $01CF7C
        move.b       d0, (a1)+                                     ; $01CF80
        move.b       ActorFloor(a0), (a1)+                         ; $01CF82
        lea.l        -$6fdc(a6), a0                                ; $01CF86
        jmp          QueueLinkCommand.l                            ; $01CF8A

loc_01CF90:
        move.w       d0, ActorX(a0)                                ; $01CF90
        move.w       d1, ActorY(a0)                                ; $01CF94
        rts                                                        ; $01CF98
        ifne *-$1CF9A
        fail "ROM end moved"
        endif
