module adder_subtractor_8bit (
    input  [7:0] A,       
    input  [7:0] B,       
    input        switch, 
    output [7:0] Result,  
    output       Cout     
);

    wire [7:0] B_mux;
    assign B_mux = B ^ {8{switch}};
    assign {Cout, Result} = A + B_mux + switch;

endmodule
