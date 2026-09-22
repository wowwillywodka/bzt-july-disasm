; $02049E..$0204BD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер входящих команд линк-кабеля: цикл чтения пакетов из RX-кольца (0x20010) в буфер (-0x6FDC,A6), по байту-опкоду (<0x1B) прыжок через jump-table (0x204BE,PC) на обработчик команды партнёра
        ifne *-$2049E
        fail "ROM start moved"
        endif

ExecuteLinkCommands:
        lea.l        -$6fdc(a6), a0                                ; $02049E
        bsr.w        InputRoutine_020010                           ; $0204A2
        bne.b        loc_0204AA                                    ; $0204A6
        rts                                                        ; $0204A8

loc_0204AA:
        clr.w        d0                                            ; $0204AA
        move.b       (a0)+, d0                                     ; $0204AC
        cmpi.b       #$1b, d0                                      ; $0204AE
        bcc.b        ExecuteLinkCommands                           ; $0204B2
        lsl.w        #$2, d0                                       ; $0204B4
        movea.l      LinkCommandHandlers(pc, d0.w), a1             ; $0204B6
        jsr          (a1)                                          ; $0204BA
        bra.b        ExecuteLinkCommands                           ; $0204BC
        ifne *-$204BE
        fail "ROM end moved"
        endif
