; $000BF2..$000C07 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обнуление рабочей RAM: lea $FF0018,A0; D0=(SP-A0)/4-1 (число лонгов до стека), цикл clr.l (A0)+ dbf — зануляет область RAM от $FF0018 до текущего SP
        ifne *-$BF2
        fail "ROM start moved"
        endif

ClearWorkRam:
        lea.l        ramControllerPresent.l, a0                    ; $000BF2
        move.l       a7, d0                                        ; $000BF8
        sub.l        a0, d0                                        ; $000BFA
        lsr.w        #$2, d0                                       ; $000BFC
        subq.w       #$1, d0                                       ; $000BFE

loc_000C00:
        clr.l        (a0)+                                         ; $000C00
        dbra         d0, loc_000C00                                ; $000C02
        rts                                                        ; $000C06
        ifne *-$C08
        fail "ROM end moved"
        endif
