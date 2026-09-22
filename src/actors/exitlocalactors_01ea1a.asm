; $01EA1A..$01EA47 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер обновления актёров: цикл по списку (-0x57c4/-0x57c6,A6), для каждого с очищенным флагом 0x20 (0x4,A0) вызывает его think/update-вектор (0x1a,A0); по завершении jmp 0xb028
        ifne *-$1EA1A
        fail "ROM start moved"
        endif

ExitLocalActors:
; Invoke exit callbacks of non-remote actors, then clean transient cell records. Not called by every window shift.
        move.w       rActiveActorCount(a6), d7                     ; $01EA1A
        beq.b        loc_01EA42                                    ; $01EA1E
        subq.w       #$1, d7                                       ; $01EA20
        movea.l      rActiveActorHead(a6), a0                      ; $01EA22

loc_01EA26:
        move.l       (a0), -(a7)                                   ; $01EA26
        move.w       ActorFlags(a0), d0                            ; $01EA28
        andi.w       #$20, d0                                      ; $01EA2C
        bne.b        loc_01EA3C                                    ; $01EA30
        movea.l      ActorExitCallback(a0), a1                     ; $01EA32
        move.w       d7, -(a7)                                     ; $01EA36
        jsr          (a1)                                          ; $01EA38
        move.w       (a7)+, d7                                     ; $01EA3A

loc_01EA3C:
        movea.l      (a7)+, a0                                     ; $01EA3C
        dbra         d7, loc_01EA26                                ; $01EA3E

loc_01EA42:
        jmp          FinishTransientWallRecords.l                  ; $01EA42
        ifne *-$1EA48
        fail "ROM end moved"
        endif
