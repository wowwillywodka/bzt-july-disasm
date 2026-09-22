; $07A90E..$07A94D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка Z80 GEMS-драйвера ($A814/$A858) и отправка стартовой команды с 4 банковыми указателями: код $FF, $0B и четыре 3-байтных адреса
        ifne *-$7A90E
        fail "ROM start moved"
        endif

InitializeGemsBanks:
        link.w       a6, #$0                                       ; $07A90E
        jsr          LoadGemsDriver(pc)                            ; $07A912
        jsr          StartZ80(pc)                                  ; $07A916
        moveq        #-1, d0                                       ; $07A91A
        move.l       d0, -(a7)                                     ; $07A91C
        jsr          WriteGemsByteArgument(pc)                     ; $07A91E
        moveq        #$b, d0                                       ; $07A922
        move.l       d0, -(a7)                                     ; $07A924
        jsr          WriteGemsByteArgument(pc)                     ; $07A926
        move.l       $8(a6), -(a7)                                 ; $07A92A
        jsr          WriteGems24BitArgument(pc)                    ; $07A92E
        move.l       $c(a6), -(a7)                                 ; $07A932
        jsr          WriteGems24BitArgument(pc)                    ; $07A936
        move.l       $10(a6), -(a7)                                ; $07A93A
        jsr          WriteGems24BitArgument(pc)                    ; $07A93E
        move.l       $14(a6), -(a7)                                ; $07A942
        jsr          WriteGems24BitArgument(pc)                    ; $07A946
        unlk         a6                                            ; $07A94A
        rts                                                        ; $07A94C
        ifne *-$7A94E
        fail "ROM end moved"
        endif
