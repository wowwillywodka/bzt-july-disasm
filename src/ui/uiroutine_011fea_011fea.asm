; $011FEA..$012007 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Парная к 0x011F70 ветка возврата экрана: грузит CRAM-палитру из (-0x42ec,A6), сбрасывает признак (-0x7124,A6) в -1 и прыгает в 0x1d44 для отката перехода
        ifne *-$11FEA
        fail "ROM start moved"
        endif

UiRoutine_011FEA:
        move.w       #$3f, d0                                      ; $011FEA
        movea.l      rZoneScenePalette(a6), a0                     ; $011FEE
        jsr          UploadPalette.l                               ; $011FF2
        move.w       rSceneColorMode(a6), d0                       ; $011FF8
        move.w       #$ffff, rSceneColorMode(a6)                   ; $011FFC
        jmp          SelectSceneColorMode.l                        ; $012002
        ifne *-$12008
        fail "ROM end moved"
        endif
