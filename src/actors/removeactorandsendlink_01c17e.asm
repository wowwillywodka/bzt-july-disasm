; $01C17E..$01C19F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Уничтожение актёра с оповещением: при флаге (-0x53a4,A6) шлёт сообщение {0x5, id актёра} через jsr 0x1ffcc, затем падает в 0x1c150 для освобождения записи
        ifne *-$1C17E
        fail "ROM start moved"
        endif

RemoveActorAndSendLink:
        tst.w        rLinkRole(a6)                                 ; $01C17E
        beq.b        RemoveActor                                   ; $01C182
        lea.l        -$6fdc(a6), a1                                ; $01C184
        move.b       #$5, (a1)+                                    ; $01C188
        move.b       ActorLinkId(a0), (a1)+                        ; $01C18C
        move.l       a0, -(a7)                                     ; $01C190
        lea.l        -$6fdc(a6), a0                                ; $01C192
        jsr          QueueLinkCommand.l                            ; $01C196
        movea.l      (a7)+, a0                                     ; $01C19C
        bra.b        RemoveActor                                   ; $01C19E
        ifne *-$1C1A0
        fail "ROM end moved"
        endif
