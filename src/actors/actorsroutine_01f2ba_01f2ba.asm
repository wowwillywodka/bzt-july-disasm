; $01F2BA..$01F2C1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 199E6] Отрисовка актёра (спрайт-набор $1c73a2): кадр d0=1/d2=3, строит draw-пакет типа $d по $38/$39, шлёт в очередь рендера $1a342 с ветвлением по направлению
        ifne *-$1F2BA
        fail "ROM start moved"
        endif

ActorsRoutine_01F2BA:
        move.w       #$1, d0                                       ; $01F2BA
        move.w       #$3, d2                                       ; $01F2BE
        ifne *-$1F2C2
        fail "ROM end moved"
        endif
