; $01F994..$01FB27 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A1=bank+2: all root offsets are signed words relative to this base; view offsets are relative to the animation header.
        ifne *-$1F994
        fail "ROM start moved"
        endif

SelectActorAnimationView:
; A1=bank+2: all root offsets are signed words relative to this base; view offsets are relative to the animation header.
        movea.l      a1, a2                                        ; $01F994
        adda.w       (a1), a2                                      ; $01F996
        lsl.w        #$1, d0                                       ; $01F998
        adda.w       $2(a1, d0.w), a1                              ; $01F99A
        move.w       (a1), d7                                      ; $01F99E
        cmpi.w       #$1, d7                                       ; $01F9A0
        beq.w        loc_01FAA8                                    ; $01F9A4
        move.w       ActorX(a0), d0                                ; $01F9A8
        sub.w        rPlayerX(a6), d0                              ; $01F9AC
        move.w       ActorY(a0), d1                                ; $01F9B0
        sub.w        rPlayerY(a6), d1                              ; $01F9B4
        muls.w       ActorMotionX(a0), d0                          ; $01F9B8
        muls.w       ActorMotionY(a0), d1                          ; $01F9BC
        add.l        d0, d1                                        ; $01F9C0
        cmpi.w       #$2, d7                                       ; $01F9C2
        bne.b        loc_01F9D2                                    ; $01F9C6
        tst.l        d1                                            ; $01F9C8
        bmi.w        loc_01FAA8                                    ; $01F9CA
        bra.w        loc_01FAAE                                    ; $01F9CE

loc_01F9D2:
        move.l       d1, d3                                        ; $01F9D2
        move.w       ActorX(a0), d0                                ; $01F9D4
        sub.w        rPlayerX(a6), d0                              ; $01F9D8
        move.w       ActorY(a0), d1                                ; $01F9DC
        sub.w        rPlayerY(a6), d1                              ; $01F9E0
        jsr          OctagonalDistance.l                           ; $01F9E4
        addq.w       #$1, d0                                       ; $01F9EA
        divs.w       d0, d3                                        ; $01F9EC
        ext.l        d3                                            ; $01F9EE
        lsl.l        #$8, d3                                       ; $01F9F0
        move.w       ActorMotionX(a0), d0                          ; $01F9F2
        move.w       ActorMotionY(a0), d1                          ; $01F9F6
        jsr          OctagonalDistance.l                           ; $01F9FA
        addq.w       #$1, d0                                       ; $01FA00
        divs.w       d0, d3                                        ; $01FA02
        move.w       ActorX(a0), d0                                ; $01FA04
        sub.w        rPlayerX(a6), d0                              ; $01FA08
        move.w       ActorY(a0), d4                                ; $01FA0C
        sub.w        rPlayerY(a6), d4                              ; $01FA10
        muls.w       ActorMotionY(a0), d0                          ; $01FA14
        muls.w       ActorMotionX(a0), d4                          ; $01FA18
        sub.l        d0, d4                                        ; $01FA1C
        cmpi.w       #$4, d7                                       ; $01FA1E
        bne.b        loc_01FA3E                                    ; $01FA22
        cmpi.w       #$9b, d3                                      ; $01FA24
        bge.w        loc_01FAAE                                    ; $01FA28
        cmpi.w       #$ff65, d3                                    ; $01FA2C
        ble.w        loc_01FAA8                                    ; $01FA30
        tst.l        d4                                            ; $01FA34
        bmi.w        loc_01FAB4                                    ; $01FA36
        bra.w        loc_01FABA                                    ; $01FA3A

loc_01FA3E:
        cmpi.w       #$6, d7                                       ; $01FA3E
        bne.b        loc_01FA6E                                    ; $01FA42
        cmpi.w       #$9b, d3                                      ; $01FA44
        bge.w        loc_01FAAE                                    ; $01FA48
        cmpi.w       #$ff38, d3                                    ; $01FA4C
        ble.w        loc_01FAA8                                    ; $01FA50
        cmpi.w       #$ffa6, d3                                    ; $01FA54
        bge.b        loc_01FA64                                    ; $01FA58
        tst.l        d4                                            ; $01FA5A
        bmi.w        loc_01FAC0                                    ; $01FA5C
        bra.w        loc_01FAC6                                    ; $01FA60

loc_01FA64:
        tst.l        d4                                            ; $01FA64
        bmi.w        loc_01FAB4                                    ; $01FA66
        bra.w        loc_01FABA                                    ; $01FA6A

