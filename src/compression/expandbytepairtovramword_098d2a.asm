; $098D2A..$098D6D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рекурсивный раскрыватель byte-pair с выводом словами в VRAM: при литерале копит байты в D3 (asl.w #8) и пишет слово в порт данных VDP $C00000, иначе рекурсия по левому/правому потомку
        ifne *-$98D2A
        fail "ROM start moved"
        endif

ExpandBytePairToVramWord:
        movem.w      d2, -(a7)                                     ; $098D2A
        moveq        #$0, d1                                       ; $098D2E
        move.b       (a0, d0.w), d1                                ; $098D30
        beq.w        loc_098D50                                    ; $098D34
        move.b       (a2, d0.w), d2                                ; $098D38
        move.b       (a1, d0.w), d0                                ; $098D3C
        jsr          ExpandBytePairToVramWord(pc)                  ; $098D40
        move.b       d2, d0                                        ; $098D44
        jsr          ExpandBytePairToVramWord(pc)                  ; $098D46
        movem.w      (a7)+, d2                                     ; $098D4A
        rts                                                        ; $098D4E

loc_098D50:
        asl.w        #$8, d3                                       ; $098D50
        bcc.w        loc_098D66                                    ; $098D52
        move.b       d0, d3                                        ; $098D56
        move.w       d3, VDP_DATA.l                                ; $098D58
        moveq        #$1, d3                                       ; $098D5E
        movem.w      (a7)+, d2                                     ; $098D60
        rts                                                        ; $098D64

loc_098D66:
        move.b       d0, d3                                        ; $098D66
        movem.w      (a7)+, d2                                     ; $098D68
        rts                                                        ; $098D6C
        ifne *-$98D6E
        fail "ROM end moved"
        endif
