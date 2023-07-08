`timescale 1ns / 1ps

module uart_wrapper_tb    #
   (parameter data_width = 8,
    parameter fifo_depth = 8,
    parameter countersize = $clog2(fifo_depth+1),
    parameter clk_freq = 50000000,
    parameter baudrate = 9600,
    parameter tick_per_bit = clk_freq / baudrate)
    (

    );    
    
    reg clk=0;
    reg rst=1;
    reg rx_in=0;
    wire tx_out;
    wire [countersize-1:0]memocount;
    wire [data_width-1:0] data_out;
    reg read=0;
    reg write=0;
    
    uart_wrapper    #
   (.data_width(data_width),
    .fifo_depth(fifo_depth),
    .countersize(countersize),
    .clk_freq(clk_freq),
    .baudrate(baudrate),
    .tick_per_bit(tick_per_bit))
    dut(
    .clk(clk), .rst(rst)               ,
    .rx_in(rx_in)                     ,
    .tx_out(tx_out)                         ,
    .memocount(memocount)      ,
    .data_out(data_out)         ,
    .read(read), .write(write)
    );
    always begin
     clk <= ~clk;
     #2;
    end
    always   begin #($urandom()%10) rx_in <= ~rx_in;  end      
//    always begin #($urandom()%10) write <= ~write; end
//    always begin #($urandom()%10) read <= ~read; end
    initial begin
       #10 rst = 0;
       #150000 write <= 1;
       #150000 write <= ~write;
       
       #150000 write <= 1;
       #150000 write <= ~write;
       
       #150000 write <= 1;
       #150000 write <= ~write;
       #150000 write <= 1;
       #150000 write <= ~write;
       
       #150000 write <= 1;
       #150000 write <= ~write;
       #150000 write <= 1;
       #150000 write <= ~write;
       
       #150000 write <= 1;
       #150000 write <= ~write;
       #150000 write <= 1;
       #150000 write <= ~write;
       #150000 write <= 1;
       #150000 write <= ~write;
       
       #150000 read <= 1;
       #150000 read <= ~read;
       #150000 read <= 1;
       #150000 read <= ~read;
       #150000 read <= 1;
       #150000 read <= ~read;
       #150000 read <= 1;
       #150000 read <= ~read;
       #150000 read <= 1;
       #150000 read <= ~read;
       
       
    end
endmodule
