; $000C70..$000CBF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Очистка видеопамяти: VRAM-write @3 ($40000003), D7=$6FF, цикл move.w #0,$C00000 dbf (заливка $700 слов VRAM нулями), затем 2 слова через VRAM-write @0xBC00 ($7c000002) и 2 слова VSRAM-write @0 ($40000010)
        ifne *-$C70
        fail "ROM start moved"
        endif

ClearVideoMemory:
        move.l       #$40000003, VDP_CONTROL.l                     ; $000C70
        move.w       #$6ff, d7                                     ; $000C7A

loc_000C7E:
        move.w       #$0, VDP_DATA.l                               ; $000C7E
        dbra         d7, loc_000C7E                                ; $000C86
        move.l       #$7c000002, VDP_CONTROL.l                     ; $000C8A
        move.w       #$0, VDP_DATA.l                               ; $000C94
        move.w       #$0, VDP_DATA.l                               ; $000C9C
        move.l       #$40000010, VDP_CONTROL.l                     ; $000CA4
        move.w       #$0, VDP_DATA.l                               ; $000CAE
        move.w       #$0, VDP_DATA.l                               ; $000CB6
        rts                                                        ; $000CBE
        ifne *-$CC0
        fail "ROM end moved"
        endif
