module adder_subtractor_8bit (
    input  [7:0] A,       // Bus đầu vào A (8-bit)
    input  [7:0] B,       // Bus đầu vào B (8-bit)
    input        switch,  // Chân điều khiển: 0 = Cộng, 1 = Trừ
    output [7:0] Result,  // Bus kết quả đầu ra (8-bit)
    output       Cout     // Chân báo dư (Carry Out) của Bit 7
);

    wire [7:0] B_mux;

    // Phép toán XOR điều khiển: Nếu switch = 1 thì đảo bit của B, nếu switch = 0 giữ nguyên
    // {8{switch}} có nghĩa là lặp lại bit switch 8 lần để tạo thành một chuỗi 8-bit
    assign B_mux = B ^ {8{switch}};

    // Thực hiện phép cộng tổng: A + B_mux + switch
    // Dấu {Cout, Result} dùng để gộp chân Cout (1-bit) và Result (8-bit) thành một kết quả 9-bit
    assign {Cout, Result} = A + B_mux + switch;

endmodule