loc_01FA6E:
        cmpi.w       #$c8, d3                                      ; $01FA6E
        bge.w        loc_01FAAE                                    ; $01FA72
        cmpi.w       #$ff38, d3                                    ; $01FA76
        ble.w        loc_01FAA8                                    ; $01FA7A
        cmpi.w       #$ffa6, d3                                    ; $01FA7E
        bge.b        loc_01FA8E                                    ; $01FA82
        tst.l        d4                                            ; $01FA84
        bmi.w        loc_01FAC0                                    ; $01FA86
        bra.w        loc_01FAC6                                    ; $01FA8A

loc_01FA8E:
        cmpi.w       #$5a, d3                                      ; $01FA8E
        ble.b        loc_01FA9E                                    ; $01FA92
        tst.l        d4                                            ; $01FA94
        bmi.w        loc_01FACC                                    ; $01FA96
        bra.w        loc_01FAD2                                    ; $01FA9A

loc_01FA9E:
        tst.l        d4                                            ; $01FA9E
        bmi.w        loc_01FAB4                                    ; $01FAA0
        bra.w        loc_01FABA                                    ; $01FAA4

loc_01FAA8:
        adda.w       $2(a1), a1                                    ; $01FAA8
        bra.b        loc_01FAD6                                    ; $01FAAC

loc_01FAAE:
        adda.w       $4(a1), a1                                    ; $01FAAE
        bra.b        loc_01FAD6                                    ; $01FAB2

loc_01FAB4:
        adda.w       $6(a1), a1                                    ; $01FAB4
        bra.b        loc_01FAD6                                    ; $01FAB8

loc_01FABA:
        adda.w       $8(a1), a1                                    ; $01FABA
        bra.b        loc_01FAD6                                    ; $01FABE

loc_01FAC0:
        adda.w       $a(a1), a1                                    ; $01FAC0
        bra.b        loc_01FAD6                                    ; $01FAC4

loc_01FAC6:
        adda.w       $c(a1), a1                                    ; $01FAC6
        bra.b        loc_01FAD6                                    ; $01FACA

loc_01FACC:
        adda.w       $e(a1), a1                                    ; $01FACC
        bra.b        loc_01FAD6                                    ; $01FAD0

loc_01FAD2:
        adda.w       $10(a1), a1                                   ; $01FAD2

loc_01FAD6:
; View word is LAST frame index, not frame count. An explicit index above the last falls back to frame zero.
        move.w       (a1)+, d7                                     ; $01FAD6
        move.w       (a7)+, d1                                     ; $01FAD8
        bmi.b        loc_01FAE8                                    ; $01FADA
        cmp.w        d7, d1                                        ; $01FADC
        bls.w        DrawActorAnimationFrame                       ; $01FADE
        clr.w        d1                                            ; $01FAE2
        bra.w        DrawActorAnimationFrame                       ; $01FAE4

loc_01FAE8:
        clr.w        d1                                            ; $01FAE8
        tst.w        d7                                            ; $01FAEA
        beq.w        DrawActorAnimationFrame                       ; $01FAEC
        move.w       ActorMotionX(a0), d0                          ; $01FAF0
        move.w       ActorMotionY(a0), d1                          ; $01FAF4
        jsr          OctagonalDistance.l                           ; $01FAF8
        clr.w        d1                                            ; $01FAFE
        cmpi.w       #$4, d0                                       ; $01FB00
        bcs.w        DrawActorAnimationFrame                       ; $01FB04
; Accumulate movement magnitude for walk frames; allocator does not reset this phase.
; WalkPhase advances while drawing, by OctagonalDistance(MotionX,MotionY); lookup selects frames 1..last, leaving frame zero for idle.
        add.w        d0, ActorWalkPhase(a0)                        ; $01FB08
        move.w       ActorWalkPhase(a0), d1                        ; $01FB0C
        asr.w        #$3, d1                                       ; $01FB10
        andi.w       #$1f, d1                                      ; $01FB12
        lea.l        ActorAnimationPhaseLookup(pc), a3             ; $01FB16
        subq.w       #$1, d7                                       ; $01FB1A
        lsl.w        #$5, d7                                       ; $01FB1C
        adda.w       d7, a3                                        ; $01FB1E
        move.b       (a3, d1.w), d1                                ; $01FB20
        bra.w        DrawActorAnimationFrame                       ; $01FB24
        ifne *-$1FB28
        fail "ROM end moved"
        endif
