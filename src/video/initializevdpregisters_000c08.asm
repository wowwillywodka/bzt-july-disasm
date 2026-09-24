; $000C08..$000C6F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация VDP-регистров: цикл move.w (A2)+,(A0=$C00004) ×19 из таблицы (0x1536,PC) загружает регистры $80-$92, затем VSRAM-write ($78000002) и два move.l #0,$C00000 — старт очистки VSRAM (часть FUN_000c08)
        ifne *-$C08
        fail "ROM start moved"
        endif

InitializeVdpRegisters:
        lea.l        VDP_CONTROL.l, a0                             ; $000C08
        lea.l        AlternateVdpRegisterPreset(pc), a2            ; $000C0E
        cmpi.w       #$2100, ramLinkPortStatusShadow.l                             ; $000C12
        beq.b        loc_000C20                                    ; $000C1A
        lea.l        GameVdpRegisterPreset(pc), a2                 ; $000C1C

loc_000C20:
        moveq        #$12, d7                                      ; $000C20

loc_000C22:
        move.w       (a2)+, (a0)                                   ; $000C22
        dbra         d7, loc_000C22                                ; $000C24
        move.l       #$78000002, VDP_CONTROL.l                     ; $000C28
        move.l       #$0, VDP_DATA.l                               ; $000C32
        move.l       #$0, VDP_DATA.l                               ; $000C3C
        move.l       #$7c000002, VDP_CONTROL.l                     ; $000C46
        move.l       #$0, VDP_DATA.l                               ; $000C50
        move.l       #$40000010, VDP_CONTROL.l                     ; $000C5A
        move.l       #$0, VDP_DATA.l                               ; $000C64
        rts                                                        ; $000C6E
        ifne *-$C70
        fail "ROM end moved"
        endif
