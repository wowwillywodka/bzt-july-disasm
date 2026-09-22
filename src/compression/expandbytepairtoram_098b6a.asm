; $098B6A..$098B97 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рекурсивный раскрыватель byte-pair: если у кода (A0,D0) выставлен флаг пары — рекурсия на левого (A1) и правого (A2) потомка, иначе вывод литерала байтом в (A4)+ (RAM)
        ifne *-$98B6A
        fail "ROM start moved"
        endif

ExpandBytePairToRam:
        movem.w      d2, -(a7)                                     ; $098B6A
        moveq        #$0, d1                                       ; $098B6E
        move.b       (a0, d0.w), d1                                ; $098B70
        beq.w        loc_098B90                                    ; $098B74
        move.b       (a2, d0.w), d2                                ; $098B78
        move.b       (a1, d0.w), d0                                ; $098B7C
        jsr          ExpandBytePairToRam(pc)                       ; $098B80
        move.b       d2, d0                                        ; $098B84
        jsr          ExpandBytePairToRam(pc)                       ; $098B86
        movem.w      (a7)+, d2                                     ; $098B8A
        rts                                                        ; $098B8E

loc_098B90:
        move.b       d0, (a4)+                                     ; $098B90
        movem.w      (a7)+, d2                                     ; $098B92
        rts                                                        ; $098B96
        ifne *-$98B98
        fail "ROM end moved"
        endif
