	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"mainTB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Please add other modules here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/floatAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/floatMultiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/isZero.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/neuralNetwork.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/pu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg32Activation.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg32B.v

		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/mainTB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/nn/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	