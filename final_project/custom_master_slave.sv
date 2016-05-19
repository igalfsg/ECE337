// custom_master_slave module : Acts as an avalon slave to receive input commands from PCIE IP

module custom_master_slave #(
	parameter MASTER_ADDRESSWIDTH = 26 ,  	// ADDRESSWIDTH specifies how many addresses the Master can address 
	parameter SLAVE_ADDRESSWIDTH = 3 ,  	// ADDRESSWIDTH specifies how many addresses the slave needs to be mapped to. log(NUMREGS)
	parameter DATAWIDTH = 32 ,    		// DATAWIDTH specifies the data width. Default 32 bits
	parameter NUMREGS = 8 ,       		// Number of Internal Registers for Custom Logic
	parameter REGWIDTH = 32       		// Data Width for the Internal Registers. Default 32 bits
)	
(	
	input logic  clk,
        input logic  reset_n,
	
	// Interface to Top Level
	input logic rdwr_cntl,//SW[17]
	input logic n_action,					// Trigger the Read or Write. Additional control to avoid continuous transactions. Not a required signal. Can and should be removed for actual application.
	input logic add_data_sel,//SW[16]
	input logic [MASTER_ADDRESSWIDTH-1:0] rdwr_address,//SW[15:0]
	
	
	output logic [DATAWIDTH-1:0] display_data,

	//17 enable
	//16 1=write 0=read
	//15-0 unassigned

	// Bus Slave Interface
        input logic [SLAVE_ADDRESSWIDTH-1:0] slave_address,
        input logic [DATAWIDTH-1:0] slave_writedata,
        input logic  slave_write,
        input logic  slave_read,
        input logic  slave_chipselect,
//      input logic  slave_readdatavalid, 			// These signals are for variable latency reads. 
//	output logic slave_waitrequest,   			// See the Avalon Specifications for details  on how to use them.
        output logic [DATAWIDTH-1:0] slave_readdata,

	// Bus Master Interface
        output logic [MASTER_ADDRESSWIDTH-1:0] master_address,
        output logic [DATAWIDTH-1:0] master_writedata,
        output logic  master_write,
        output logic  master_read,
        input logic [DATAWIDTH-1:0] master_readdata,
        input logic  master_readdatavalid,
        input logic  master_waitrequest
		  
);

noise_toplevel TOP(
	//inputs
	.clk(clk),
	.n_rst(reset_n),
	.red_data({pixel1[23:16],pixel4[23:16],pixel7[23:16],pixel2[23:16],pixel5[23:16],pixel8[23:16],pixel3[23:16],pixel6[23:16],pixel9[23:16]}), //{reg1[7:0],reg2[7:0]....
	.green_data({pixel1[15:8],pixel4[15:8],pixel7[15:8],pixel2[15:8],pixel5[15:8],pixel8[15:8],pixel3[15:8],pixel6[15:8],pixel9[15:8]}),
	.blue_data({pixel1[7:0],pixel4[7:0],pixel7[7:0],pixel2[7:0],pixel5[7:0],pixel8[7:0],pixel3[7:0],pixel6[7:0],pixel9[7:0]}),


	//outputs
	
	.pixel_data(write_data_edge),//data to be outputed check that this reg is big enough 
);

smooth_toplevel TOP3(
	//inputs
	.clk(clk),
	.n_rst(reset_n),
	.red_data({pixel1[23:16],pixel4[23:16],pixel7[23:16],pixel2[23:16],pixel5[23:16],pixel8[23:16],pixel3[23:16],pixel6[23:16],pixel9[23:16]}), //{reg1[7:0],reg2[7:0]....
	.green_data({pixel1[15:8],pixel4[15:8],pixel7[15:8],pixel2[15:8],pixel5[15:8],pixel8[15:8],pixel3[15:8],pixel6[15:8],pixel9[15:8]}),
	.blue_data({pixel1[7:0],pixel4[7:0],pixel7[7:0],pixel2[7:0],pixel5[7:0],pixel8[7:0],pixel3[7:0],pixel6[7:0],pixel9[7:0]}),


	//outputs
	
	.pixel_data(write_data_smooth),//data to be outputed check that this reg is big enough 
);

