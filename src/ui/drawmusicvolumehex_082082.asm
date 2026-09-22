; $082082..$0820C1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Печать значения громкости музыки в hex: берёт байт $FF2A4F, разбивает на старший/младший ниббл, транслирует через символьную таблицу 0x8226c в ASCIIZ-буфер $FF1024, выводит строку тайлами через 0x7b552
        ifne *-$82082
        fail "ROM start moved"
        endif

DrawMusicVolumeHex:
        lea.l        HexadecimalDigits.l, a0                       ; $082082
        lea.l        $ff1024.l, a1                                 ; $082088
        clr.w        d0                                            ; $08208E
        move.b       $ff2a4f.l, d0                                 ; $082090
        move.b       d0, d1                                        ; $082096
        andi.w       #$f0, d0                                      ; $082098
        lsr.w        #$4, d0                                       ; $08209C
        move.b       (a0, d0.w), d0                                ; $08209E
        move.b       d0, (a1)+                                     ; $0820A2
        andi.w       #$f, d1                                       ; $0820A4
        move.b       (a0, d1.w), d0                                ; $0820A8
        move.b       d0, (a1)+                                     ; $0820AC
        move.b       #$0, (a1)                                     ; $0820AE
        lea.l        $ff1024.l, a0                                 ; $0820B2
        move.w       #$c72c, d0                                    ; $0820B8
        jsr          PrintCharacterMenuText(pc)                    ; $0820BC
        rts                                                        ; $0820C0
        ifne *-$820C2
        fail "ROM end moved"
        endif
