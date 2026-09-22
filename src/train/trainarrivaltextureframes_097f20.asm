; $097F20..$097FD7 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97F20
        fail "ROM start moved"
        endif

TrainArrivalTextureFrames equ $097F20
TrainArrivalTextureFrames01 equ $097F28
TrainArrivalTextureFrames02 equ $097F30
TrainArrivalTextureFrames03 equ $097F38
TrainArrivalTextureFrames04 equ $097F40
TrainArrivalTextureFrames05 equ $097F48
TrainArrivalTextureFrames06 equ $097F50
TrainArrivalTextureFrames07 equ $097F58
TrainArrivalTextureFrames08 equ $097F60
TrainArrivalTextureFrames09 equ $097F68
TrainArrivalTextureFrames10 equ $097F70
TrainArrivalTextureFrames11 equ $097F78
TrainArrivalTextureFrames12 equ $097F80
TrainArrivalTextureFrames13 equ $097F88
TrainArrivalTextureFrames14 equ $097F90
TrainArrivalTextureFrames15 equ $097F98
TrainArrivalTextureFrames16 equ $097FA0
TrainArrivalTextureFrames17 equ $097FA8
TrainArrivalTextureFrames18 equ $097FB0
TrainArrivalTextureFrames19 equ $097FB8
TrainArrivalTextureFrames20 equ $097FC0
TrainArrivalTextureFrames21 equ $097FC8
TrainArrivalTextureFrames22 equ $097FD0

        incbin "generated/data/097f20.bin"
        ifne *-$97FD8
        fail "ROM end moved"
        endif
