; $07AE76..$07AEC7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запуск музыки/SFX по коду из (-0x55ae,A6): обнуляет ячейку, индексирует 3-байтную таблицу (тип/трек/параметр) @(-0x3f8,PC); при типе==0 (а также любом >2) толкает трек в GEMS через jsr 0x7a964, типы 1/2 пропускает
        ifne *-$7AE76
        fail "ROM start moved"
        endif

PlayPendingSequence:
        move.w       -$55ae(a6), d0                                ; $07AE76
        clr.w        -$55ae(a6)                                    ; $07AE7A
        move.l       a6, -(a7)                                     ; $07AE7E
        andi.l       #$ff, d0                                      ; $07AE80
        mulu.w       #$3, d0                                       ; $07AE86
        clr.l        d1                                            ; $07AE8A
        clr.l        d2                                            ; $07AE8C
        lea.l        SoundEventRecords(pc), a0                     ; $07AE8E
        move.b       (a0, d0.w), d1                                ; $07AE92
        move.b       $2(a0, d0.w), d2                              ; $07AE96
        move.b       $1(a0, d0.w), d0                              ; $07AE9A
        andi.l       #$ff, d0                                      ; $07AE9E
        cmpi.w       #$0, d1                                       ; $07AEA4
        beq.w        loc_07AEBC                                    ; $07AEA8
        cmpi.w       #$1, d1                                       ; $07AEAC
        beq.w        loc_07AEC4                                    ; $07AEB0
        cmpi.w       #$2, d1                                       ; $07AEB4
        beq.w        loc_07AEC4                                    ; $07AEB8

loc_07AEBC:
        move.l       d0, -(a7)                                     ; $07AEBC
        jsr          SoundRoutine_07A964(pc)                       ; $07AEBE
        addq.l       #$4, a7                                       ; $07AEC2

loc_07AEC4:
        movea.l      (a7)+, a6                                     ; $07AEC4
        rts                                                        ; $07AEC6
        ifne *-$7AEC8
        fail "ROM end moved"
        endif
