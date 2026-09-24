; $0028A4..$0028AB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x2800] Тик анимации HUD-маркера: декремент таймера -$6f4d(a6); на значении 8 играет звук $e (jsr $df84) и трижды bsr $28a4 (доп.рендер); по фазе (&7)*8 индексирует таблицу $2864 и пишет 4-словную VDP-запись в (A2)+ со смещениям
        ifne *-$28A4
        fail "ROM start moved"
        endif

; Reviewed call entry (helper): Checks rLinkRole; otherwise returns without queuing command $16.
QueueRetainedEffectLinkCommandIfConnected:
        tst.w        rLinkRole(a6)                                 ; $0028A4
        bne.b        QueueLinkCommand16                           ; $0028A8
        rts                                                        ; $0028AA
        ifne *-$28AC
        fail "ROM end moved"
        endif
