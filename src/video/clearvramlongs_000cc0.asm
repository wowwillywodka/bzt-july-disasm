; $000CC0..$000D4B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Очистка тайла в VRAM: VRAM-write ($40000000), 8× move.l D7(=0),$C00000 — обнуляет один тайл 32 байта, далее ставит VRAM-адрес $60000003 для следующей операции
        ifne *-$CC0
        fail "ROM start moved"
        endif

ClearVramLongs:
        move.l       #$40000000, VDP_CONTROL.l                     ; $000CC0
        moveq        #$0, d7                                       ; $000CCA
        move.l       d7, VDP_DATA.l                                ; $000CCC
        move.l       d7, VDP_DATA.l                                ; $000CD2
        move.l       d7, VDP_DATA.l                                ; $000CD8
        move.l       d7, VDP_DATA.l                                ; $000CDE
        move.l       d7, VDP_DATA.l                                ; $000CE4
        move.l       d7, VDP_DATA.l                                ; $000CEA
        move.l       d7, VDP_DATA.l                                ; $000CF0
        move.l       d7, VDP_DATA.l                                ; $000CF6
        move.l       #$60000003, VDP_CONTROL.l                     ; $000CFC
        move.w       #$7ff, d7                                     ; $000D06

loc_000D0A:
        move.w       #$8000, VDP_DATA.l                            ; $000D0A
        dbra         d7, loc_000D0A                                ; $000D12
        move.l       #$7c000002, VDP_CONTROL.l                     ; $000D16
        move.w       #$0, VDP_DATA.l                               ; $000D20
        move.w       #$0, VDP_DATA.l                               ; $000D28
        move.l       #$40000010, VDP_CONTROL.l                     ; $000D30
        move.w       #$0, VDP_DATA.l                               ; $000D3A
        move.w       #$0, VDP_DATA.l                               ; $000D42
        rts                                                        ; $000D4A
        ifne *-$D4C
        fail "ROM end moved"
        endif
