; $0978BE..$09791F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; ⭐ВРАГИ-«КЛЮЧИ»: проверка позы спавнящегося врага по 3Б-списку {этаж,x,y} в данных эпизода (-0x438A+-0x42FA); совпал → спавнер (9608) ставит +0x53=1 — враг НЕСЁТ ЗАРЯД лампы, отдаёт его в think (167E0/1830C/1955C/1A8F2/1B24E: $FF5F42=1, +0x53=0) [VERIFIED]. Плюс инит уровня 104C тоже ставит заряд=1 (лампа с начала уровня? — уточнить у пользователя)
        ifne *-$978BE
        fail "ROM start moved"
        endif

CheckEnemyKeyPosition:
        move.l       a1, -(a7)                                     ; $0978BE
        movem.w      d1-d3/d7, -(a7)                               ; $0978C0
        movea.l      rEpisodeGeometryRom(a6), a1                   ; $0978C4
        adda.w       rActorMarkerRomOffset(a6), a1                 ; $0978C8
        move.w       (a1)+, d7                                     ; $0978CC
        subq.w       #$1, d7                                       ; $0978CE
        bpl.b        loc_0978DE                                    ; $0978D0
        move.w       #$1, d0                                       ; $0978D2
        movea.l      (a7)+, a1                                     ; $0978D6
        movem.w      (a7)+, d1-d3/d7                               ; $0978D8
        rts                                                        ; $0978DC

loc_0978DE:
        move.b       rMapWindowOriginXLow(a6), d1                                ; $0978DE
        move.b       rMapWindowOriginYLow(a6), d2                                ; $0978E2
; Marker-list discriminator; no explicit actor-field producer found in the reviewed July code.
        move.b       ActorMarkerKind(a0), d3                       ; $0978E6
        add.b        ActorCellX(a0), d1                            ; $0978EA
        add.b        ActorCellY(a0), d2                            ; $0978EE

loc_0978F2:
        cmp.b        (a1), d3                                      ; $0978F2
        bne.b        loc_09790E                                    ; $0978F4
        cmp.b        $1(a1), d1                                    ; $0978F6
        bne.b        loc_09790E                                    ; $0978FA
        cmp.b        $2(a1), d2                                    ; $0978FC
        bne.b        loc_09790E                                    ; $097900
        movea.l      (a7)+, a1                                     ; $097902
        movem.w      (a7)+, d1-d3/d7                               ; $097904
        move.w       #$0, d0                                       ; $097908
        rts                                                        ; $09790C

loc_09790E:
        addq.w       #$3, a1                                       ; $09790E
        dbra         d7, loc_0978F2                                ; $097910
        movea.l      (a7)+, a1                                     ; $097914
        movem.w      (a7)+, d1-d3/d7                               ; $097916
        move.w       #$1, d0                                       ; $09791A
        rts                                                        ; $09791E
        ifne *-$97920
        fail "ROM end moved"
        endif
