; $02052A..$020533 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x2049E] Диспетчер входящих команд линк-кабеля: цикл чтения пакетов из RX-кольца (0x20010) в буфер (-0x6FDC,A6), по байту-опкоду (<0x1B) прыжок через jump-table (0x204BE,PC) на обработчик команды партнёра
        ifne *-$2052A
        fail "ROM start moved"
        endif

loc_02052A:
        cmpi.w       #$2, rLinkRole(a6)                            ; $02052A
        beq.b        ObjectsRoutine_020534                         ; $020530
        rts                                                        ; $020532
        ifne *-$20534
        fail "ROM end moved"
        endif
