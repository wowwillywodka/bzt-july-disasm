; $00DCBE..$00DCC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Guard-детектор изменения угла поворота: сравнивает текущий сдвиг колонн (-0x71d8,A6) с кэшем (-0x71d4,A6); если равны — rts, иначе проваливается в 0xDCCA для перестройки буфера колонн стен
        ifne *-$DCBE
        fail "ROM start moved"
        endif

RendererRoutine_00DCBE:
        move.w       -$71d8(a6), d0                                ; $00DCBE
        cmp.w        -$71d4(a6), d0                                ; $00DCC2
        bne.b        ResampleSceneBackgroundProfile                ; $00DCC6
        rts                                                        ; $00DCC8
        ifne *-$DCCA
        fail "ROM end moved"
        endif
