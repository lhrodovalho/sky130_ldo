* LDO testbench

* Include SkyWater sky130 device models
.lib "/usr/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.param mc_mm_switch=0
.include "ldo.sp"

.param pvdd = 3.3
.param pRL  = 1G
.param pCL  = 0
.param pIL  = 1m

VDDHI vddhi 0 {pvdd} ac 1
VSS   vss   0 0.0
IL vddlo 0 0 PULSE(0 {pIL} 0 5n 5n 10u 100u)

* DUT
X0 vddhi vddlo vss ldo
RL vddlo vss {pRL}
CL vddlo vss {pCL}

*.option gmin=1e-21
.control

    tran 0.01u 20u
    plot vddlo
    
.endc

.end
