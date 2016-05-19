transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/seg_hex.v}
vlib amm_master_qsys_with_pcie
vmap amm_master_qsys_with_pcie amm_master_qsys_with_pcie
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/amm_master_qsys_with_pcie.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_avalon_st_adapter_002.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_up_avalon_video_vga_timing.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_video_vga_controller_0.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_video_rgb_resampler_0.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_video_pixel_buffer_dma_0.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_video_dual_clock_buffer_0.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_sgdma.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_sdram.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_pcie_ip.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpcie_pipe_interface.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpcie_pcie_reconfig_bridge.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_pcie_hard_ip_reset_controller.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpcie_rs_serdes.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_pcie_ip_altgx_internal.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpcie_hip_pipen1b_qsys.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_a2p_addrtrans.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_a2p_fixtrans.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_app.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_control_register.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_cfg_status.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_cr_avalon.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_cr_interrupt.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_cr_mailbox.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_p2a_addrtrans.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_rx.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_rx_cntrl.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_rx_resp.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_tx.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_tx_cntrl.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_txavl_cntrl.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_stif_txresp_cntrl.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altpciexpav_clksync.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_altpll_qsys.v}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/master_example.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_irq_mapper.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_address_alignment.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_rsp_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_rsp_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_cmd_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_cmd_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_burst_adapter_13_1.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_traffic_limiter.sv}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_router_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_2_router.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_rsp_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_rsp_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_cmd_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_cmd_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_router_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_1_router.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_avalon_st_adapter_002_error_adapter_0.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_mux_004.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_mux_002.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_demux_003.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_demux_002.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_demux_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_mux_002.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_mux_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_demux_004.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_demux_003.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_demux_002.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_009.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_008.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_007.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_006.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_004.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_002.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router_001.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/amm_master_qsys_with_pcie_mm_interconnect_0_router.sv}
vlog -sv -work amm_master_qsys_with_pcie +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/amm_master_qsys_with_pcie/synthesis/submodules/custom_master_slave.sv}

vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/tb_icb.sv}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/icb.sv}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/icb_calculator.sv}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/icb_column.sv}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/icb_controller.sv}
vlog -sv -work work +incdir+C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom\ Files {C:/Users/lucas/Documents/FPGA/de2i150/demo_master_slave/Custom Files/icb_multiplier.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -L amm_master_qsys_with_pcie -voptargs="+acc"  icb

add wave *
view structure
view signals
run -all