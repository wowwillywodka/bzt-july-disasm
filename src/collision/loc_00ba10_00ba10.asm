; $00BA10..$00BAB5 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$BA10
        fail "ROM start moved"
        endif

loc_00BA10:
        move.w       rPlayerY(a6), d0                              ; $00BA10
        andi.w       #$ff, d0                                      ; $00BA14
        subi.w       #$ff, d0                                      ; $00BA18
        asr.w        #$2, d0                                       ; $00BA1C
        move.w       d0, -$6e4c(a6)                                ; $00BA1E
        rts                                                        ; $00BA22

loc_00BA24:
        move.w       rPlayerY(a6), d0                              ; $00BA24
        andi.w       #$ff, d0                                      ; $00BA28
        neg.w        d0                                            ; $00BA2C
        asr.w        #$2, d0                                       ; $00BA2E
        move.w       d0, -$6e4c(a6)                                ; $00BA30
        rts                                                        ; $00BA34

loc_00BA36:
        move.w       rPlayerX(a6), d0                              ; $00BA36
        andi.w       #$ff, d0                                      ; $00BA3A
        neg.w        d0                                            ; $00BA3E
        asr.w        #$2, d0                                       ; $00BA40
        move.w       d0, -$6e4c(a6)                                ; $00BA42
        rts                                                        ; $00BA46

loc_00BA48:
        move.w       rPlayerX(a6), d0                              ; $00BA48
        andi.w       #$ff, d0                                      ; $00BA4C
        subi.w       #$ff, d0                                      ; $00BA50
        asr.w        #$2, d0                                       ; $00BA54
        move.w       d0, -$6e4c(a6)                                ; $00BA56
        rts                                                        ; $00BA5A

loc_00BA5C:
        clr.w        -$6e4c(a6)                                    ; $00BA5C
        rts                                                        ; $00BA60

loc_00BA62:
        move.w       rPlayerY(a6), d0                              ; $00BA62
        andi.w       #$ff, d0                                      ; $00BA66
        neg.w        d0                                            ; $00BA6A
        addi.w       #$ff, d0                                      ; $00BA6C
        asr.w        #$2, d0                                       ; $00BA70
        move.w       d0, -$6e4c(a6)                                ; $00BA72
        rts                                                        ; $00BA76

loc_00BA78:
        move.w       rPlayerY(a6), d0                              ; $00BA78
        andi.w       #$ff, d0                                      ; $00BA7C
        asr.w        #$2, d0                                       ; $00BA80
        move.w       d0, -$6e4c(a6)                                ; $00BA82
        rts                                                        ; $00BA86

loc_00BA88:
        move.w       rPlayerX(a6), d0                              ; $00BA88
        andi.w       #$ff, d0                                      ; $00BA8C
        asr.w        #$2, d0                                       ; $00BA90
        move.w       d0, -$6e4c(a6)                                ; $00BA92
        rts                                                        ; $00BA96

loc_00BA98:
        move.w       rPlayerX(a6), d0                              ; $00BA98
        andi.w       #$ff, d0                                      ; $00BA9C
        neg.w        d0                                            ; $00BAA0
        addi.w       #$ff, d0                                      ; $00BAA2
        asr.w        #$2, d0                                       ; $00BAA6
        move.w       d0, -$6e4c(a6)                                ; $00BAA8
        rts                                                        ; $00BAAC

loc_00BAAE:
        move.w       #$ffc0, -$6e4c(a6)                            ; $00BAAE
        rts                                                        ; $00BAB4
        ifne *-$BAB6
        fail "ROM end moved"
        endif
