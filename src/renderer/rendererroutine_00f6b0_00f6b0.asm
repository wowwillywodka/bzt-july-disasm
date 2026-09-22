; $00F6B0..$00F735 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проекция видимых объектов из связного списка (-0x57c4,A6) в таблицу спрайтов: отсекает по окну камеры ±0x500 и уровню (-0x6fae,A6) vs (0x36,A0), пишет атрибуты спрайта (Y,link,tile,X) в буфер (A2)+
        ifne *-$F6B0
        fail "ROM start moved"
        endif

RendererRoutine_00F6B0:
        move.w       rActiveActorCount(a6), d2                     ; $00F6B0
        beq.w        loc_00F734                                    ; $00F6B4
        subq.w       #$1, d2                                       ; $00F6B8
        movea.l      rActiveActorHead(a6), a0                      ; $00F6BA
        move.w       -$720a(a6), d6                                ; $00F6BE
        clr.b        d6                                            ; $00F6C2
        move.w       -$7208(a6), d7                                ; $00F6C4
        clr.b        d7                                            ; $00F6C8
        move.w       d6, d4                                        ; $00F6CA
        move.w       d7, d3                                        ; $00F6CC
        subi.w       #$500, d6                                     ; $00F6CE
        subi.w       #$500, d7                                     ; $00F6D2
        addi.w       #$500, d3                                     ; $00F6D6
        addi.w       #$500, d4                                     ; $00F6DA

loc_00F6DE:
        move.w       $4(a0), d0                                    ; $00F6DE
        andi.w       #$10, d0                                      ; $00F6E2
        beq.b        loc_00F72E                                    ; $00F6E6
        move.w       rCurrentFloor(a6), d0                         ; $00F6E8
        cmp.b        $36(a0), d0                                   ; $00F6EC
        bne.b        loc_00F72E                                    ; $00F6F0
        move.w       $24(a0), d0                                   ; $00F6F2
        move.w       $26(a0), d1                                   ; $00F6F6
        cmp.w        d4, d0                                        ; $00F6FA
        bge.b        loc_00F72E                                    ; $00F6FC
        cmp.w        d6, d0                                        ; $00F6FE
        blt.b        loc_00F72E                                    ; $00F700
        cmp.w        d3, d1                                        ; $00F702
        bge.b        loc_00F72E                                    ; $00F704
        cmp.w        d7, d1                                        ; $00F706
        blt.b        loc_00F72E                                    ; $00F708
        sub.w        d6, d0                                        ; $00F70A
        sub.w        d7, d1                                        ; $00F70C
        asr.w        #$5, d1                                       ; $00F70E
        addi.w       #$106, d1                                     ; $00F710
        move.w       d1, (a2)+                                     ; $00F714
        move.w       -$7fbe(a6), d1                                ; $00F716
        ori.w        #$0, d1                                       ; $00F71A
        move.w       d1, (a2)+                                     ; $00F71E
        addq.w       #$1, -$7fbe(a6)                               ; $00F720
        move.w       d5, (a2)+                                     ; $00F724
        asr.w        #$5, d0                                       ; $00F726
        addi.w       #$e6, d0                                      ; $00F728
        move.w       d0, (a2)+                                     ; $00F72C

loc_00F72E:
        movea.l      (a0), a0                                      ; $00F72E
        dbra         d2, loc_00F6DE                                ; $00F730

loc_00F734:
        rts                                                        ; $00F734
        ifne *-$F736
        fail "ROM end moved"
        endif
