; $01BFCE..$01BFE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация буферов рендера актёров: обнуляет список спрайтов (-0x6dc6,A6, 0xb00 слов), счётчик актёров (-0x57c6), указатель списка (-0x57c4) и (-0x6fe0,A6)
        ifne *-$1BFCE
        fail "ROM start moved"
        endif

ResetActorPool:
; Clear all 64 * $58 bytes. AllocateActor does NOT perform this full reset.
        lea.l        rActorPool(a6), a0                            ; $01BFCE
        move.w       #ActorPoolClearWords-1, d0                    ; $01BFD2

loc_01BFD6:
        clr.w        (a0)+                                         ; $01BFD6
        dbra         d0, loc_01BFD6                                ; $01BFD8
        clr.w        rActiveActorCount(a6)                         ; $01BFDC
        clr.l        rActiveActorHead(a6)                          ; $01BFE0
        clr.w        -$6fe0(a6)                                    ; $01BFE4
        rts                                                        ; $01BFE8
        ifne *-$1BFEA
        fail "ROM end moved"
        endif
