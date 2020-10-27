import axi_vip_pkg::*;
import design_1_axi_vip_0_0_pkg::*;

module axi_vip_0_mst_stimulus();

design_1_axi_vip_0_0_mst_t  agent;


  axi_transaction                                          wr_trans;            // Write transaction
  axi_transaction                                          rd_trans;            // Read transaction
  xil_axi_uint                                             mtestWID;            // Write ID  
  xil_axi_ulong                                            mtestWADDR;          // Write ADDR  
  xil_axi_len_t                                            mtestWBurstLength;   // Write Burst Length   
  xil_axi_size_t                                           mtestWDataSize;      // Write SIZE  
  xil_axi_burst_t                                          mtestWBurstType;     // Write Burst Type  
  xil_axi_uint                                             mtestRID;            // Read ID  
  xil_axi_ulong                                            mtestRADDR;          // Read ADDR  
  xil_axi_len_t                                            mtestRBurstLength;   // Read Burst Length   
  xil_axi_size_t                                           mtestRDataSize;      // Read SIZE  
  xil_axi_burst_t                                          mtestRBurstType;     // Read Burst Type  

  xil_axi_data_beat [255:0]                                mtestWUSER;         // Write user  
  xil_axi_data_beat                                        mtestAWUSER;        // Write Awuser 
  xil_axi_data_beat                                        mtestARUSER;        // Read Aruser 

  bit [31:0]                                               mtestWData;         // Write Data
  bit[8*4096-1:0]                                          Rdatablock;        // Read data block
  xil_axi_data_beat                                        Rdatabeat[];       // Read data beats
  bit[8*4096-1:0]                                          Wdatablock;        // Write data block
  xil_axi_data_beat                                        Wdatabeat[];       // Write data beats
  
  
  initial begin
  
  agent = new("master vip agent",DUT.design_1_i.axi_vip_0.inst.IF);
  agent.start_master(); 
  
  
  mtestWID = $urandom_range(0,(1<<(0)-1)); 
  mtestWADDR = 64'h4;
  mtestWBurstLength = 0;
  mtestWDataSize = xil_axi_size_t'(xil_clog2((32)/8));
  mtestWBurstType = XIL_AXI_BURST_TYPE_INCR;
  mtestWData = 32'h55aa55aa;
  
  wr_trans = agent.wr_driver.create_transaction("write transaction");
  wr_trans.set_write_cmd(mtestWADDR,mtestWBurstType,mtestWID,
                               mtestWBurstLength,mtestWDataSize);
  wr_trans.set_data_block(mtestWData);
  agent.wr_driver.send(wr_trans);

  agent.wait_drivers_idle(); 

  mtestRID = $urandom_range(0,(1<<(0)-1)); 
  mtestRADDR = 64'h0;
  mtestRBurstLength = 0;
  mtestRDataSize = xil_axi_size_t'(xil_clog2((32)/8));
  mtestRBurstType = XIL_AXI_BURST_TYPE_INCR;
   
  rd_trans = agent.rd_driver.create_transaction("read transaction");
  rd_trans.set_read_cmd(mtestRADDR,mtestRBurstType,mtestRID,
  mtestRBurstLength,mtestRDataSize);
  agent.rd_driver.send(rd_trans);
  
  agent.wait_drivers_idle(); 
  
  $display("EXAMPLE TEST DONE : Test Completed Successfully");
  $finish;
  end  
endmodule
