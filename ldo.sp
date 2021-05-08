* Low Dropout voltage regulator
.subckt ldo vddhi vddlo vss

    x0 ref gp vddhi vss bandgap

    X1 ref y x  gp vddhi vss amp
    R1 vddlo y   35k
    R2 y     vss 55k
    CM vddlo x 10p

    X2 vddlo x vddhi vddhi sky130_fd_pr__pfet_g5v0d10v5  w=3.0 l=0.5 m=16

.ends

* PMOS input symmetrical OTA
.subckt amp inm inp out gp vdd vss 

    X1AS d1a gp  vdd vdd p5v1_4 
    X1AD x   gp  d1a vdd p5v4_1
    X1BS d1b gp  vdd vdd p5v1_4
    X1BD x   gp  d1b vdd p5v4_1
    X1CS d1c z   vdd vdd p5v1_4
    X1CD z   z   d1c vdd p5v4_1
    X1DS d1d z   vdd vdd p5v1_4
    X1DD out z   d1d vdd p5v4_1

    X2A  yp  inp x   vdd p5v4_1
    X2B  ym  inm x   vdd p5v4_1

    X3AD yp  yp  d3a vss n5v4_1
    X3AS d3a yp  vss vss n5v1_4
    X3BD ym  ym  d3b vss n5v4_1
    X3BS d3b ym  vss vss n5v1_4
    X3CD out yp  d3c vss n5v4_1
    X3CS d3c yp  vss vss n5v1_4
    X3DD z   ym  d3d vss n5v4_1
    X3DS d3d ym  vss vss n5v1_4

.ends

* Bandgap voltage reference
.subckt bandgap ref gp vdd vss 

    X1 0 0 kp 0 sky130_fd_pr__pnp_05v5_W0p68L0p68 M=1
    X2 0 0 j  0 sky130_fd_pr__pnp_05v5_W0p68L0p68 M=8
    R1 j  km  5.2k
    R2 km ref 23k
    X1AS d1a gp vdd vdd p5v1_4
    X1AD kp  gp d1a vdd p5v4_1
    X1BS d1b gp vdd vdd p5v1_4
    X1BD ref gp d1b vdd p5v4_1

    X0 kp km gp gp vdd vss amp

.ends

*********************
* Transistor Arrays *
*********************

.subckt n5v1_2 d g s b
XD d g x b sky130_fd_pr__nfet_g5v0d10v5  w=1.0 l=0.5 m=1
XS x g s b sky130_fd_pr__nfet_g5v0d10v5  w=1.0 l=0.5 m=1
.ends

.subckt n5v1_4 d g s b
XD d g x b n5v1_2 
XS x g s b n5v1_2
.ends

.subckt n5v4_1 d g s b
X0 d g s b sky130_fd_pr__nfet_g5v0d10v5  w=1.0 l=0.5 m=4
.ends

.subckt p5v1_2 d g s b
XD d g x b sky130_fd_pr__pfet_g5v0d10v5  w=3.0 l=0.5 m=1
XS x g s b sky130_fd_pr__pfet_g5v0d10v5  w=3.0 l=0.5 m=1
.ends

.subckt p5v1_4 d g s b
XD d g x b p5v1_2 
XS x g s b p5v1_2
.ends

.subckt p5v4_1 d g s b
X0 d g s b sky130_fd_pr__pfet_g5v0d10v5  w=3.0 l=0.5 m=4
.ends

