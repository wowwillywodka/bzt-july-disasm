; $020010..$020057 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Потребитель RX-кольца линк-кабеля: при tail!=head (-0x5398/-0x5396,A6) читает слова из буфера (-0x5390,A6) в (A0)+, длину по PC-таблице кодов, продвигает индекс &$7FF, возвращает D0=1/0 (есть/нет пакет)
        ifne *-$20010
        fail "ROM start moved"
        endif

InputRoutine_020010:
        move.w       -$5398(a6), d0                                ; $020010
        cmp.w        -$5396(a6), d0                                ; $020014
        bne.b        loc_02001E                                    ; $020018
        clr.w        d0                                            ; $02001A
        rts                                                        ; $02001C

loc_02001E:
        move.l       a0, -(a7)                                     ; $02001E
        lea.l        -$5390(a6), a1                                ; $020020
        clr.w        d1                                            ; $020024
        move.b       (a1, d0.w), d1                                ; $020026
        move.w       (a1, d0.w), (a0)+                             ; $02002A
        lea.l        LinkCommandSizes(pc), a2                      ; $02002E
        move.b       (a2, d1.w), d1                                ; $020032
        bmi.b        loc_020046                                    ; $020036

loc_020038:
        addq.w       #$2, d0                                       ; $020038
        andi.w       #$7ff, d0                                     ; $02003A
        move.w       (a1, d0.w), (a0)+                             ; $02003E
        dbra         d1, loc_020038                                ; $020042

loc_020046:
        addq.w       #$2, d0                                       ; $020046
        andi.w       #$7ff, d0                                     ; $020048
        move.w       d0, -$5398(a6)                                ; $02004C
        movea.l      (a7)+, a0                                     ; $020050
        move.w       #$1, d0                                       ; $020052
        rts                                                        ; $020056
        ifne *-$20058
        fail "ROM end moved"
        endif
