* LDO testbench

* Include SkyWater sky130 device models
.lib "/usr/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.param mc_mm_switch=0
.include "ldo.sp"

.param pvdd = 3.3
.param pRL  = 1Meg

VDDHI vddhi 0 {pvdd} ac 1 PULSE(1m {pvdd} 10u 1u 1u 100m 100m)
VSS   vss   0 0.0

* DUT
X0 vddhi vddlo vss ldo
RL vddlo vss {pRL}

.option gmin=1e-15
.control

    dc temp -55 125 1
    plot vddlo
    plot x0.ref

    dc VDDHI 1m 5.0 1m
    plot vddhi vddlo x0.ref x0.x

    op
    ac dec 100 1 1G
    plot vdb(vddlo)

    tran 1n 20u
    plot vddhi vddlo
    plot x0.x0.km x0.x0.z x0.ref
    
.endc

.end
