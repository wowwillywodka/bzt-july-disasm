; $020058..$020087 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главный цикл обмена по линк-кабелю при активной сессии (-0x53A4,A6): jsr $1A78, при значении 1 шлёт пакет 0x20088, парсит входящий 0x2049E, крутится пока head!=tail TX-кольца (-0x5392/-0x5394,A6)
        ifne *-$20058
        fail "ROM start moved"
        endif

InputRoutine_020058:
        tst.w        rLinkRole(a6)                                 ; $020058
        beq.b        loc_020086                                    ; $02005C

loc_02005E:
        jsr          WaitForVBlank.w                               ; $02005E
        tst.w        rLinkRole(a6)                                 ; $020062
        beq.b        loc_020086                                    ; $020066
        cmpi.w       #$1, rLinkRole(a6)                            ; $020068
        bne.b        loc_020076                                    ; $02006E
        jsr          TransmitLinkCommands.l                        ; $020070

loc_020076:
        jsr          ExecuteLinkCommands.l                         ; $020076
        move.w       -$5392(a6), d0                                ; $02007C
        cmp.w        -$5394(a6), d0                                ; $020080
        bne.b        loc_02005E                                    ; $020084

loc_020086:
        rts                                                        ; $020086
        ifne *-$20088
        fail "ROM end moved"
        endif
