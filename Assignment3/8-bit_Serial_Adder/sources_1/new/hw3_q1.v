`timescale 1ns / 1ps

module hw3_q1(
    input [7:0] A,
    input [7:0] B,
    input clk, rstn, start,
    output reg Cout, load, enable,
    output reg [8:0] sum
    );
    reg [3:0] counter;
    wire w1, w2, temp_Cout, Cin, sumadder;
    
    shift_register sr1(.clk(clk), .enable(enable), .rst(rstn), .load(load), .sr_in(A), .sr_out(w1));
    shift_register sr2(.clk(clk), .enable(enable), .rst(rstn), .load(load), .sr_in(B), .sr_out(w2));
    full_adder add(.A(w1), .B(w2), .Cin(Cin), .Sum(sumadder), .Cout(temp_Cout));
    d_flipflop dff(.D(temp_Cout), .clk(clk), .rst(rstn), .Q(Cin));   
always @(posedge clk or posedge rstn)begin
    if(rstn)begin
        load <= 1;
        sum <= 0;
        counter <= 0;
    end
    else begin
        if (start == 1) begin load <=0; enable <= 1; end
        if(counter > 4'b1001)begin
            enable <= 0;
        end
        else if (enable)begin
            Cout <= temp_Cout;
            counter <= counter + 1;
            sum <= sum >> 1;
            sum [8] <= sumadder;
        end
    end
end    
endmodule
