`timescale 1ns / 1ps
module Tx#(
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate
    )
    (
    input clk,
    input [7:0] data_in,
    input send,
    output busy,
    output reg data_out,
    output done
    );
    localparam IDLE      = 3'b000;
    localparam TX_START  = 3'b001;
    localparam TX_DATA   = 3'b010;
    localparam TX_STOP   = 3'b011;
    localparam RESTART   = 3'b100;
    
    reg [12:0] clock_counter = 0;
    reg [2:0] bit_index      = 0;
    reg [7:0] data_in_reg    = 0;
    reg done_reg             = 0;
    reg busy_reg             = 0;
    reg [2:0] state          = 0;
	 
	 //debouncer (.clk(clk), .in(send_btn), .out(send));
    
    always @(posedge clk)begin
        case(state)
            IDLE : begin
                data_out      <= 1'b1;
                done_reg      <= 0;
                clock_counter <= 0;
                bit_index     <= 0;
                
                if (send == 1'b1) begin
                    busy_reg    <= 1;
                    data_in_reg <= data_in;
                    state       <= TX_START;
                end
                else state <= IDLE;
            end    
            TX_START: begin
                data_out <= 1'b0;
                if(clock_counter < tick_per_bit-1) begin
                    clock_counter <= clock_counter + 1;
                    state         <= TX_START;
                end
                else begin
                    clock_counter <= 0;
                    state         <= TX_DATA;
                end
            end    
            TX_DATA : begin
                data_out <= data_in_reg[bit_index];
                if(clock_counter < tick_per_bit-1) begin
                    clock_counter <= clock_counter + 1;
                    state         <= TX_DATA;
                end
                else begin
                    clock_counter <= 0;
                    if(bit_index < 7)begin
                        bit_index <= bit_index + 1;
                        state     <= TX_DATA;
                    end
                    else begin
                        bit_index <= 0;
                        state <= TX_STOP;
                    end
                end
            end
            TX_STOP : begin
                data_out <= 1;
                if(clock_counter < tick_per_bit-1) begin
                    clock_counter <= clock_counter + 1;
                    state         <= TX_STOP;
                end   
                else begin
                    done_reg      <= 1;
                    clock_counter <= 0;
                    state         <= RESTART;
                    busy_reg      <= 0;
                end             
            end
            RESTART : begin
                done_reg <= 1;
                state    <= IDLE;
            end
            default : state <= IDLE;   
        endcase
    end
    
    assign busy = busy_reg;
    assign done = done_reg;

endmodule