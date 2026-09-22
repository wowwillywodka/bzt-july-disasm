; $00FD9A..$00FE5F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June ED7E] развёрнутый span-цикл текстурного рендера (двухступенчатая выборка (a2)+→(a1,d1)→(a3,d1), beq-прозрачность, dest+4) — June-аналог ZT F2B0
        ifne *-$FD9A
        fail "ROM start moved"
        endif

RendererRoutine_00FD9A:
        addq.w       #$4, a0                                       ; $00FD9A
        move.b       (a2)+, d1                                     ; $00FD9C
        move.b       (a1, d1.w), d1                                ; $00FD9E
        beq.b        loc_00FDA8                                    ; $00FDA2
        move.b       (a3, d1.w), (a0)                              ; $00FDA4

loc_00FDA8:
        addq.w       #$4, a0                                       ; $00FDA8
        move.b       (a2)+, d1                                     ; $00FDAA
        move.b       (a1, d1.w), d1                                ; $00FDAC
        beq.b        loc_00FDB6                                    ; $00FDB0
        move.b       (a3, d1.w), (a0)                              ; $00FDB2

loc_00FDB6:
        addq.w       #$4, a0                                       ; $00FDB6
        move.b       (a2)+, d1                                     ; $00FDB8
        move.b       (a1, d1.w), d1                                ; $00FDBA
        beq.b        loc_00FDC4                                    ; $00FDBE
        move.b       (a3, d1.w), (a0)                              ; $00FDC0

loc_00FDC4:
        addq.w       #$4, a0                                       ; $00FDC4
        move.b       (a2)+, d1                                     ; $00FDC6
        move.b       (a1, d1.w), d1                                ; $00FDC8
        beq.b        loc_00FDD2                                    ; $00FDCC
        move.b       (a3, d1.w), (a0)                              ; $00FDCE

loc_00FDD2:
        addq.w       #$4, a0                                       ; $00FDD2
        move.b       (a2)+, d1                                     ; $00FDD4
        move.b       (a1, d1.w), d1                                ; $00FDD6
        beq.b        loc_00FDE0                                    ; $00FDDA
        move.b       (a3, d1.w), (a0)                              ; $00FDDC

loc_00FDE0:
        addq.w       #$4, a0                                       ; $00FDE0
        move.b       (a2)+, d1                                     ; $00FDE2
        move.b       (a1, d1.w), d1                                ; $00FDE4
        beq.b        loc_00FDEE                                    ; $00FDE8
        move.b       (a3, d1.w), (a0)                              ; $00FDEA

loc_00FDEE:
        addq.w       #$4, a0                                       ; $00FDEE
        move.b       (a2)+, d1                                     ; $00FDF0
        move.b       (a1, d1.w), d1                                ; $00FDF2
        beq.b        loc_00FDFC                                    ; $00FDF6
        move.b       (a3, d1.w), (a0)                              ; $00FDF8

loc_00FDFC:
        addq.w       #$4, a0                                       ; $00FDFC
        move.b       (a2)+, d1                                     ; $00FDFE
        move.b       (a1, d1.w), d1                                ; $00FE00
        beq.b        loc_00FE0A                                    ; $00FE04
        move.b       (a3, d1.w), (a0)                              ; $00FE06

loc_00FE0A:
        addq.w       #$4, a0                                       ; $00FE0A
        move.b       (a2)+, d1                                     ; $00FE0C
        move.b       (a1, d1.w), d1                                ; $00FE0E
        beq.b        loc_00FE18                                    ; $00FE12
        move.b       (a3, d1.w), (a0)                              ; $00FE14

loc_00FE18:
        addq.w       #$4, a0                                       ; $00FE18
        move.b       (a2)+, d1                                     ; $00FE1A
        move.b       (a1, d1.w), d1                                ; $00FE1C
        beq.b        loc_00FE26                                    ; $00FE20
        move.b       (a3, d1.w), (a0)                              ; $00FE22

loc_00FE26:
        addq.w       #$4, a0                                       ; $00FE26
        move.b       (a2)+, d1                                     ; $00FE28
        move.b       (a1, d1.w), d1                                ; $00FE2A
        beq.b        loc_00FE34                                    ; $00FE2E
        move.b       (a3, d1.w), (a0)                              ; $00FE30

loc_00FE34:
        addq.w       #$4, a0                                       ; $00FE34
        move.b       (a2)+, d1                                     ; $00FE36
        move.b       (a1, d1.w), d1                                ; $00FE38
        beq.b        loc_00FE42                                    ; $00FE3C
        move.b       (a3, d1.w), (a0)                              ; $00FE3E

loc_00FE42:
        addq.w       #$4, a0                                       ; $00FE42
        move.b       (a2)+, d1                                     ; $00FE44
        move.b       (a1, d1.w), d1                                ; $00FE46
        beq.b        loc_00FE50                                    ; $00FE4A
        move.b       (a3, d1.w), (a0)                              ; $00FE4C

loc_00FE50:
        addq.w       #$4, a0                                       ; $00FE50
        move.b       (a2)+, d1                                     ; $00FE52
        move.b       (a1, d1.w), d1                                ; $00FE54
        beq.b        loc_00FE5E                                    ; $00FE58
        move.b       (a3, d1.w), (a0)                              ; $00FE5A

loc_00FE5E:
        addq.w       #$4, a0                                       ; $00FE5E
        ifne *-$FE60
        fail "ROM end moved"
        endif
