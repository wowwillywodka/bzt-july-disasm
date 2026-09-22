; $0028AC..$0028C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка звукового события $16 в очередь: сохраняет D0/D1/A0/A1, в буфер -$6fdc(a6) пишет код $16 и вызывает jsr $1ffcc (диспетчер звука GEMS), восстанавливает регистры
        ifne *-$28AC
        fail "ROM start moved"
        endif

SoundRoutine_0028AC:
        movem.l      d0-d1/a0-a1, -(a7)                            ; $0028AC
        lea.l        -$6fdc(a6), a0                                ; $0028B0
        move.b       #$16, (a0)                                    ; $0028B4
        jsr          QueueLinkCommand.l                            ; $0028B8
        movem.l      (a7)+, d0-d1/a0-a1                            ; $0028BE
        rts                                                        ; $0028C2
        ifne *-$28C4
        fail "ROM end moved"
        endif
