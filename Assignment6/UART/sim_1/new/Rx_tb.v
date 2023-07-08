`timescale 1ns / 1ps


module Rx_tb#(
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate
    );
    reg clk = 0;
    reg data_in=0;
    wire [7:0]data_out;
    wire done;

Rx dut (.clk(clk), .data_in(data_in), .data_out(data_out), .done(done));
always begin                                      
    #(2)                                           
    clk = ~clk;                         
end                                               

always   begin #($urandom()%10) data_in <= ~data_in;  end                                                
initial begin                                     

//data_in = 1'b0;
//#100 
//data_in = 1'b1;   
//#100
//data_in = 1'b1;
//#100 
//data_in = 1'b1;
//#100 
//data_in = 1'b1;
//#100
//data_in = 1'b0;
//#100
//data_in = 1'b0;
//#100
//data_in = 1'b0;
//#100
//data_in = 1'b1; 
//#100
//data_in = 1'b1;                      
//#100
                                             
                                         
                                                                                     
#100                                              
$finish;                                                                                        
                                                  
                                                  
end                                               
endmodule  
