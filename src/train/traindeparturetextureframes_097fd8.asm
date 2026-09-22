; $097FD8..$09808F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97FD8
        fail "ROM start moved"
        endif

TrainDepartureTextureFrames equ $097FD8
TrainDepartureTextureFrames01 equ $097FE0
TrainDepartureTextureFrames02 equ $097FE8
TrainDepartureTextureFrames03 equ $097FF0
TrainDepartureTextureFrames04 equ $097FF8
TrainDepartureTextureFrames05 equ $098000
TrainDepartureTextureFrames06 equ $098008
TrainDepartureTextureFrames07 equ $098010
TrainDepartureTextureFrames08 equ $098018
TrainDepartureTextureFrames09 equ $098020
TrainDepartureTextureFrames10 equ $098028
TrainDepartureTextureFrames11 equ $098030
TrainDepartureTextureFrames12 equ $098038
TrainDepartureTextureFrames13 equ $098040
TrainDepartureTextureFrames14 equ $098048
TrainDepartureTextureFrames15 equ $098050
TrainDepartureTextureFrames16 equ $098058
TrainDepartureTextureFrames17 equ $098060
TrainDepartureTextureFrames18 equ $098068
TrainDepartureTextureFrames19 equ $098070
TrainDepartureTextureFrames20 equ $098078
TrainDepartureTextureFrames21 equ $098080
TrainDepartureTextureFrames22 equ $098088

        incbin "generated/data/097fd8.bin"
        ifne *-$98090
        fail "ROM end moved"
        endif
