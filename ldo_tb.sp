* LDO testbench

* Include SkyWater sky130 device models
.lib "~/GitHub/skywater-pdk/libraries/sky130_fd_pr/latest/models/sky130.lib.spice" tt
*.include "setup.sp"
.include "ldo.sp"

.param pvdd = 3.3
.param pRL  = 1k

VDDHI vddhi 0 {pvdd} ac 1 PULSE(0 {pvdd} 1m 1u 1m 100m 100m)
VSS   vss   0 0.0

* DUT
X0 vddhi vddlo vss ldo
RL vddlo vss {pRL}

.option gmin=1e-21
.control

    dc temp -55 125 1
    plot vddlo
    plot x0.ref

    dc VDDHI 0 3.3 0.001
    plot vddhi vddlo x0.ref x0.x

    ac dec 100 1 1G
    plot 20*log10(vddlo)

    tran 0.01m 10m
    plot vddhi vddlo
    
.endc

.end
