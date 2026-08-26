`timescale 1ns/1ps 

module tb_adder_subtractor_8bit;


    reg [7:0] A;
    reg [7:0] B;
    reg       switch;
    wire [7:0] Result;
    wire       Cout;

    adder_subtractor_8bit uut (
        .A(A), 
        .B(B), 
        .switch(switch), 
        .Result(Result), 
        .Cout(Cout)
    );

    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, tb_adder_subtractor_8bit);

        A = 8'd11;      
        B = 8'd1;       
        switch = 1'b0;  
        #10;            

        A = 8'd11; 
        B = 8'd1; 
        switch = 1'b1;  
        #10;            
        A = 8'd50; 
        B = 8'd25; 
        switch = 1'b0; 
        #10;

        $display("Simulation finished successfully!");
        $finish;
    end

endmodule
