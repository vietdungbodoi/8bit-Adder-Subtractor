`timescale 1ns/1ps // Đơn vị thời gian mô phỏng là nanosecond (ns)

module tb_adder_subtractor_8bit;

    // 1. Khai báo các biến đầu vào (reg) và đầu ra (wire) để nối với chip
    reg [7:0] A;
    reg [7:0] B;
    reg       switch;
    wire [7:0] Result;
    wire       Cout;

    // 2. Gọi con chip 8-bit vào trong môi trường test (gọi là UUT - Unit Under Test)
    adder_subtractor_8bit uut (
        .A(A), 
        .B(B), 
        .switch(switch), 
        .Result(Result), 
        .Cout(Cout)
    );

    // 3. Quá trình bơm dữ liệu test
    initial begin
        // Lệnh để Logisim/Icarus Verilog ghi lại dạng sóng vào file .vcd
        $dumpfile("simulation.vcd");
        $dumpvars(0, tb_adder_subtractor_8bit);

        // --- Test Case 1: Phép cộng (11 + 1) ---
        A = 8'd11;      // Gán A = 11 (hệ thập phân)
        B = 8'd1;       // Gán B = 1
        switch = 1'b0;  // switch = 0 (Lệnh Cộng)
        #10;            // Chờ 10ns xem chip tính ra cái gì

        // --- Test Case 2: Phép trừ (11 - 1) ---
        A = 8'd11; 
        B = 8'd1; 
        switch = 1'b1;  // switch = 1 (Lệnh Trừ)
        #10;            // Chờ 10ns

        // --- Test Case 3: Thử một số ngẫu nhiên (50 + 25) ---
        A = 8'd50; 
        B = 8'd25; 
        switch = 1'b0; 
        #10;

        // Kết thúc mô phỏng
        $display("Simulation finished successfully!");
        $finish;
    end

endmodule