; $002800..$002863 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Тик анимации HUD-маркера: декремент таймера -$6f4d(a6); на значении 8 играет звук $e (jsr $df84) и трижды bsr $28a4 (доп.рендер); по фазе (&7)*8 индексирует таблицу $2864 и пишет 4-словную VDP-запись в (A2)+ со смещениями addr/attr
        ifne *-$2800
        fail "ROM start moved"
        endif

TickRetainedPanoramaEffectMarker:
        subq.b       #$1, rRetainedPanoramaMarkerTicks(a6)                               ; $002800
        cmpi.b       #$8, rRetainedPanoramaMarkerTicks(a6)                               ; $002804
        bne.b        loc_002832                                    ; $00280A
        move.w       #$e, d0                                       ; $00280C
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $002810
        move.b       #$1, rRetainedPanoramaEffectBudget(a6)                               ; $002816
        move.b       #$20, rRetainedPanoramaEffectFrame(a6)                              ; $00281C
        bsr.w        QueueRetainedEffectLinkCommandIfConnected                                    ; $002822
        bsr.w        QueueRetainedEffectLinkCommandIfConnected                                    ; $002826
        bsr.w        QueueRetainedEffectLinkCommandIfConnected                                    ; $00282A
        clr.b        rRetainedPanoramaMarkerArmed(a6)                                    ; $00282E

loc_002832:
        clr.w        d0                                            ; $002832
        move.b       rRetainedPanoramaMarkerTicks(a6), d0                                ; $002834
        andi.w       #$7, d0                                       ; $002838
        lsl.w        #$3, d0                                       ; $00283C
        lea.l        RetainedEffectSpriteMappings(pc), a0          ; $00283E
        adda.w       d0, a0                                        ; $002842
        move.w       rRetainedPanoramaMarkerY(a6), d0                                ; $002844
        add.w        (a0)+, d0                                     ; $002848
        move.w       d0, (a2)+                                     ; $00284A
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $00284C
        or.w         (a0)+, d0                                     ; $002850
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $002852
        move.w       d0, (a2)+                                     ; $002856
        move.w       (a0)+, (a2)+                                  ; $002858
        move.w       rSceneShiftOrRetainedPanoramaX(a6), d0                                ; $00285A
        add.w        (a0)+, d0                                     ; $00285E
        move.w       d0, (a2)+                                     ; $002860
        rts                                                        ; $002862
        ifne *-$2864
        fail "ROM end moved"
        endif
