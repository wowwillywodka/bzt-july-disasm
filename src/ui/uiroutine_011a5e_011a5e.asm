; $011A5E..$011B0B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обновление иконки HUD по индексу (-0x6f68,A6): vblank-wait; VRAM-адрес тайла = (idx<<9)-0x6c20; при счётчике слота (0x2,-0x6fa0+idx*4)>0x100 вычитает 0x100 и взводит VDP-запись в VRAM (0xc00004); иначе стирает тайл (clr слота, VDP-write D5), и если (-0x6fa0+0x18)==1 ставит (-0x6f68)=6, иначе -1
        ifne *-$11A5E
        fail "ROM start moved"
        endif

UiRoutine_011A5E:
        tst.w        -$7ffe(a6)                                    ; $011A5E
        bne.b        UiRoutine_011A5E                              ; $011A62
        move.w       -$6f68(a6), d0                                ; $011A64
        lsl.w        #$8, d0                                       ; $011A68
        lsl.w        #$1, d0                                       ; $011A6A
        addi.w       #$93e0, d0                                    ; $011A6C
        move.w       d0, d5                                        ; $011A70
        movea.l      #VDP_DATA, a4                                 ; $011A72
        lea.l        rInventorySlots(a6), a0                       ; $011A78
        move.w       -$6f68(a6), d0                                ; $011A7C
        mulu.w       #$4, d0                                       ; $011A80
        cmpi.w       #$100, $2(a0, d0.w)                           ; $011A84
        bls.b        loc_011ABE                                    ; $011A8A
        subi.w       #$100, $2(a0, d0.w)                           ; $011A8C
        move.w       $2(a0, d0.w), -(a7)                           ; $011A92
        move.w       d5, d0                                        ; $011A96
        addi.w       #$68, d0                                      ; $011A98
        move.w       d0, d1                                        ; $011A9C
        andi.w       #$3fff, d1                                    ; $011A9E
        ori.w        #$4000, d1                                    ; $011AA2
        swap         d1                                            ; $011AA6
        lsr.w        #$8, d0                                       ; $011AA8
        lsr.w        #$6, d0                                       ; $011AAA
        move.w       d0, d1                                        ; $011AAC
        move.l       d1, VDP_CONTROL.l                             ; $011AAE
        move.w       (a7)+, d0                                     ; $011AB4
        subq.w       #$1, d0                                       ; $011AB6
        lsr.w        #$8, d0                                       ; $011AB8
        addq.w       #$1, d0                                       ; $011ABA
        rts                                                        ; $011ABC

loc_011ABE:
        move.w       #$1, -$558e(a6)                               ; $011ABE
        clr.w        (a0, d0.w)                                    ; $011AC4
        clr.w        $2(a0, d0.w)                                  ; $011AC8
        move.w       #$f, d6                                       ; $011ACC
        moveq        #$0, d7                                       ; $011AD0
        move.w       d5, d0                                        ; $011AD2
        move.w       d0, d1                                        ; $011AD4
        andi.w       #$3fff, d1                                    ; $011AD6
        ori.w        #$4000, d1                                    ; $011ADA
        swap         d1                                            ; $011ADE
        lsr.w        #$8, d0                                       ; $011AE0
        lsr.w        #$6, d0                                       ; $011AE2
        move.w       d0, d1                                        ; $011AE4
        move.l       d1, VDP_CONTROL.l                             ; $011AE6
        lea.l        rInventorySlots(a6), a0                       ; $011AEC
        move.w       #$6, d7                                       ; $011AF0
        adda.w       #$18, a0                                      ; $011AF4
        cmpi.w       #$1, (a0)                                     ; $011AF8
        beq.b        loc_011B06                                    ; $011AFC
        move.w       #$ffff, -$6f68(a6)                            ; $011AFE
        rts                                                        ; $011B04

loc_011B06:
        move.w       d7, -$6f68(a6)                                ; $011B06
        rts                                                        ; $011B0A
        ifne *-$11B0C
        fail "ROM end moved"
        endif
