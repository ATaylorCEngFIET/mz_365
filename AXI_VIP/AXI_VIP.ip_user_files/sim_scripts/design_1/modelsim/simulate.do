onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xilinx_vip -L xpm -L axi_bram_ctrl_v4_1_3 -L xil_defaultlib -L blk_mem_gen_v8_4_4 -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_7 -L sim_clk_gen_v1_0_2 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.design_1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {design_1.udo}

run -all

quit -force
