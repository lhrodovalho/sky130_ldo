* LDO testbench

* Include SkyWater sky130 device models
.lib "~/GitHub/skywater-pdk/libraries/sky130_fd_pr/latest/models/sky130.lib.spice" tt
*.include "setup.sp"
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
