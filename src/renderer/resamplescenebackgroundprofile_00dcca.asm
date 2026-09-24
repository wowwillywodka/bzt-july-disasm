; $00DCCA..$00DDF1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Resample two 80-byte background columns around their 40-byte halves.
; Safe input Z is -32..32; at +/-33 one byte crosses into adjacent RAM.
; See docs/RENDER_BUFFER_BOUNDS.md and audit_render_clipping.py.
        ifne *-$DCCA
        fail "ROM start moved"
        endif

ResampleSceneBackgroundProfile:
; Resample two 80-byte background columns around their 40-byte halves. At zero offset copy exactly 160 bytes into the renderer workspace.
        move.w       d0, rBackgroundProfileViewOffsetZ(a6)                                ; $00DCCA
        beq.w        loc_00DD52                                    ; $00DCCE
        bmi.w        loc_00DD6C                                    ; $00DCD2
        movea.l      rActiveSceneBackgroundProfile(a6), a5         ; $00DCD6
        lea.l        rSceneBackgroundColumns(a6), a4                                  ; $00DCDA
        move.w       #$28, d5                                      ; $00DCDE
        lea.l        $50(a5), a3                                   ; $00DCE2
        lea.l        $50(a4), a2                                   ; $00DCE6
        move.l       a5, -(a7)                                     ; $00DCEA
        move.w       d0, d1                                        ; $00DCEC
        asr.w        #$2, d1                                       ; $00DCEE
        add.w        d1, d0                                        ; $00DCF0
        move.w       d5, d1                                        ; $00DCF2
        sub.w        d0, d1                                        ; $00DCF4
        move.w       d0, d7                                        ; $00DCF6
        subq.w       #$1, d7                                       ; $00DCF8
        bmi.b        loc_00DD08                                    ; $00DCFA
        move.b       (a5), d3                                      ; $00DCFC
        move.b       (a3), d4                                      ; $00DCFE

loc_00DD00:
        move.b       d3, (a4)+                                     ; $00DD00
        move.b       d4, (a2)+                                     ; $00DD02
        dbra         d7, loc_00DD00                                ; $00DD04

loc_00DD08:
        move.w       d1, d7                                        ; $00DD08
        subq.w       #$1, d7                                       ; $00DD0A
        bmi.b        loc_00DD28                                    ; $00DD0C
        move.w       d1, d2                                        ; $00DD0E
        neg.w        d2                                            ; $00DD10

loc_00DD12:
        move.b       (a5)+, (a4)+                                  ; $00DD12
        move.b       (a3)+, (a2)+                                  ; $00DD14
        add.w        d5, d2                                        ; $00DD16
        sub.w        d1, d2                                        ; $00DD18
        bmi.b        loc_00DD24                                    ; $00DD1A

loc_00DD1C:
        addq.w       #$1, a5                                       ; $00DD1C
        addq.w       #$1, a3                                       ; $00DD1E
        sub.w        d1, d2                                        ; $00DD20
        bpl.b        loc_00DD1C                                    ; $00DD22

loc_00DD24:
        dbra         d7, loc_00DD12                                ; $00DD24

loc_00DD28:
        movea.l      (a7)+, a5                                     ; $00DD28
        lea.l        $28(a5), a5                                   ; $00DD2A
        lea.l        $50(a5), a3                                   ; $00DD2E
        add.w        d5, d0                                        ; $00DD32
        move.w       d0, d2                                        ; $00DD34
        neg.w        d2                                            ; $00DD36
        move.w       #$27, d7                                      ; $00DD38

loc_00DD3C:
        move.b       (a5), (a4)+                                   ; $00DD3C
        move.b       (a3), (a2)+                                   ; $00DD3E
        add.w        d5, d2                                        ; $00DD40
        bmi.b        loc_00DD4C                                    ; $00DD42

loc_00DD44:
        addq.w       #$1, a5                                       ; $00DD44
        addq.w       #$1, a3                                       ; $00DD46
        sub.w        d0, d2                                        ; $00DD48
        bpl.b        loc_00DD44                                    ; $00DD4A

loc_00DD4C:
        dbra         d7, loc_00DD3C                                ; $00DD4C
        rts                                                        ; $00DD50

