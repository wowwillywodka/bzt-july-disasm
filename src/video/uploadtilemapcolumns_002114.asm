; $002114..$002131 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Установка адреса записи VRAM: счётчик из $4(a0)→d6, сборка VDP-команды из адреса (andi #$3fff, ori #$4000, swap, lsr #8/#6) и move.l d1,$C00004 (контроль-порт VDP) перед блитом
        ifne *-$2114
        fail "ROM start moved"
        endif

UploadTilemapColumns:
        move.w       $4(a0), d6                                    ; $002114
        subq.w       #$1, d6                                       ; $002118
        movem.w      d0-d1, -(a7)                                  ; $00211A
        move.w       d1, d0                                        ; $00211E
        move.w       d0, d1                                        ; $002120
        andi.w       #$3fff, d1                                    ; $002122
        ori.w        #$4000, d1                                    ; $002126
        swap         d1                                            ; $00212A
        lsr.w        #$8, d0                                       ; $00212C
        lsr.w        #$6, d0                                       ; $00212E
        move.w       d0, d1                                        ; $002130
        ifne *-$2132
        fail "ROM end moved"
        endif
