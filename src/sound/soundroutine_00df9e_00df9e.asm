; $00DF9E..$00DFB9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка звукового события типа 0x8 в очередь GEMS: пишет код 0x8 и параметр D0 в буфер (-0x6fdc,A6) и вызывает диспетчер очереди jsr 0x1ffcc, сохраняя регистры
        ifne *-$DF9E
        fail "ROM start moved"
        endif

SoundRoutine_00DF9E:
        movem.l      d0-d1/a0-a1, -(a7)                            ; $00DF9E
        lea.l        -$6fdc(a6), a0                                ; $00DFA2
        move.b       #$8, (a0)                                     ; $00DFA6
        move.b       d0, $1(a0)                                    ; $00DFAA
        jsr          QueueLinkCommand.l                            ; $00DFAE
        movem.l      (a7)+, d0-d1/a0-a1                            ; $00DFB4
        rts                                                        ; $00DFB8
        ifne *-$DFBA
        fail "ROM end moved"
        endif
