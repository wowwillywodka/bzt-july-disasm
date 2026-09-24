; $00F838..$00F8BB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка фиксированных оверлей-спрайтов: пишет хардкод записи спрайт-атрибутов (Y=0xf8/0x88, tile, link) в буфер (-0x7fc2,A6), зовёт 0x113ea/0x12904, при (-0x20be,A6)==1 добавляет ещё один спрайт
        ifne *-$F838
        fail "ROM start moved"
        endif

AppendGameplayOverlaySpritesToSat:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $00F838
        bsr.w        AppendInventoryHudSpritesToSat                              ; $00F83C
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $00F840
        ori.w        #$300, d0                                     ; $00F844
        addq.w       #$4, rSpriteAttributeNextLink(a6)                               ; $00F848
        move.w       #$f8, (a2)+                                   ; $00F84C
        move.w       d0, (a2)+                                     ; $00F850
        addq.w       #$1, d0                                       ; $00F852
        move.w       #$8001, (a2)+                                 ; $00F854
        move.w       #$1, (a2)+                                    ; $00F858
        move.w       #$f8, (a2)+                                   ; $00F85C
        move.w       d0, (a2)+                                     ; $00F860
        addq.w       #$1, d0                                       ; $00F862
        move.w       #$8001, (a2)+                                 ; $00F864
        clr.w        (a2)+                                         ; $00F868
        move.w       #$88, (a2)+                                   ; $00F86A
        move.w       d0, (a2)+                                     ; $00F86E
        addq.w       #$1, d0                                       ; $00F870
        move.w       #$8001, (a2)+                                 ; $00F872
        move.w       #$1, (a2)+                                    ; $00F876
        move.w       #$88, (a2)+                                   ; $00F87A
        move.w       d0, (a2)+                                     ; $00F87E
        addq.w       #$1, d0                                       ; $00F880
        move.w       #$8001, (a2)+                                 ; $00F882
        clr.w        (a2)+                                         ; $00F886
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $00F888
        bsr.w        UpdatePlayerWeaponAndDraw                     ; $00F88C
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $00F890
        cmpi.w       #$1, rWallOpeningPermit(a6)                   ; $00F894
        bne.b        loc_00F8B6                                    ; $00F89A
        move.w       #$b6, (a2)+                                   ; $00F89C
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $00F8A0
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $00F8A4
        ori.w        #$500, d0                                     ; $00F8A8
        move.w       d0, (a2)+                                     ; $00F8AC
        move.w       #$e53d, (a2)+                                 ; $00F8AE
        move.w       #$89, (a2)+                                   ; $00F8B2

loc_00F8B6:
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $00F8B6
        rts                                                        ; $00F8BA
        ifne *-$F8BC
        fail "ROM end moved"
        endif
