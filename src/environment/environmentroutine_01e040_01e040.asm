; $01E040..$01E0A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Импакт снаряда в стену: вычисляет ячейку карты из позиции, клампит указатель в диапазон $ffa5fa..$ffe5fa, штампует celltype байтом $c10, триггерит эффект $20910 и спавнит событие $1ffcc, деспавн $1c150
        ifne *-$1E040
        fail "ROM start moved"
        endif

EnvironmentRoutine_01E040:
        bsr.w        GetVisibleMapBase                             ; $01E040
        move.w       ActorX(a0), d0                                ; $01E044
        asr.w        #$8, d0                                       ; $01E048
        adda.w       d0, a1                                        ; $01E04A
        move.w       ActorY(a0), d0                                ; $01E04C
        asr.w        #$3, d0                                       ; $01E050
        andi.w       #$ffe0, d0                                    ; $01E052
        adda.w       d0, a1                                        ; $01E056
        cmpa.l       #$ffa5fa, a1                                  ; $01E058
        bcs.b        loc_01E068                                    ; $01E05E
        cmpa.l       #$ffe5fa, a1                                  ; $01E060
        bcs.b        loc_01E06E                                    ; $01E066

loc_01E068:
        movea.l      #$ffa9fa, a1                                  ; $01E068

loc_01E06E:
        move.b       $c10(a6), (a1)                                ; $01E06E
        move.l       a0, -(a7)                                     ; $01E072
        movea.l      a1, a0                                        ; $01E074
        bsr.w        CommitMapCellAndSendLink                      ; $01E076
        movea.l      (a7)+, a0                                     ; $01E07A
        tst.w        rLinkRole(a6)                                 ; $01E07C
        beq.w        RemoveActor                                   ; $01E080
        lea.l        -$6fdc(a6), a1                                ; $01E084
        move.b       #$5, (a1)                                     ; $01E088
        move.b       ActorLinkId(a0), $1(a1)                       ; $01E08C
        movem.l      d0-d7/a0-a3, -(a7)                            ; $01E092
        movea.l      a1, a0                                        ; $01E096
        jsr          QueueLinkCommand.l                            ; $01E098
        movem.l      (a7)+, d0-d7/a0-a3                            ; $01E09E
        bra.w        RemoveActor                                   ; $01E0A2
        ifne *-$1E0A6
        fail "ROM end moved"
        endif
