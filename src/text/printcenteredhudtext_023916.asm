; $023916..$023995 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 5D8CE] Центрированный VDP-текст-принтер (2 строки): меряет длину строки, считает центр-адрес VRAM, пишет команду в $C00004 и шлёт глифы (байт-0x20, ×4, индекс xlate-таблицы -0x16e) в порт данных через A4
        ifne *-$23916
        fail "ROM start moved"
        endif

PrintCenteredHudText:
        lea.l        HudScreenGlyphPairs(pc), a1                   ; $023916
        clr.w        d1                                            ; $02391A

loc_02391C:
        tst.b        (a0, d1.w)                                    ; $02391C
        beq.b        loc_023926                                    ; $023920
        addq.w       #$1, d1                                       ; $023922
        bra.b        loc_02391C                                    ; $023924

loc_023926:
        asr.w        #$1, d1                                       ; $023926
        neg.w        d1                                            ; $023928
        addi.w       #$14, d1                                      ; $02392A
        asl.w        #$1, d1                                       ; $02392E
        add.w        d1, d0                                        ; $023930
        move.w       d0, -(a7)                                     ; $023932
        move.l       a0, -(a7)                                     ; $023934
        move.w       d0, d1                                        ; $023936
        andi.w       #$3fff, d1                                    ; $023938
        ori.w        #$4000, d1                                    ; $02393C
        swap         d1                                            ; $023940
        lsr.w        #$8, d0                                       ; $023942
        lsr.w        #$6, d0                                       ; $023944
        move.w       d0, d1                                        ; $023946
        move.l       d1, VDP_CONTROL.l                             ; $023948

loc_02394E:
        clr.w        d0                                            ; $02394E
        move.b       (a0)+, d0                                     ; $023950
        beq.b        loc_023960                                    ; $023952
        subi.w       #$20, d0                                      ; $023954
        lsl.w        #$2, d0                                       ; $023958
        move.w       (a1, d0.w), (a4)                              ; $02395A
        bra.b        loc_02394E                                    ; $02395E

loc_023960:
        addq.w       #$2, a1                                       ; $023960
        movea.l      (a7)+, a0                                     ; $023962
        move.w       (a7)+, d0                                     ; $023964
        addi.w       #$80, d0                                      ; $023966
        move.w       d0, d1                                        ; $02396A
        andi.w       #$3fff, d1                                    ; $02396C
        ori.w        #$4000, d1                                    ; $023970
        swap         d1                                            ; $023974
        lsr.w        #$8, d0                                       ; $023976
        lsr.w        #$6, d0                                       ; $023978
        move.w       d0, d1                                        ; $02397A
        move.l       d1, VDP_CONTROL.l                             ; $02397C

loc_023982:
        clr.w        d0                                            ; $023982
        move.b       (a0)+, d0                                     ; $023984
        beq.b        loc_023994                                    ; $023986
        subi.w       #$20, d0                                      ; $023988
        lsl.w        #$2, d0                                       ; $02398C
        move.w       (a1, d0.w), (a4)                              ; $02398E
        bra.b        loc_023982                                    ; $023992

loc_023994:
        rts                                                        ; $023994
        ifne *-$23996
        fail "ROM end moved"
        endif
