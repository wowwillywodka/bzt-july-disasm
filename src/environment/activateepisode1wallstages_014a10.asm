; $014A10..$014A19 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Only GeometryEpisode==0 enables staged walls. D0=cell radius, D1/D2=fixed-point center. Does not test damage amount or line of sight.
        ifne *-$14A10
        fail "ROM start moved"
        endif

ActivateEpisode1WallStages:
; Only GeometryEpisode==0 enables staged walls. D0=cell radius, D1/D2=fixed-point center. Does not test damage amount or line of sight.
        cmpi.w       #$0, rGeometryEpisode(a6)                     ; $014A10
        beq.b        QueueWallStagesInSquare                       ; $014A16
        rts                                                        ; $014A18
        ifne *-$14A1A
        fail "ROM end moved"
        endif
