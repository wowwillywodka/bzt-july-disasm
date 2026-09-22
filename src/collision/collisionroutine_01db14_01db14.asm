; $01DB14..$01DB3B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Покадровое снижение высоты $28 снаряда по глоб.таймеру (-$7120 & 7) и продвижение аним-счётчика $39 от таймера (-$6fe0); по переносу проваливается в обработчик жизни
        ifne *-$1DB14
        fail "ROM start moved"
        endif

CollisionRoutine_01DB14:
        move.w       rGameTick(a6), d0                             ; $01DB14
        add.b        ActorLinkId(a0), d0                           ; $01DB18
        andi.w       #$7, d0                                       ; $01DB1C
        bne.b        loc_01DB2E                                    ; $01DB20
        cmpi.w       #$fff0, ActorZ(a0)                            ; $01DB22
        ble.b        loc_01DB2E                                    ; $01DB28
        subq.w       #$1, ActorZ(a0)                               ; $01DB2A

loc_01DB2E:
        move.w       -$6fe0(a6), d0                                ; $01DB2E
        addq.w       #$1, d0                                       ; $01DB32
        asr.w        #$1, d0                                       ; $01DB34
        add.b        d0, ActorStateCounter(a0)                     ; $01DB36
        bcc.b        loc_01DB12                                    ; $01DB3A
        ifne *-$1DB3C
        fail "ROM end moved"
        endif