invert_toplevel TOP2(
	//inputs
	.clk(clk),
	.n_rst(reset_n),
	.red_data(read_data[15:8]),
	.green_data(read_data[23:16]),
	.blue_data(read_data[31:24]),
	.w_count_enable(w_count_enable),
	.w_flag_clear(w_flag_clear),


	//outputs
	.w_image_done(w_image_done),//lets know when the image is done
	.pixel_data(write_data_invert),//data to be outputed check that this reg is big enough 
);


parameter START_BYTE = 32'hF00BF00B;
parameter STOP_BYTE = 32'hDEADF00B;
parameter SDRAM_ADDR = 32'h08000000;
parameter BYTEENABLEWIDTH = 32;

logic [MASTER_ADDRESSWIDTH-1:0] address_r_invert, nextAddress_r_invert;
logic [23:0] write_data_edge;
logic [23:0] write_data_invert;
logic [23:0] write_data_smooth;

logic [MASTER_ADDRESSWIDTH-1:0] top_r_address, next_top_r_address,mid_r_address, next_mid_r_address,bot_r_address, next_bot_r_address;
logic [MASTER_ADDRESSWIDTH-1:0] address_w_edge, nextAddress_w_edge;
logic [MASTER_ADDRESSWIDTH-1:0] address_w_invert, nextAddress_w_invert;

logic [DATAWIDTH-1:0] nextRead_data, read_data;
logic [DATAWIDTH-1:0] nextData, wr_data;
logic [NUMREGS-1:0][REGWIDTH-1:0] csr_registers;  		// Command and Status Registers (CSR) for custom logic 
logic [NUMREGS-1:0] reg_index, nextRegIndex;
logic [NUMREGS-1:0][REGWIDTH-1:0] read_data_registers;  //Store SDRAM read data for display
logic new_data_flag;
logic w_count_enable;
logic w_flag_clear;
logic next_w_flag_clear;
logic next_w_count_enable;
logic [1:0] filter_select;


reg [23:0] pixel1;
reg [23:0] pixel2;
reg [23:0] pixel3;
reg [23:0] pixel4;
reg [23:0] pixel5;
reg [23:0] pixel6;
reg [23:0] pixel7;
reg [23:0] pixel8;
reg [23:0] pixel9;
reg [23:0] pixel10;
reg [23:0] pixel11;
reg [23:0] pixel12;

reg [23:0] pixel1_next;
reg [23:0] pixel2_next;
reg [23:0] pixel3_next;
reg [23:0] pixel4_next;
reg [23:0] pixel5_next;
reg [23:0] pixel6_next;
reg [23:0] pixel7_next;
reg [23:0] pixel8_next;
reg [23:0] pixel9_next;
reg [23:0] pixel10_next;
reg [23:0] pixel11_next;
reg [23:0] pixel12_next;

reg row_end;

reg [31:0] row_end_address;
reg [31:0] next_row_end_address;


typedef enum {IDLE, WRITE, DUMMY,DELAY1, DELAY2, TRAP,READ_REQ, READ_DATA, CALC_INVERT,CHOICE_IDLE,INVERT_IDLE,EDGE_IDLE, ADDR_LOAD,BOT_READ_REQ1,BOT_READ_DATA1,MID_READ_REQ1,MID_READ_DATA1,TOP_READ_REQ1,TOP_READ_DATA1,BOT_READ_REQ2,BOT_READ_DATA2,MID_READ_REQ2,MID_READ_DATA2,TOP_READ_REQ2,TOP_READ_DATA2,BOT_READ_REQ3,BOT_READ_DATA3,MID_READ_REQ3,MID_READ_DATA3,TOP_READ_REQ3,TOP_READ_DATA3,BOT_READ_REQ4,BOT_READ_DATA4,MID_READ_REQ4,MID_READ_DATA4,TOP_READ_REQ4,TOP_READ_DATA4,PIXEL_WRITE,ADDR_INC,ADDR_INC1,ADDR_INC2,ADDR_INC3} state_t;
state_t state, nextState;

assign filter_select = {rdwr_address[14],rdwr_address[13]};

