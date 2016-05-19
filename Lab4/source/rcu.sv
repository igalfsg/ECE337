// $Id: $
// File name:   rcu.sv
// Created:     2/9/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: ruc stuff
module rcu 
(
	input wire clk,
	input wire n_rst,
	input wire start_bit_detected,
	input wire packet_done,
	input wire framing_error,
	output reg sbc_clear,
	output reg sbc_enable,
	output reg load_buffer,
	output reg enable_timer
);

    

	typedef enum logic [2:0] {IDLE, START_BIT, PACKET_BIT, STOP_BIT, CHECK_FRAMING_ERR, STORE_DATA} state_type;

    state_type curr_state, nxt_state;


    always_ff @ (posedge clk, negedge n_rst)
    begin

    	if(n_rst == 0) 
        begin 

            curr_state <= IDLE;

        end

        else
        begin

            curr_state <= nxt_state;

        end
    end


    always_comb
    begin

        nxt_state = curr_state;

        case(curr_state) 

            IDLE: 
            begin

                if(start_bit_detected == 1)
                begin

                    nxt_state = START_BIT;
                
		end

                else
                begin

                    nxt_state = IDLE;

                end
            end

            START_BIT: 
            begin

                nxt_state = PACKET_BIT;

            end

            PACKET_BIT: 
            begin

                if(packet_done == 1)
                begin

                    nxt_state = STOP_BIT;

                end

                else
                begin

                    nxt_state = PACKET_BIT;

                end
            end

            STOP_BIT: 
            begin

                nxt_state = CHECK_FRAMING_ERR;

            end

            CHECK_FRAMING_ERR: 
            begin

                if(framing_error == 1)
                begin

                    nxt_state = IDLE;

                end

                else
                begin

                    nxt_state = STORE_DATA;

                end

            end

            STORE_DATA: 
            begin

                nxt_state = IDLE;

            end

            default
            begin

                nxt_state = IDLE;

            end





        endcase


    end

    assign enable_timer = (curr_state == PACKET_BIT);
    assign load_buffer = (curr_state == STORE_DATA);
    assign sbc_clear = (curr_state == START_BIT);
    assign sbc_enable = (curr_state == STOP_BIT);
    
endmodule 