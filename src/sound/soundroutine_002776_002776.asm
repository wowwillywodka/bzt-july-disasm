; $002776..$002785 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Триггер позиционного звука/эффекта: D3=$64, D4=0, D0=$64, jmp $e024 (хвостовой вызов рутины панорамирования по дистанции -0x71d8/-0x6f66/-0x6fa6,A6); входу предшествует гейт cmpi #$fff6,(-0x71d8,A6)/bgt
        ifne *-$2776
        fail "ROM start moved"
        endif

SoundRoutine_002776:
        move.w       #$64, d3                                      ; $002776
        clr.w        d4                                            ; $00277A
        move.w       #$64, d0                                      ; $00277C
        jmp          ApplyPlayerDistanceHit.l                      ; $002780
        ifne *-$2786
        fail "ROM end moved"
        endif
