; $004090..$0041D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Exactly 80 byte-copy steps at four-byte destination stride, followed by RTS.
; Entry at $4090 copies all 80; each subsequent four-byte-aligned label skips
; one leading step. Pointer tables use these suffixes to preserve background
; pixels above/below the scaled wall center. See docs/WALL_SCALERS.md.
        ifne *-$4090
        fail "ROM start moved"
        endif

CopyTextureColumn:
        move.b       (a5)+, (a0)                                   ; $004090
        addq.w       #$4, a0                                       ; $004092

loc_004094:
        move.b       (a5)+, (a0)                                   ; $004094
        addq.w       #$4, a0                                       ; $004096

loc_004098:
        move.b       (a5)+, (a0)                                   ; $004098
        addq.w       #$4, a0                                       ; $00409A

loc_00409C:
        move.b       (a5)+, (a0)                                   ; $00409C
        addq.w       #$4, a0                                       ; $00409E

loc_0040A0:
        move.b       (a5)+, (a0)                                   ; $0040A0
        addq.w       #$4, a0                                       ; $0040A2

loc_0040A4:
        move.b       (a5)+, (a0)                                   ; $0040A4
        addq.w       #$4, a0                                       ; $0040A6

loc_0040A8:
        move.b       (a5)+, (a0)                                   ; $0040A8
        addq.w       #$4, a0                                       ; $0040AA

loc_0040AC:
        move.b       (a5)+, (a0)                                   ; $0040AC
        addq.w       #$4, a0                                       ; $0040AE

loc_0040B0:
        move.b       (a5)+, (a0)                                   ; $0040B0
        addq.w       #$4, a0                                       ; $0040B2

loc_0040B4:
        move.b       (a5)+, (a0)                                   ; $0040B4
        addq.w       #$4, a0                                       ; $0040B6

loc_0040B8:
        move.b       (a5)+, (a0)                                   ; $0040B8
        addq.w       #$4, a0                                       ; $0040BA

loc_0040BC:
        move.b       (a5)+, (a0)                                   ; $0040BC
        addq.w       #$4, a0                                       ; $0040BE

loc_0040C0:
        move.b       (a5)+, (a0)                                   ; $0040C0
        addq.w       #$4, a0                                       ; $0040C2

loc_0040C4:
        move.b       (a5)+, (a0)                                   ; $0040C4
        addq.w       #$4, a0                                       ; $0040C6

loc_0040C8:
        move.b       (a5)+, (a0)                                   ; $0040C8
        addq.w       #$4, a0                                       ; $0040CA

loc_0040CC:
        move.b       (a5)+, (a0)                                   ; $0040CC
        addq.w       #$4, a0                                       ; $0040CE

loc_0040D0:
        move.b       (a5)+, (a0)                                   ; $0040D0
        addq.w       #$4, a0                                       ; $0040D2

loc_0040D4:
        move.b       (a5)+, (a0)                                   ; $0040D4
        addq.w       #$4, a0                                       ; $0040D6

loc_0040D8:
        move.b       (a5)+, (a0)                                   ; $0040D8
        addq.w       #$4, a0                                       ; $0040DA

loc_0040DC:
        move.b       (a5)+, (a0)                                   ; $0040DC
        addq.w       #$4, a0                                       ; $0040DE

loc_0040E0:
        move.b       (a5)+, (a0)                                   ; $0040E0
        addq.w       #$4, a0                                       ; $0040E2

loc_0040E4:
        move.b       (a5)+, (a0)                                   ; $0040E4
        addq.w       #$4, a0                                       ; $0040E6

loc_0040E8:
        move.b       (a5)+, (a0)                                   ; $0040E8
        addq.w       #$4, a0                                       ; $0040EA

loc_0040EC:
        move.b       (a5)+, (a0)                                   ; $0040EC
        addq.w       #$4, a0                                       ; $0040EE

