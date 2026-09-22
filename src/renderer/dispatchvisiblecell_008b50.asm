; $008B50..$008B83 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; ⭐СПЕЦ-РЕНДЕР ДИСПЕТЧЕР July (копия June 89EC, вкл. кейс ct 0x25/-0x790E): таблица @0x8B84, раскладка June + НОВОЕ: **11 индивидуальных ниш-врагов** (ct 0x27/0x29-0x2B/0x65/0x66/0x68/0x6A/0x6B/0x08/0x09 → сеттеры 9418-94E0), разрушаемые +ct 0x86/0x87, спавн-клетка ct 0x26 → 0xA2B2, НОВЫЕ ct 0x8D/0x8E/0x8F → B1D6/B082/B280 [VERIFIED]
        ifne *-$8B50
        fail "ROM start moved"
        endif

DispatchVisibleCell:
        move.l       a3, -(a7)                                     ; $008B50
        andi.w       #$ff, d3                                      ; $008B52
        cmpi.b       #$25, d3                                      ; $008B56
        bne.b        loc_008B72                                    ; $008B5A
        move.w       d0, -(a7)                                     ; $008B5C
        move.b       -$790e(a6), d0                                ; $008B5E
        tst.w        -$715a(a6)                                    ; $008B62
        bne.b        loc_008B70                                    ; $008B66
        move.b       d0, (a0)                                      ; $008B68
        jsr          CommitMapCellAndSendLink.l                    ; $008B6A

loc_008B70:
        move.w       (a7)+, d0                                     ; $008B70

loc_008B72:
        lsl.w        #$2, d3                                       ; $008B72
        move.l       a4, -(a7)                                     ; $008B74
        movea.l      VisibleCellHandlers(pc, d3.w), a4             ; $008B76
        lsr.w        #$2, d3                                       ; $008B7A
        jsr          (a4)                                          ; $008B7C
        movea.l      (a7)+, a4                                     ; $008B7E
        movea.l      (a7)+, a3                                     ; $008B80
        rts                                                        ; $008B82
        ifne *-$8B84
        fail "ROM end moved"
        endif
