; $020CBC..$020D15 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Покадровый шаг скрипта звуковых событий: при активном флаге (-0x55a0,A6) ждёт истечения таймера шага (-0x7732,A6), сдвигает очередь событий (-0x7772,A6) на запись, ставит таймер следующего шага и играет звук (id=(-0x7770,A6), d0) через 0xDFBA→0x7ACE8
        ifne *-$20CBC
        fail "ROM start moved"
        endif

SoundRoutine_020CBC:
        tst.w        -$55a0(a6)                                    ; $020CBC
        bne.b        loc_020CCA                                    ; $020CC0
        move.w       #$ffff, -$7772(a6)                            ; $020CC2
        rts                                                        ; $020CC8

loc_020CCA:
        cmpi.w       #$ffff, -$7772(a6)                            ; $020CCA
        beq.b        loc_020D14                                    ; $020CD0
        tst.w        -$7732(a6)                                    ; $020CD2
        bpl.b        loc_020D14                                    ; $020CD6
        lea.l        -$7772(a6), a0                                ; $020CD8
        move.l       $4(a0), (a0)+                                 ; $020CDC
        move.l       $4(a0), (a0)+                                 ; $020CE0
        move.l       $4(a0), (a0)+                                 ; $020CE4
        move.l       $4(a0), (a0)+                                 ; $020CE8
        move.l       $4(a0), (a0)+                                 ; $020CEC
        move.l       $4(a0), (a0)+                                 ; $020CF0
        move.l       $4(a0), (a0)+                                 ; $020CF4
        cmpi.w       #$ffff, -$7772(a6)                            ; $020CF8
        beq.b        loc_020D10                                    ; $020CFE
        move.w       -$7772(a6), -$7732(a6)                        ; $020D00
        move.w       -$7770(a6), d0                                ; $020D06
        jmp          SoundRoutine_00DFBA.l                         ; $020D0A

loc_020D10:
        clr.w        -$55a0(a6)                                    ; $020D10

loc_020D14:
        rts                                                        ; $020D14
        ifne *-$20D16
        fail "ROM end moved"
        endif
