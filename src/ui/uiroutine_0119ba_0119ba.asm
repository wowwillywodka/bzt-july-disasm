; $0119BA..$011A5D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Апдейтер иконки-счётчика HUD по индексу (-0x6f6a): vblank-wait (-0x7ffe); если счётчик слота (2,A0,idx*4)>0x100 — декремент на 0x100, ставит VRAM-адрес записи (D5+0x68) в $C00004 и возвращает остаток; иначе чистит слова слота в RAM, ищет в (-0x6f8c)==6 новый индекс, иначе -1 + фикс (-0x7124) + jmp 0x1d44
        ifne *-$119BA
        fail "ROM start moved"
        endif

UiRoutine_0119BA:
        tst.w        -$7ffe(a6)                                    ; $0119BA
        bne.b        UiRoutine_0119BA                              ; $0119BE
        move.w       -$6f6a(a6), d0                                ; $0119C0
        lsl.w        #$8, d0                                       ; $0119C4
        lsl.w        #$1, d0                                       ; $0119C6
        addi.w       #$93e0, d0                                    ; $0119C8
        move.w       d0, d5                                        ; $0119CC
        movea.l      #VDP_DATA, a4                                 ; $0119CE
        lea.l        rInventorySlots(a6), a0                       ; $0119D4
        move.w       -$6f6a(a6), d0                                ; $0119D8
        mulu.w       #$4, d0                                       ; $0119DC
        cmpi.w       #$100, $2(a0, d0.w)                           ; $0119E0
        bls.b        loc_011A1A                                    ; $0119E6
        subi.w       #$100, $2(a0, d0.w)                           ; $0119E8
        move.w       $2(a0, d0.w), -(a7)                           ; $0119EE
        move.w       d5, d0                                        ; $0119F2
        addi.w       #$68, d0                                      ; $0119F4
        move.w       d0, d1                                        ; $0119F8
        andi.w       #$3fff, d1                                    ; $0119FA
        ori.w        #$4000, d1                                    ; $0119FE
        swap         d1                                            ; $011A02
        lsr.w        #$8, d0                                       ; $011A04
        lsr.w        #$6, d0                                       ; $011A06
        move.w       d0, d1                                        ; $011A08
        move.l       d1, VDP_CONTROL.l                             ; $011A0A
        move.w       (a7)+, d0                                     ; $011A10
        subq.w       #$1, d0                                       ; $011A12
        lsr.w        #$8, d0                                       ; $011A14
        addq.w       #$1, d0                                       ; $011A16
        rts                                                        ; $011A18

loc_011A1A:
        move.w       #$1, -$558e(a6)                               ; $011A1A
        clr.w        (a0, d0.w)                                    ; $011A20
        clr.w        $2(a0, d0.w)                                  ; $011A24
        move.w       #$f, d6                                       ; $011A28
        moveq        #$0, d7                                       ; $011A2C
        move.w       d5, d0                                        ; $011A2E
        lea.l        rInventorySlots(a6), a0                       ; $011A30
        move.w       #$5, d7                                       ; $011A34
        adda.w       #$14, a0                                      ; $011A38
        cmpi.w       #$6, (a0)                                     ; $011A3C
        beq.b        loc_011A58                                    ; $011A40
        move.w       #$ffff, -$6f6a(a6)                            ; $011A42
        move.w       rSceneColorMode(a6), d0                       ; $011A48
        move.w       #$ffff, rSceneColorMode(a6)                   ; $011A4C
        jmp          SelectSceneColorMode.l                        ; $011A52

loc_011A58:
        move.w       d7, -$6f6a(a6)                                ; $011A58
        rts                                                        ; $011A5C
        ifne *-$11A5E
        fail "ROM end moved"
        endif
