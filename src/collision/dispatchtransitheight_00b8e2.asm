; $00B8E2..$00B917 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обработка хода игрока: диспетчер действий по D3 (таблица @0xB91A), поворот мини-карты (-0x6e4c шагом 4), скольжение вдоль стен по celltype соседних клеток (0x32-0x5B) с вызовом x/y-сдвига 0x98A9E/0x98AA6/0x98AA2 и обновлением угла (-0x71ee)
        ifne *-$B8E2
        fail "ROM start moved"
        endif

DispatchTransitHeight:
        cmpi.b       #$12, d3                                      ; $00B8E2
        bcc.b        loc_00B8EA                                    ; $00B8E6
        rts                                                        ; $00B8E8

loc_00B8EA:
        cmpi.b       #$4f, d3                                      ; $00B8EA
        bhi.b        loc_00B902                                    ; $00B8EE
        lea.l        TransitHeightHandlers(pc), a1                 ; $00B8F0
        move.w       d3, d0                                        ; $00B8F4
        subi.w       #$12, d0                                      ; $00B8F6
        lsl.w        #$2, d0                                       ; $00B8FA
        movea.l      (a1, d0.w), a1                                ; $00B8FC
        jsr          (a1)                                          ; $00B900

loc_00B902:
        cmpi.w       #$1, -$6e4a(a6)                               ; $00B902
        beq.w        loc_00BB66                                    ; $00B908
        cmpi.w       #$ffff, -$6e4a(a6)                            ; $00B90C
        beq.w        loc_00BBA8                                    ; $00B912
        rts                                                        ; $00B916
        ifne *-$B918
        fail "ROM end moved"
        endif
