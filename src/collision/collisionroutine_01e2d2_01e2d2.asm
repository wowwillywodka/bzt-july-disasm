; $01E2D2..$01E323 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 18B10] Зажим под-тайловой координаты актёра X(+0x27)/Z(+0x25) к границе клетки (0x40/0xc0) при упоре в стену, затем бамп-звук 0x18c3a
        ifne *-$1E2D2
        fail "ROM start moved"
        endif

CollisionRoutine_01E2D2:
        move.b       ActorFractionY(a0), d0                        ; $01E2D2
        bmi.b        loc_01E2E8                                    ; $01E2D6
        cmpi.b       #$40, d0                                      ; $01E2D8
        bls.b        loc_01E2D0                                    ; $01E2DC
        move.b       #$40, ActorFractionY(a0)                      ; $01E2DE
        bra.w        loc_01E3FC                                    ; $01E2E4

loc_01E2E8:
        cmpi.b       #$c0, d0                                      ; $01E2E8
        bcc.b        loc_01E2D0                                    ; $01E2EC
        move.b       #$c0, ActorFractionY(a0)                      ; $01E2EE
        bra.w        loc_01E3FC                                    ; $01E2F4

loc_01E2F8:
        move.b       ActorFractionX(a0), d0                        ; $01E2F8
        bmi.b        loc_01E30E                                    ; $01E2FC
        cmpi.b       #$40, d0                                      ; $01E2FE
        bls.b        loc_01E2D0                                    ; $01E302
        move.b       #$40, ActorFractionX(a0)                      ; $01E304
        bra.w        loc_01E3FC                                    ; $01E30A

loc_01E30E:
        cmpi.b       #$c0, d0                                      ; $01E30E
        bcc.b        loc_01E2D0                                    ; $01E312
        move.b       #$c0, ActorFractionX(a0)                      ; $01E314
        bra.w        loc_01E3FC                                    ; $01E31A

loc_01E31E:
        movea.l      ActorExitCallback(a0), a1                     ; $01E31E
        jmp          (a1)                                          ; $01E322
        ifne *-$1E324
        fail "ROM end moved"
        endif
