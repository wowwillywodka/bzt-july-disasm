; $020ACE..$020AE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сброс системы баннеров/бегущей строки: обнуляет счётчик очереди (-0x76f0), таймер (-0x76ee), флаги прокрутки (-0x7772=-1,-0x7732,-0x55a0,-0x559e,A6)
        ifne *-$20ACE
        fail "ROM start moved"
        endif

ResetStatusMessages:
        clr.w        -$76f0(a6)                                    ; $020ACE
        clr.w        -$76ee(a6)                                    ; $020AD2
        move.w       #$ffff, -$7772(a6)                            ; $020AD6
        clr.w        -$7732(a6)                                    ; $020ADC
        clr.w        -$55a0(a6)                                    ; $020AE0
        clr.w        -$559e(a6)                                    ; $020AE4
        rts                                                        ; $020AE8
        ifne *-$20AEA
        fail "ROM end moved"
        endif