loc_0040F0:
        move.b       (a5)+, (a0)                                   ; $0040F0
        addq.w       #$4, a0                                       ; $0040F2

loc_0040F4:
        move.b       (a5)+, (a0)                                   ; $0040F4
        addq.w       #$4, a0                                       ; $0040F6

loc_0040F8:
        move.b       (a5)+, (a0)                                   ; $0040F8
        addq.w       #$4, a0                                       ; $0040FA

loc_0040FC:
        move.b       (a5)+, (a0)                                   ; $0040FC
        addq.w       #$4, a0                                       ; $0040FE

loc_004100:
        move.b       (a5)+, (a0)                                   ; $004100
        addq.w       #$4, a0                                       ; $004102

loc_004104:
        move.b       (a5)+, (a0)                                   ; $004104
        addq.w       #$4, a0                                       ; $004106

loc_004108:
        move.b       (a5)+, (a0)                                   ; $004108
        addq.w       #$4, a0                                       ; $00410A

loc_00410C:
        move.b       (a5)+, (a0)                                   ; $00410C
        addq.w       #$4, a0                                       ; $00410E

loc_004110:
        move.b       (a5)+, (a0)                                   ; $004110
        addq.w       #$4, a0                                       ; $004112

loc_004114:
        move.b       (a5)+, (a0)                                   ; $004114
        addq.w       #$4, a0                                       ; $004116

loc_004118:
        move.b       (a5)+, (a0)                                   ; $004118
        addq.w       #$4, a0                                       ; $00411A

loc_00411C:
        move.b       (a5)+, (a0)                                   ; $00411C
        addq.w       #$4, a0                                       ; $00411E

loc_004120:
        move.b       (a5)+, (a0)                                   ; $004120
        addq.w       #$4, a0                                       ; $004122

loc_004124:
        move.b       (a5)+, (a0)                                   ; $004124
        addq.w       #$4, a0                                       ; $004126

loc_004128:
        move.b       (a5)+, (a0)                                   ; $004128
        addq.w       #$4, a0                                       ; $00412A

loc_00412C:
        move.b       (a5)+, (a0)                                   ; $00412C
        addq.w       #$4, a0                                       ; $00412E

loc_004130:
        move.b       (a5)+, (a0)                                   ; $004130
        addq.w       #$4, a0                                       ; $004132

loc_004134:
        move.b       (a5)+, (a0)                                   ; $004134
        addq.w       #$4, a0                                       ; $004136

loc_004138:
        move.b       (a5)+, (a0)                                   ; $004138
        addq.w       #$4, a0                                       ; $00413A

loc_00413C:
        move.b       (a5)+, (a0)                                   ; $00413C
        addq.w       #$4, a0                                       ; $00413E

loc_004140:
        move.b       (a5)+, (a0)                                   ; $004140
        addq.w       #$4, a0                                       ; $004142

loc_004144:
        move.b       (a5)+, (a0)                                   ; $004144
        addq.w       #$4, a0                                       ; $004146

loc_004148:
        move.b       (a5)+, (a0)                                   ; $004148
        addq.w       #$4, a0                                       ; $00414A

loc_00414C:
        move.b       (a5)+, (a0)                                   ; $00414C
        addq.w       #$4, a0                                       ; $00414E

loc_004150:
        move.b       (a5)+, (a0)                                   ; $004150
        addq.w       #$4, a0                                       ; $004152

loc_004154:
        move.b       (a5)+, (a0)                                   ; $004154
        addq.w       #$4, a0                                       ; $004156

loc_004158:
        move.b       (a5)+, (a0)                                   ; $004158
        addq.w       #$4, a0                                       ; $00415A

loc_00415C:
        move.b       (a5)+, (a0)                                   ; $00415C
        addq.w       #$4, a0                                       ; $00415E

loc_004160:
        move.b       (a5)+, (a0)                                   ; $004160
        addq.w       #$4, a0                                       ; $004162

