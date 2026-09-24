; $00C08C..$00C107 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; RearViewActive selects a 180-degree heading flip; temporary camera pullback by one eighth
; facing vector, trace/draw, then restore player coordinates and heading.
; Called from scene entry, gameplay and character resume.
        ifne *-$C08C
        fail "ROM start moved"
        endif

RenderWorldWithCameraOffset:
        tst.w        rRearViewActive(a6)                                    ; $00C08C
        beq.b        loc_00C0B4                                    ; $00C090
        addi.w       #$100, rPlayerFacingAngle(a6)                             ; $00C092
        andi.w       #$1ff, rPlayerFacingAngle(a6)                             ; $00C098
        lea.l        AngleVectorPairs(pc), a0                      ; $00C09E
        move.w       rPlayerFacingAngle(a6), d0                                ; $00C0A2
        lsl.w        #$2, d0                                       ; $00C0A6
        move.w       (a0, d0.w), rPlayerFacingVectorX(a6)                        ; $00C0A8
        move.w       $2(a0, d0.w), rPlayerFacingVectorY(a6)                      ; $00C0AE

loc_00C0B4:
        move.w       rPlayerFacingVectorX(a6), d0                                ; $00C0B4
        asr.w        #$3, d0                                       ; $00C0B8
        sub.w        d0, rPlayerX(a6)                              ; $00C0BA
        move.w       rPlayerFacingVectorY(a6), d0                                ; $00C0BE
        asr.w        #$3, d0                                       ; $00C0C2
        sub.w        d0, rPlayerY(a6)                              ; $00C0C4
        bsr.b        TraceAndDrawVisibleWorld                       ; $00C0C8
        move.w       rPlayerFacingVectorX(a6), d0                                ; $00C0CA
        asr.w        #$3, d0                                       ; $00C0CE
        add.w        d0, rPlayerX(a6)                              ; $00C0D0
        move.w       rPlayerFacingVectorY(a6), d0                                ; $00C0D4
        asr.w        #$3, d0                                       ; $00C0D8
        add.w        d0, rPlayerY(a6)                              ; $00C0DA
        tst.w        rRearViewActive(a6)                                    ; $00C0DE
        beq.b        loc_00C106                                    ; $00C0E2
        addi.w       #$100, rPlayerFacingAngle(a6)                             ; $00C0E4
        andi.w       #$1ff, rPlayerFacingAngle(a6)                             ; $00C0EA
        lea.l        AngleVectorPairs(pc), a0                      ; $00C0F0
        move.w       rPlayerFacingAngle(a6), d0                                ; $00C0F4
        lsl.w        #$2, d0                                       ; $00C0F8
        move.w       (a0, d0.w), rPlayerFacingVectorX(a6)                        ; $00C0FA
        move.w       $2(a0, d0.w), rPlayerFacingVectorY(a6)                      ; $00C100

loc_00C106:
        rts                                                        ; $00C106
        ifne *-$C108
        fail "ROM end moved"
        endif