always_comb 
begin
	if (rdwr_cntl) 
	begin
		if (add_data_sel) 
		begin
			if (rdwr_address[15]) 
			begin
				display_data = row_end_address;
			end 
			else 
			begin
				display_data = {8'h00,write_data_edge};
			end
		end 
		else 
		begin
			if (rdwr_address[15]) 
			begin
				if (rdwr_address[14])
					display_data = top_r_address;
				else if (rdwr_address[13])
					display_data = mid_r_address;
				else
					display_data = bot_r_address;
			end 
			else 
			begin
				display_data = address_w_edge;
			end
		end 
	end
	/*else 
	begin
		display_data = 32'h00000000;
		case(state) 
			CHOICE_IDLE : 
			begin 
				display_data = 32'h00000001;
			end
			EDGE_IDLE : 
			begin 
				display_data = 32'h00000002;
			end
			TRAP : 
			begin 
				display_data = 32'h00000003;
			end
			ADDR_INC3 : 
			begin 
				display_data = 32'h00000004;
			end
			DELAY2 :
			begin
				display_data = 32'h00000005;
			end
		endcase
	end*/
	
	else 
	begin
	display_data = 32'hDEADBEEF;
	if (rdwr_address[0] == 1)
		display_data = {8'h00,pixel1};
	else if (rdwr_address[1] == 1)
		display_data = {8'h00,pixel2};
	else if (rdwr_address[2] == 1)
		display_data = {8'h00,pixel3};
	else if (rdwr_address[3] == 1)
		display_data = {8'h00,pixel4};
	else if (rdwr_address[4] == 1)
		display_data = {8'h00,pixel5};
	else if (rdwr_address[5] == 1)
		display_data = {8'h00,pixel6};
	else if (rdwr_address[6] == 1)
		display_data = {8'h00,pixel7};
	else if (rdwr_address[7] == 1)
		display_data = {8'h00,pixel8};
	else if (rdwr_address[8] == 1)
		display_data = {8'h00,pixel9};
	else if (rdwr_address[9] == 1)
		display_data = {8'h00,pixel10};
	else if (rdwr_address[10] == 1)
		display_data = {8'h00,pixel11};
	else if (rdwr_address[11] == 1)
		display_data = {8'h00,pixel12};
	else if (state == TRAP)
		display_data = 32'hB00BD1CC;
	end
end
	/*
	if (rdwr_cntl) 
	begin
		if (add_data_sel) 
		begin
			if (rdwr_address[15]) 
			begin
				display_data = read_data;
			end 
			else 
			begin
				display_data = {8'h00,wr_data};
			end
		end 
		else 
		begin
			if (rdwr_address[15]) 
			begin
				display_data = top_r_address;
			end 
			else 
			begin
				display_data = address_w;
			end
		end 
	end
	else 
	begin
		display_data = 32'hFFFFFFFF;
		case(state) 
			CHOICE_IDLE : 
			begin 
				display_data = 32'h00000000;
			end
			EDGE_IDLE : 
			begin 
				display_data = 32'h00000001;
			end
			TOP_READ_REQ1 : 
			begin 
				display_data = 32'h00000002;
			end
			TOP_READ_DATA1 : 
			begin 
				display_data = 32'h00000003;
			end
			PIXEL_WRITE : 
			begin 
				display_data = 32'h00000004;
			end
			TRAP:
			begin
				display_data = 32'hDEADBEEF;
			end
		endcase
	end*/

//assign display_data = rdwr_cntl ? add_data_sel ? rdwr_address[15] ? read_data : {8'h00,wr_data} : rdwr_address[15] ? address_r : address_w : state == CHOICE_IDLE ? 32'h00000000 : state == INVERT_IDLE ? 32'h00000001 : state == READ_REQ ? 32'h00000002 : state == READ_DATA ? 32'h00000003 : state == CALC_INVERT ? 32'h00000004 : state == WRITE ? 32'h00000005 : 32'h00000006;

// Slave side 
always_ff @ ( posedge clk ) begin 
  if(!reset_n)
  	begin
    		slave_readdata <= 32'h0;
 	      	csr_registers <= '0;
  	end
  else 
  	begin
  	  if(slave_write && slave_chipselect && (slave_address >= 0) && (slave_address < NUMREGS))
  	  	begin
  	  	   csr_registers[slave_address] <= slave_writedata;  // Write a value to a CSR register
  	  	end
  	  else if(slave_read && slave_chipselect  && (slave_address >= 0) && (slave_address < NUMREGS)) // reading a CSR Register
  	    	begin
       		// Send a value being requested by a master. 
       		// If the computation is small you may compute directly and send it out to the master directly from here.
  	    	   slave_readdata <= csr_registers[slave_address];
  	    	end
  	 end
end




// Master Side 

always_ff @ ( posedge clk ) begin 
	if (!reset_n) begin 
		//INVERT
		address_r_invert <= 32'h0812C000;
		address_w_invert <= 32'h08000000;
		
		//EDGE
		row_end_address <= 32'h080013FC;
		top_r_address <= 32'h0812C000;
		mid_r_address <= 32'h0812CA00;
		bot_r_address <= 32'h0812D400;
		address_w_edge <= 32'h08000A04;
		w_flag_clear <= 1;
		w_count_enable <= 0;
		//reg_index <= 0;
		state <= CHOICE_IDLE;
		read_data <= 32'hFEEDFEED;
		pixel1 <= 0;
		pixel2 <= 0;
		pixel3 <= 0;
		pixel4 <= 0;
		pixel5 <= 0;
		pixel6 <= 0;
		pixel7 <= 0;
		pixel8 <= 0;
		pixel9 <= 0;
		pixel10 <= 0;
		pixel11 <= 0;
		pixel12 <= 0;
	end else begin 
		//INVERT
		address_r_invert <= nextAddress_r_invert;
		address_w_invert <= nextAddress_w_invert;
		
		//EDGE
		row_end_address <= next_row_end_address;
		state <= nextState;
		top_r_address <= next_top_r_address;
		mid_r_address <= next_mid_r_address;
		bot_r_address <= next_bot_r_address;
		address_w_edge <= nextAddress_w_edge;
		w_flag_clear <= next_w_flag_clear;
		w_count_enable <= next_w_count_enable;
		//reg_index <= nextRegIndex;
		read_data <= nextRead_data;
		pixel1 <= pixel1_next;
		pixel2 <= pixel2_next;
		pixel3 <= pixel3_next;
		pixel4 <= pixel4_next;
		pixel5 <= pixel5_next;
		pixel6 <= pixel6_next;
		pixel7 <= pixel7_next;
		pixel8 <= pixel8_next;
		pixel9 <= pixel9_next;
		pixel10 <= pixel10_next;
		pixel11 <= pixel11_next;
		pixel12 <= pixel12_next;
	end
end
// Next State Logic 
// If user wants to input data and addresses using a state machine instead of signals/conditions,
// the following code has commented lines for how this could be done.
always_comb begin 
	// Invert
	nextAddress_r_invert = address_r_invert;
	nextAddress_w_invert = address_w_invert;
	nextRead_data = read_data;
	// Edge
	pixel1_next = pixel1;
	pixel2_next = pixel2;
	pixel3_next = pixel3;
	pixel4_next = pixel4;
	pixel5_next = pixel5;
	pixel6_next = pixel6;
	pixel7_next = pixel7;
	pixel8_next = pixel8;
	pixel9_next = pixel9;
	pixel10_next = pixel10;
	pixel11_next = pixel11;
	pixel12_next = pixel12;
	next_row_end_address = row_end_address;
	next_w_flag_clear = 0;
	next_w_count_enable = 0;
	nextState = state;
	next_top_r_address = top_r_address;
	next_mid_r_address = mid_r_address;
	next_bot_r_address = bot_r_address;
	nextAddress_w_edge = address_w_edge;
	nextRegIndex = reg_index;
	//nextData = wr_data;
	nextRead_data = master_readdata;
	//new_data_flag = 0;
	case( state ) 
		TRAP : begin
			nextState = TRAP;
		end
		CHOICE_IDLE : begin
			/*if (n_action == 0)
				nextState = state;
			else begin*/
				next_w_flag_clear = 1;
				if (rdwr_address[12] == 1 || rdwr_address[14] == 1) //&& filter_select == 1)
					nextState = EDGE_IDLE;
				else if (rdwr_address[13] == 1)
					nextState = INVERT_IDLE;
				//if (rdwr_address[12] == 1 && (filter_select == 2 || filter_select == 3))
					//nextState = EDGE_IDLE;
				else 
					nextState = CHOICE_IDLE;
			//end
		end
		INVERT_IDLE : begin 
				if (address_w_invert < 32'h0812BFFC) begin 
					nextState = READ_REQ;
				end else begin 
					nextState = CHOICE_IDLE; 				
				end
			//end
		end 
		WRITE: begin
			/*if (n_action == 0)
				nextState = state;
			else begin*/
				if (!master_waitrequest) begin 
					//nextRegIndex = reg_index + 1;
					nextAddress_w_invert = address_w_invert + 4;
					nextState = INVERT_IDLE;
				end
			//end
		end 
		DUMMY : begin
			nextState = WRITE;
		end
		CALC_INVERT : begin
			/*if (n_action == 0)
				nextState = state;
			else begin*/
			nextState = DUMMY;
			//end
		end
		READ_REQ : begin 
			/*if (n_action == 0)
				nextState = state;
			else begin*/
				if (!master_waitrequest) begin
					nextState = READ_DATA;
					nextAddress_r_invert = address_r_invert + 4;	
					//nextRegIndex = reg_index - 1;
				end
			//end
		end
		READ_DATA : begin
			/*if (n_action == 0)
				nextState = state;
			else begin*/
				if ( master_readdatavalid) begin
					nextRead_data = master_readdata;
					nextState = CALC_INVERT;
				end
			//end
		end
		EDGE_IDLE : begin 
			/*if (n_action == 0)
				nextState = state;
			else begin*/
				if (address_w_edge <= 32'h0812B5F8) begin 
					nextState = BOT_READ_REQ1;				
				end
			//end
		end 
		BOT_READ_REQ1: begin
			//display_data = 32'h00000002;
			if (!master_waitrequest) begin
				nextState = BOT_READ_DATA1;
				
			end
		end
		BOT_READ_DATA1: begin
			//display_data = 32'h00000003;
			if ( master_readdatavalid) begin
				pixel3_next = master_readdata[31:8];
				
				nextState = MID_READ_REQ1;
			end
		end
		MID_READ_REQ1: begin
			if (!master_waitrequest) begin
				//display_data = 32'h00000004;
				nextState = MID_READ_DATA1;
			end
		end
		MID_READ_DATA1: begin
			//display_data = 32'h00000005;
			if ( master_readdatavalid) begin
				pixel2_next = master_readdata[31:8];
			 	
				nextState = TOP_READ_REQ1;
			end
		end
		TOP_READ_REQ1: begin
			//display_data = 32'h00000006;
			if (!master_waitrequest) begin
				nextState = TOP_READ_DATA1;
			 	
			end
		end
		TOP_READ_DATA1: begin
			//display_data = 32'h00000007;
			if ( master_readdatavalid) begin
				pixel1_next = master_readdata[31:8];
				nextState = ADDR_INC1;
			end
		end
		ADDR_INC1: begin
			//display_data = 32'h00000008;
			next_top_r_address = top_r_address + 4;
			next_bot_r_address = bot_r_address + 4;
			next_mid_r_address = mid_r_address + 4;
			nextState = BOT_READ_REQ2;			
			 //debug_flag = 16 ;
		end	
		BOT_READ_REQ2: begin
			//display_data = 32'h00000009;
			if (!master_waitrequest) begin
				nextState = BOT_READ_DATA2;
				//debug_flag = 8 ;
			end
		end
		BOT_READ_DATA2: begin
			//display_data = 32'h0000000A;
			if ( master_readdatavalid) begin
				pixel6_next = master_readdata[31:8];
			
				nextState = MID_READ_REQ2;
			end
		end
		MID_READ_REQ2: begin
			//display_data = 32'h0000000B;
			if (!master_waitrequest) begin
				
				nextState = MID_READ_DATA2;
			end
		end
		MID_READ_DATA2: begin
			//display_data = 32'h0000000C;
			if ( master_readdatavalid) begin
				pixel5_next = master_readdata[31:8];
			 
				nextState = TOP_READ_REQ2;
			end
		end
		TOP_READ_REQ2: begin
			//display_data = 32'h0000000D;
			if (!master_waitrequest) begin
				nextState = TOP_READ_DATA2;
			 	//debug_flag = 12 ;
			end
		end
		TOP_READ_DATA2: begin
			//display_data = 32'h0000000E;
			if ( master_readdatavalid) begin
				pixel4_next = master_readdata[31:8];
				nextState = ADDR_INC2;
			 	//debug_flag = 13 ;
			end
		end
		ADDR_INC2: begin
			//display_data = 32'h0000000F;
			next_top_r_address = top_r_address + 4;
			next_bot_r_address = bot_r_address + 4;
			next_mid_r_address = mid_r_address + 4;
			nextState = BOT_READ_REQ3;			
			 //debug_flag = 16 ;
		end	
		BOT_READ_REQ3: begin
			//display_data = 32'h00000010;
			if (!master_waitrequest) begin
				nextState = BOT_READ_DATA3;
				//debug_flag = 8 ;
			end
		end
		BOT_READ_DATA3: begin
			//display_data = 32'h00000011;
			if ( master_readdatavalid) begin
				pixel9_next = master_readdata[31:8];
				//debug_flag = 9 ;
				nextState = MID_READ_REQ3;
			end
		end
		MID_READ_REQ3: begin
			//display_data = 32'h00000012;
			if (!master_waitrequest) begin
				//debug_flag = 10 ;
				nextState = MID_READ_DATA3;
			end
		end
		MID_READ_DATA3: begin
			//display_data = 32'h00000013;
			if ( master_readdatavalid) begin
				pixel8_next = master_readdata[31:8];
			 	//debug_flag = 11 ;
				nextState = TOP_READ_REQ3;
			end
		end
		TOP_READ_REQ3: begin
			//display_data = 32'h00000014;
			if (!master_waitrequest) begin
				nextState = TOP_READ_DATA3;
			 	//debug_flag = 12 ;
			end
		end
		TOP_READ_DATA3: begin
			//display_data = 32'h00000015;
			if ( master_readdatavalid) begin
				pixel7_next = master_readdata[31:8];
				nextState = ADDR_INC3;
			 	//debug_flag = 13 ;
			end
		end
		ADDR_INC3: begin //here is where the calculation starts
			//display_data = 32'h00000016;
			next_top_r_address = top_r_address + 4;
			next_bot_r_address = bot_r_address + 4;
			next_mid_r_address = mid_r_address + 4;
			nextState = BOT_READ_REQ4;			
			 //debug_flag = 16 ;
		end	
		BOT_READ_REQ4: begin
			//display_data = 32'h00000017;
			if (!master_waitrequest) begin
				nextState = BOT_READ_DATA4;
				//debug_flag = 8 ;
			end
		end
		BOT_READ_DATA4: begin
			//display_data = 32'h00000018;
			if ( master_readdatavalid) begin
				pixel12_next = master_readdata[31:8];
				//debug_flag = 9 ;
				nextState = MID_READ_REQ4;
			end
		end
		MID_READ_REQ4: begin
			//display_data = 32'h00000019;
			if (!master_waitrequest) begin
				//debug_flag = 10 ;
				nextState = MID_READ_DATA4;
			end
		end
		MID_READ_DATA4: begin
			//display_data = 32'h0000001A;
			if ( master_readdatavalid) begin
				pixel11_next = master_readdata[31:8];
			 	//debug_flag = 11 ;
				nextState = TOP_READ_REQ4;
			end
		end
		TOP_READ_REQ4: begin
			//display_data = 32'h0000001B;
			if (!master_waitrequest) begin
				nextState = TOP_READ_DATA4;
			 	//debug_flag = 12 ;
			end
		end
		TOP_READ_DATA4: begin
			//display_data = 32'h0000001C;
			if ( master_readdatavalid) begin
				pixel10_next = master_readdata[31:8];
				nextState = DELAY1;
			 	//debug_flag = 13 ;
			end
		end
		PIXEL_WRITE: begin
			if (!master_waitrequest) begin 
				//nextRegIndex = reg_index + 1;
				//nextAddress_w = address_w + 4;
				nextState = ADDR_INC;
			end			
		end
		DELAY1: begin
				nextState = DELAY2;
				
		end
		DELAY2: begin
		//if (!master_waitrequest) begin 
				//nextRegIndex = reg_index + 1;
				//nextAddress_w = address_w + 4;
				nextState = PIXEL_WRITE;
					
		end
		// Increment all read and write addresses to get ready for the next round of pixel computation
		ADDR_INC: begin
			//nextState = ADDR_INC;
			//display_data = 32'h0000001E;
			nextAddress_w_edge =  address_w_edge + 4;
			next_top_r_address = top_r_address + 4;
			next_bot_r_address = bot_r_address + 4;
			next_mid_r_address = mid_r_address + 4;
			pixel1_next = pixel4;
			pixel2_next = pixel5;
			pixel3_next = pixel6;
			pixel4_next = pixel7;
			pixel5_next = pixel8;
			pixel6_next = pixel9;
			pixel7_next = pixel10;
			pixel8_next = pixel11;
			pixel9_next = pixel12;
	
			
			if (address_w_edge >= 32'h0812B5F8)
				nextState = TRAP;
			else begin
				if (address_w_edge == (row_end_address - 4)) 
				begin
					next_row_end_address = row_end_address + 32'h00000A00;
					nextAddress_w_edge = address_w_edge + 12;
					nextState = BOT_READ_REQ1;
					next_top_r_address = top_r_address;// - 4;
					next_mid_r_address = mid_r_address;// - 4;
					next_bot_r_address = bot_r_address;// - 4;
				end 
				else		
					nextState = BOT_READ_REQ4;	
			end		
			 //debug_flag = 16 ;
		end
	endcase
end

// Output Logic 

always_comb begin 
	master_write = 1'b0;
	master_read = 1'b0;
	master_writedata = 32'h0;
	master_address = {24'h080000,rdwr_address[7],rdwr_address[6],rdwr_address[5],rdwr_address[4],rdwr_address[3],rdwr_address[2],rdwr_address[1],rdwr_address[0]};//master_address = 32'hbad1bad1;
	case(state) 
		WRITE : begin 
			master_write = 1;
			master_address =  address_w_invert;
			master_writedata = {8'h00,write_data_invert};/*{8'h00,rdwr_address[2],rdwr_address[2],rdwr_address[2],rdwr_address[2],
			rdwr_address[2],rdwr_address[2],rdwr_address[2],rdwr_address[2],
			rdwr_address[1],rdwr_address[1],rdwr_address[1],rdwr_address[1],
			rdwr_address[1],rdwr_address[1],rdwr_address[1],rdwr_address[1],
			rdwr_address[0],rdwr_address[0],rdwr_address[0],rdwr_address[0],
			rdwr_address[0],rdwr_address[0],rdwr_address[0],rdwr_address[0]};*/
		end 
		READ_REQ : begin 
			master_address = address_r_invert;
			master_read = 1;	
		end
		PIXEL_WRITE : begin 
			master_write = 1;
			master_address =  address_w_edge;
			if (rdwr_address[12] == 1)
				master_writedata = {8'h00,write_data_edge};
			else
				master_writedata = {8'h00,write_data_smooth};
				/*{8'h00,rdwr_address[2],rdwr_address[2],rdwr_address[2],rdwr_address[2],
			rdwr_address[2],rdwr_address[2],rdwr_address[2],rdwr_address[2],
			rdwr_address[1],rdwr_address[1],rdwr_address[1],rdwr_address[1],
			rdwr_address[1],rdwr_address[1],rdwr_address[1],rdwr_address[1],
			rdwr_address[0],rdwr_address[0],rdwr_address[0],rdwr_address[0],
			rdwr_address[0],rdwr_address[0],rdwr_address[0],rdwr_address[0]};*/
		end 
		BOT_READ_REQ1 : begin 
			master_address = bot_r_address;
			master_read = 1;	
		end
		BOT_READ_REQ2 : begin 
			master_address = bot_r_address;
			master_read = 1;	
		end
		BOT_READ_REQ3 : begin 
			master_address = bot_r_address;
			master_read = 1;	
		end
		BOT_READ_REQ4 : begin 
			master_address = bot_r_address;
			master_read = 1;	
		end
		MID_READ_REQ1 : begin
			master_address = mid_r_address;
			master_read = 1;	
		end
		MID_READ_REQ2 : begin
			master_address = mid_r_address;
			master_read = 1;	
		end
		MID_READ_REQ3 : begin
			master_address = mid_r_address;
			master_read = 1;	
		end
		MID_READ_REQ4 : begin
			master_address = mid_r_address;
			master_read = 1;	
		end
		TOP_READ_REQ1 : begin
			master_address = top_r_address;
			master_read = 1;	
		end
		TOP_READ_REQ2 : begin
			master_address = top_r_address;
			master_read = 1;	
		end
		TOP_READ_REQ3 : begin
			master_address = top_r_address;
			master_read = 1;	
		end
		TOP_READ_REQ4 : begin
			master_address = top_r_address;
			master_read = 1;	
		end
	endcase
end

endmodule
