; $01F1E8..$01F1F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Хвост построителя сетевого пакета синхронизации актёра (тип 0xd: id+поз+скорость, собран @0x1f174): ветка $39 ставит d2=1/2/3, общий выход $1f204 → enqueue пакета из $FF1024 (-0x6fdc) в кольцевой буфер событий $1ffcc
        ifne *-$1F1E8
        fail "ROM start moved"
        endif

ActorsRoutine_01F1E8:
        move.w       #$1, d0                                       ; $01F1E8
        move.w       #$1, d2                                       ; $01F1EC
        bra.b        loc_01F204                                    ; $01F1F0
        ifne *-$1F1F2
        fail "ROM end moved"
        endif
