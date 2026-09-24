; $02176C..$021783 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Подготовка экрана: чистит CRAM (0x21dc2) и весь VRAM (0x21dde, 0x8000 слов 0), затем move -0x10→D0 и 0x21e4a пишет в VSRAM (вертикальный скролл)
        ifne *-$2176C
        fail "ROM start moved"
        endif

ClearVideoAndSetScrollMinus16:
        jsr          ClearCram.l                                   ; $02176C
        jsr          ClearAllVram.l                                ; $021772
        move.w       #$fff0, d0                                    ; $021778
        jsr          WriteVerticalScrollToVsram.l                         ; $02177C
        rts                                                        ; $021782
        ifne *-$21784
        fail "ROM end moved"
        endif
