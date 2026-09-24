; $01C150..$01C17D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Освобождение актёра: декремент счётчика (-0x57c6,A6), выписывание записи из связного списка (-0x57c4,A6) и обнуление полей (0x4,A0)/(A0)
        ifne *-$1C150
        fail "ROM start moved"
        endif

RemoveActor:
; Requires A0 to be a live list member. No double-free/null guard. Clears flags and next only.
; Does not clear ActorTarget in this slot or invalidate other actors pointing to it.
; Does not call ActorExitCallback, commit a map cell, or touch the separate
; hit-particle count. The caller owns those effects.
        subq.w       #$1, rActiveActorCount(a6)                    ; $01C150
        cmpa.l       rActiveActorHead(a6), a0                      ; $01C154
        bne.b        loc_01C166                                    ; $01C158
        move.l       (a0), rActiveActorHead(a6)                    ; $01C15A
        clr.w        ActorFlags(a0)                                ; $01C15E
        clr.l        (a0)                                          ; $01C162
        rts                                                        ; $01C164

loc_01C166:
        movea.l      rActiveActorHead(a6), a1                      ; $01C166
        cmpa.l       (a1), a0                                      ; $01C16A
        beq.b        loc_01C174                                    ; $01C16C

loc_01C16E:
        movea.l      (a1), a1                                      ; $01C16E
        cmpa.l       (a1), a0                                      ; $01C170
        bne.b        loc_01C16E                                    ; $01C172

loc_01C174:
        move.l       (a0), (a1)                                    ; $01C174
        clr.w        ActorFlags(a0)                                ; $01C176
        clr.l        (a0)                                          ; $01C17A
        rts                                                        ; $01C17C
        ifne *-$1C17E
        fail "ROM end moved"
        endif