loc_004164:
        move.b       (a5)+, (a0)                                   ; $004164
        addq.w       #$4, a0                                       ; $004166

loc_004168:
        move.b       (a5)+, (a0)                                   ; $004168
        addq.w       #$4, a0                                       ; $00416A

loc_00416C:
        move.b       (a5)+, (a0)                                   ; $00416C
        addq.w       #$4, a0                                       ; $00416E

loc_004170:
        move.b       (a5)+, (a0)                                   ; $004170
        addq.w       #$4, a0                                       ; $004172

loc_004174:
        move.b       (a5)+, (a0)                                   ; $004174
        addq.w       #$4, a0                                       ; $004176

loc_004178:
        move.b       (a5)+, (a0)                                   ; $004178
        addq.w       #$4, a0                                       ; $00417A

loc_00417C:
        move.b       (a5)+, (a0)                                   ; $00417C
        addq.w       #$4, a0                                       ; $00417E

loc_004180:
        move.b       (a5)+, (a0)                                   ; $004180
        addq.w       #$4, a0                                       ; $004182

loc_004184:
        move.b       (a5)+, (a0)                                   ; $004184
        addq.w       #$4, a0                                       ; $004186

loc_004188:
        move.b       (a5)+, (a0)                                   ; $004188
        addq.w       #$4, a0                                       ; $00418A

loc_00418C:
        move.b       (a5)+, (a0)                                   ; $00418C
        addq.w       #$4, a0                                       ; $00418E

loc_004190:
        move.b       (a5)+, (a0)                                   ; $004190
        addq.w       #$4, a0                                       ; $004192

loc_004194:
        move.b       (a5)+, (a0)                                   ; $004194
        addq.w       #$4, a0                                       ; $004196

loc_004198:
        move.b       (a5)+, (a0)                                   ; $004198
        addq.w       #$4, a0                                       ; $00419A

loc_00419C:
        move.b       (a5)+, (a0)                                   ; $00419C
        addq.w       #$4, a0                                       ; $00419E

loc_0041A0:
        move.b       (a5)+, (a0)                                   ; $0041A0
        addq.w       #$4, a0                                       ; $0041A2

loc_0041A4:
        move.b       (a5)+, (a0)                                   ; $0041A4
        addq.w       #$4, a0                                       ; $0041A6

loc_0041A8:
        move.b       (a5)+, (a0)                                   ; $0041A8
        addq.w       #$4, a0                                       ; $0041AA

loc_0041AC:
        move.b       (a5)+, (a0)                                   ; $0041AC
        addq.w       #$4, a0                                       ; $0041AE

loc_0041B0:
        move.b       (a5)+, (a0)                                   ; $0041B0
        addq.w       #$4, a0                                       ; $0041B2

loc_0041B4:
        move.b       (a5)+, (a0)                                   ; $0041B4
        addq.w       #$4, a0                                       ; $0041B6

loc_0041B8:
        move.b       (a5)+, (a0)                                   ; $0041B8
        addq.w       #$4, a0                                       ; $0041BA

loc_0041BC:
        move.b       (a5)+, (a0)                                   ; $0041BC
        addq.w       #$4, a0                                       ; $0041BE

loc_0041C0:
        move.b       (a5)+, (a0)                                   ; $0041C0
        addq.w       #$4, a0                                       ; $0041C2

loc_0041C4:
        move.b       (a5)+, (a0)                                   ; $0041C4
        addq.w       #$4, a0                                       ; $0041C6

loc_0041C8:
        move.b       (a5)+, (a0)                                   ; $0041C8
        addq.w       #$4, a0                                       ; $0041CA

loc_0041CC:
        move.b       (a5)+, (a0)                                   ; $0041CC
        addq.w       #$4, a0                                       ; $0041CE

loc_0041D0:
        rts                                                        ; $0041D0
        ifne *-$41D2
        fail "ROM end moved"
        endif
