; $009B78..$009B8D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; СПАВН ВРАГА July (аналог June 0x97be; def-таблица @0x9b8e): чистит клетку-маркер + актёр с анимацией материализации. Зовётся проксимити-сканером ~0x97dc и проджектайл-сканером ~0x1deaa
        ifne *-$9B78
        fail "ROM start moved"
        endif

SelectActorDefinitionFromCell:
        subq.w       #$1, d3                                       ; $009B78
        cmpi.w       #$e, d3                                       ; $009B7A
        ble.w        loc_009B84                                    ; $009B7E
        rts                                                        ; $009B82

loc_009B84:
        lsl.w        #$2, d3                                       ; $009B84
        move.l       ActorSpawnDefinitionPointers(pc, d3.w), rPendingActorDefinition(a6) ; $009B86
        bra.b        SpawnActorFromMapCell                         ; $009B8C
        ifne *-$9B8E
        fail "ROM end moved"
        endif
