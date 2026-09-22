; $083C2A..$083C4D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Конвертер 32-бит D0 в 8-символьную ASCII hex-строку: rol.l #4, маска 0xF, выборка цифры из таблицы (PC-0x19c4), запись в буфер (A0)+ с нуль-терминатором
        ifne *-$83C2A
        fail "ROM start moved"
        endif

FormatHexLong:
        move.w       #$0, d1                                       ; $083C2A
        lea.l        HexadecimalDigits(pc), a1                     ; $083C2E
        move.w       #$7, d7                                       ; $083C32

loc_083C36:
        rol.l        #$4, d0                                       ; $083C36
        move.b       d0, d1                                        ; $083C38
        andi.b       #$f, d1                                       ; $083C3A
        move.b       (a1, d1.w), d1                                ; $083C3E
        move.b       d1, (a0)+                                     ; $083C42
        dbra         d7, loc_083C36                                ; $083C44
        move.b       #$0, (a0)+                                    ; $083C48
        rts                                                        ; $083C4C
        ifne *-$83C4E
        fail "ROM end moved"
        endif
