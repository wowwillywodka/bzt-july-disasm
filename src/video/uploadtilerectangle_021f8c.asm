; $021F8C..$021FC1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка спрайтовых тайлов в VRAM: по размеру D1×D2 (в тайлах, /8) читает индексы из (A1)+, по индексу<<5 берёт тайл из (A0) и пишет в VRAM через FUN_21e1e
        ifne *-$21F8C
        fail "ROM start moved"
        endif

UploadTileRectangle:
        movem.l      a1, -(a7)                                     ; $021F8C
        andi.l       #$ff, d1                                      ; $021F90
        andi.l       #$ff, d2                                      ; $021F96
        asr.b        #$3, d1                                       ; $021F9C
        asr.b        #$3, d2                                       ; $021F9E
        mulu.w       d1, d2                                        ; $021FA0
        subq.w       #$1, d2                                       ; $021FA2

loc_021FA4:
        move.w       (a1)+, d3                                     ; $021FA4
        movem.l      d0/d2/a0-a1, -(a7)                            ; $021FA6
        asl.l        #$5, d3                                       ; $021FAA
        adda.l       d3, a0                                        ; $021FAC
        moveq        #$1, d1                                       ; $021FAE
        jsr          UploadTiles(pc)                               ; $021FB0
        movem.l      (a7)+, d0/d2/a0-a1                            ; $021FB4
        addq.w       #$1, d0                                       ; $021FB8
        dbra         d2, loc_021FA4                                ; $021FBA
        movea.l      (a7)+, a1                                     ; $021FBE
        rts                                                        ; $021FC0
        ifne *-$21FC2
        fail "ROM end moved"
        endif
