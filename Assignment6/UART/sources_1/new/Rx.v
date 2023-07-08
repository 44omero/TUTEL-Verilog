`timescale 1ns / 1ps

module Rx#(
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate
    )
    (
    input clk,
    input data_in,
    output [7:0]data_out,
    output done
    );
    localparam IDLE = 3'b000;
    localparam RX_START  = 3'b001;
    localparam RX_DATA   = 3'b010;
    localparam RX_STOP   = 3'b011;
    localparam RESTART   = 3'b100;

    reg data_buffer = 1'b1;
    reg tempData    = 1'b1;
    
    reg [12:0] clock_counter = 0;
    reg [2:0] bit_index     = 0;
    reg [7:0] data_out_reg  = 0;
    reg done_reg            = 0;
    reg [2:0] state         = 0;

    always @(posedge clk)begin
        data_buffer <= data_in;
        tempData    <= data_buffer;
    end
    
    always @(posedge clk)begin
        case(state)
            IDLE : begin
                
                done_reg      <= 0;
                clock_counter <= 0;
                bit_index     <= 0;
                
                if (tempData == 1'b0) //start_bit "0"
                    state <= RX_START;
                else
                    state <= IDLE;
            end
            RX_START : begin
                
                if(clock_counter == (tick_per_bit-1)/2)begin
                    if(tempData == 1'b0)begin
                        clock_counter <= 0;
                        state         <= RX_DATA;
                    end
                    else state <= IDLE;
                end
                else begin
                    clock_counter <= clock_counter + 1;
                    state         <= RX_START;
                end
            end
            RX_DATA : begin
                
                if (clock_counter < tick_per_bit-1)begin
                    clock_counter <= clock_counter + 1;
                    state         <= RX_DATA;
                end
                else begin
                    clock_counter <= 0;
                    data_out_reg[bit_index] <= tempData;
                    
                    if(bit_index < 7) begin
                        bit_index <= bit_index + 1;
                        state     <= RX_DATA;
                    end
                    else begin
                        bit_index <= 0;
                        state     <= RX_STOP;
                    end
                end
            end
            RX_STOP : begin
                
                if(clock_counter < tick_per_bit-1)begin
                    clock_counter <= clock_counter + 1;
                    state         <= RX_STOP;
                end
                else begin
                    done_reg      <= 1'b1;
                    clock_counter <= 0;
                    state         <= RESTART;
                end
            end
            RESTART : begin
                
                state    <= IDLE;
                done_reg <= 1'b0;
            end
            default : state <= IDLE;
        endcase
    end
assign done     = done_reg;
assign data_out = data_out_reg;

endmodule
