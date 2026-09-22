; $081FE2..$082007 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка курсора/маркера выбранного пункта меню опций: по индексу D3 (с поправкой 5→6) вычисляет позицию спрайта (D3<<4 + 0xB4), задаёт X=0x400, ширину 0xB8, атрибут тайла $84AE и выводит спрайт через 0x21fc2
        ifne *-$81FE2
        fail "ROM start moved"
        endif

DrawOptionsCursor:
        cmpi.w       #$5, d3                                       ; $081FE2
        bne.w        loc_081FEC                                    ; $081FE6
        addq.w       #$1, d3                                       ; $081FEA

loc_081FEC:
        lsl.w        #$4, d3                                       ; $081FEC
        addi.w       #$b4, d3                                      ; $081FEE
        moveq        #$0, d0                                       ; $081FF2
        move.w       #$400, d1                                     ; $081FF4
        move.w       #$b8, d2                                      ; $081FF8
        move.w       #$84ae, d4                                    ; $081FFC
        jsr          WriteHardwareSprite.l                         ; $082000
        rts                                                        ; $082006
        ifne *-$82008
        fail "ROM end moved"
        endif
