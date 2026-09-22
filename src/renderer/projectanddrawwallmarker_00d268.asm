; $00D268..$00D26D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0xD232] Проекция вершины 1 мир→камера: кэширует экранные X/Y в (-0x718a/-0x7188), вычитает камеру (-0x7206/-0x7204), поворот sin/cos (-0x71f2/-0x71f0), пишет камера-координаты (глубину/боковое) в (-0x7186)/(-0x7182) для последую
        ifne *-$D268
        fail "ROM start moved"
        endif

ProjectAndDrawWallMarker:
        lea.l        DrawProjectedWallMarker(pc), a5               ; $00D268
        bra.b        loc_00D27A                                    ; $00D26C
        ifne *-$D26E
        fail "ROM end moved"
        endif