loc_00DD52:
        move.w       #$9, d7                                       ; $00DD52
        movea.l      rActiveSceneBackgroundProfile(a6), a5         ; $00DD56
        lea.l        rSceneBackgroundColumns(a6), a4                                  ; $00DD5A

loc_00DD5E:
        move.l       (a5)+, (a4)+                                  ; $00DD5E
        move.l       (a5)+, (a4)+                                  ; $00DD60
        move.l       (a5)+, (a4)+                                  ; $00DD62
        move.l       (a5)+, (a4)+                                  ; $00DD64
        dbra         d7, loc_00DD5E                                ; $00DD66
        rts                                                        ; $00DD6A

loc_00DD6C:
        move.w       #$28, d5                                      ; $00DD6C
        movea.l      rActiveSceneBackgroundProfile(a6), a5         ; $00DD70
        lea.l        $50(a5), a5                                   ; $00DD74
        lea.l        rSceneBackgroundColumn1(a6), a4                                  ; $00DD78
        neg.w        d0                                            ; $00DD7C
        lea.l        $50(a5), a3                                   ; $00DD7E
        lea.l        $50(a4), a2                                   ; $00DD82
        move.l       a5, -(a7)                                     ; $00DD86
        move.w       d0, d1                                        ; $00DD88
        asr.w        #$2, d1                                       ; $00DD8A
        add.w        d1, d0                                        ; $00DD8C
        move.w       d5, d1                                        ; $00DD8E
        sub.w        d0, d1                                        ; $00DD90
        move.w       d0, d7                                        ; $00DD92
        subq.w       #$1, d7                                       ; $00DD94
        bmi.b        loc_00DDA8                                    ; $00DD96
        move.b       -$1(a5), d3                                   ; $00DD98
        move.b       -$1(a3), d4                                   ; $00DD9C

loc_00DDA0:
        move.b       d3, -(a4)                                     ; $00DDA0
        move.b       d4, -(a2)                                     ; $00DDA2
        dbra         d7, loc_00DDA0                                ; $00DDA4

loc_00DDA8:
        move.w       d1, d7                                        ; $00DDA8
        subq.w       #$1, d7                                       ; $00DDAA
        bmi.b        loc_00DDC8                                    ; $00DDAC
        move.w       d1, d2                                        ; $00DDAE
        neg.w        d2                                            ; $00DDB0

loc_00DDB2:
        move.b       -(a5), -(a4)                                  ; $00DDB2
        move.b       -(a3), -(a2)                                  ; $00DDB4
        add.w        d5, d2                                        ; $00DDB6
        sub.w        d1, d2                                        ; $00DDB8
        bmi.b        loc_00DDC4                                    ; $00DDBA

loc_00DDBC:
        subq.w       #$1, a5                                       ; $00DDBC
        subq.w       #$1, a3                                       ; $00DDBE
        sub.w        d1, d2                                        ; $00DDC0
        bpl.b        loc_00DDBC                                    ; $00DDC2

loc_00DDC4:
        dbra         d7, loc_00DDB2                                ; $00DDC4

loc_00DDC8:
        movea.l      (a7)+, a5                                     ; $00DDC8
        lea.l        -$29(a5), a5                                  ; $00DDCA
        lea.l        $50(a5), a3                                   ; $00DDCE
        add.w        d5, d0                                        ; $00DDD2
        move.w       d0, d2                                        ; $00DDD4
        neg.w        d2                                            ; $00DDD6
        move.w       #$27, d7                                      ; $00DDD8

loc_00DDDC:
        move.b       (a5), -(a4)                                   ; $00DDDC
        move.b       (a3), -(a2)                                   ; $00DDDE
        add.w        d5, d2                                        ; $00DDE0
        bmi.b        loc_00DDEC                                    ; $00DDE2

loc_00DDE4:
        subq.w       #$1, a5                                       ; $00DDE4
        subq.w       #$1, a3                                       ; $00DDE6
        sub.w        d0, d2                                        ; $00DDE8
        bpl.b        loc_00DDE4                                    ; $00DDEA

loc_00DDEC:
        dbra         d7, loc_00DDDC                                ; $00DDEC
        rts                                                        ; $00DDF0
        ifne *-$DDF2
        fail "ROM end moved"
        endif
