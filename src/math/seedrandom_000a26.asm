; $000A26..$000A45 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Засев ГПСЧ: накопление значения HV-счётчика VDP $C00008 за 0x2710 итераций в seed (-0x7FFA,A6)
        ifne *-$A26
        fail "ROM start moved"
        endif

SeedRandom:
        move.l       #$82647359, d0                                ; $000A26
        move.l       #$2710, d2                                    ; $000A2C

loc_000A32:
        move.w       VDP_HV_COUNTER.l, d1                          ; $000A32
        ext.l        d1                                            ; $000A38
        add.l        d1, d0                                        ; $000A3A
        subq.l       #$1, d2                                       ; $000A3C
        bne.b        loc_000A32                                    ; $000A3E
        move.l       d0, rRandomSeed(a6)                                ; $000A40
        rts                                                        ; $000A44
        ifne *-$A46
        fail "ROM end moved"
        endif
