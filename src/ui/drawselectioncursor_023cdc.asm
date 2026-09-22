; $023CDC..$023CF5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка курсора/маркера меню по индексу выбора D3: Y = D3*16 + 0xF4, задаёт X=0x400, ширину 0x128, атрибут тайла $A4AE и вызывает примитив вывода спрайта/тайлов ($21fc2)
        ifne *-$23CDC
        fail "ROM start moved"
        endif

DrawSelectionCursor:
        lsl.w        #$4, d3                                       ; $023CDC
        addi.w       #$f4, d3                                      ; $023CDE
        moveq        #$0, d0                                       ; $023CE2
        move.w       #$400, d1                                     ; $023CE4
        move.w       #$128, d2                                     ; $023CE8
        move.w       #$a4ae, d4                                    ; $023CEC
        jsr          WriteHardwareSprite(pc)                       ; $023CF0
        rts                                                        ; $023CF4
        ifne *-$23CF6
        fail "ROM end moved"
        endif
