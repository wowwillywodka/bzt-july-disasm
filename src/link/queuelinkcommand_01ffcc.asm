; $01FFCC..$02000F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановщик пакета в TX-кольцо линк-кабеля: пишет слова (A0)+ в буфер (-0x4B90,A6) по индексу head (-0x5392,A6), длину пакета берёт из PC-таблицы по коду команды, маска индекса &$7FF, не перезаписывает tail
        ifne *-$1FFCC
        fail "ROM start moved"
        endif

QueueLinkCommand:
        move.l       a2, -(a7)                                     ; $01FFCC
        lea.l        -$4b90(a6), a1                                ; $01FFCE
        move.w       -$5392(a6), d0                                ; $01FFD2
        clr.w        d1                                            ; $01FFD6
        move.b       (a0), d1                                      ; $01FFD8
        move.w       (a0)+, (a1, d0.w)                             ; $01FFDA
        lea.l        LinkCommandSizes(pc), a2                      ; $01FFDE
        move.b       (a2, d1.w), d1                                ; $01FFE2
        bmi.b        loc_01FFFC                                    ; $01FFE6

loc_01FFE8:
        addq.w       #$2, d0                                       ; $01FFE8
        andi.w       #$7ff, d0                                     ; $01FFEA
        cmp.w        -$5394(a6), d0                                ; $01FFEE
        beq.b        loc_02000C                                    ; $01FFF2
        move.w       (a0)+, (a1, d0.w)                             ; $01FFF4
        dbra         d1, loc_01FFE8                                ; $01FFF8

loc_01FFFC:
        addq.w       #$2, d0                                       ; $01FFFC
        andi.w       #$7ff, d0                                     ; $01FFFE
        cmp.w        -$5394(a6), d0                                ; $020002
        beq.b        loc_02000C                                    ; $020006
        move.w       d0, -$5392(a6)                                ; $020008

loc_02000C:
        movea.l      (a7)+, a2                                     ; $02000C
        rts                                                        ; $02000E
        ifne *-$20010
        fail "ROM end moved"
        endif
