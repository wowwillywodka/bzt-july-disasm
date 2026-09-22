; $01F8A4..$01F8CF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Ставит vfunc отрисовки (0x1e,A0)=0x1f822 и шлёт пакет тип $12 (id 0x42, флаги 0x4(a0)|0x20, кадр 0x36) в очередь 0x1ffcc
        ifne *-$1F8A4
        fail "ROM start moved"
        endif

RendererRoutine_01F8A4:
        move.l       #RendererRoutine_01F822, ActorLinkCallback(a0) ; $01F8A4
        lea.l        -$6fdc(a6), a1                                ; $01F8AC
        move.b       #$12, (a1)+                                   ; $01F8B0
        move.b       ActorLinkId(a0), (a1)+                        ; $01F8B4
        move.w       ActorFlags(a0), d0                            ; $01F8B8
        ori.w        #$20, d0                                      ; $01F8BC
        move.b       d0, (a1)+                                     ; $01F8C0
        move.b       ActorFloor(a0), (a1)+                         ; $01F8C2
        lea.l        -$6fdc(a6), a0                                ; $01F8C6
        jmp          QueueLinkCommand.l                            ; $01F8CA
        ifne *-$1F8D0
        fail "ROM end moved"
        endif
