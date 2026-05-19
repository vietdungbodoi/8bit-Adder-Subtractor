# 8-Bit Optimized Ripple Carry Adder-Subtractor

A highly optimized 8-bit Hardware Adder-Subtractor unit implemented in both **Logisim (Gate-Level Design)** and **Verilog HDL (RTL Implementation)**. This project demonstrates the transition from fundamental digital logic to functional hardware description and simulation.

## 🚀 Hardware Optimization Highlight
Instead of using a naive parallel architecture (1 dedicated Adder + 1 dedicated Subtractor + 1 Multiplexer), this design **merges both operations into a single execution path** using Bitwise XOR gates for 2's complement control.

* **Resource Saving:** Reduced the number of required Full Adders by **50%** (8 Full Adders instead of 16).
* **Silicon Footprint:** Significant reduction in gate count and routing complexity by eliminating the output 8-bit Multiplexer.

---

## 🛠️ Hardware Architecture & Logic

The core logic relies on the properties of the XOR gate to dynamically control the input $B$ based on the operation mode (`switch`).

### Mathematical Formulation
* **Control Input (`switch` / `ctrl`):**
  * `0`: Addition Mode ($Sum = A + B + 0$)
  * `1`: Subtraction Mode ($Sum = A + \sim B + 1 = A - B$)

* **Hardware Mapping:**

  $$B_{mux} = B \oplus \{8\{switch\}\}$$
  
  $$\{C_{out}, Result\} = A + B_{mux} + switch$$

### 1. Gate-Level Design (Logisim)
The architecture is built from a custom universal 1-bit cell (`Adder_Subtractor_1bit`) cascaded in a Ripple Carry chain.

* **Bit 0 (LSB):** Takes the global `switch` signal into both its XOR control and its $C_{in}$ port to complete the $+1$ requirement for 2's complement subtraction.
* **Bits 1-7:** Cascade the $C_{out}$ of the previous stage into the next stage's $C_{in}$.

*(Place your Logisim schematic screenshot here)*
`![Logisim Schematic](doc/schematic.png)`

### 2. RTL Implementation (Verilog HDL)
The hardware behavior is described in structural/dataflow Verilog:

```verilog
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
```
## 🔬 Simulation & Waveform Analysis
The design was verified using an automated testbench with Icarus Verilog and visualized using WaveTrace.
 ### Waveform breakdown
The simulation executes three distinct verification phases (Test case) :
 1. $0\text{ ns} \rightarrow 10\text{ ns}$ (Addition Test):
    
    Inputs: A = 0B (11), B = 01 (1), switch = 0
    
    Hardware: $B_{mux} = 01$
    
    Output: Result = 0C (12), Cout = 0
 3. $10\text{ ns} \rightarrow 20\text{ ns}$ (Subtraction Test):
    
    Inputs: A = 0B (11), B = 01 (1), switch = 1
    
    Hardware: $B_{mux} = \text{FE}$ (inverted bits)Internal Math: $11 + 254 + 1 = 266$
    
    Output: Result = 0A (10), Cout = 1 (Overflow bit represents valid 2's complement subtraction carry).
 5. $20\text{ ns} \rightarrow 30\text{ ns}$ (Alternative Addition Test):
    
    Inputs: A = 32 (50), B = 19 (25), switch = 0
    
    Output: Result = 4B (75), Cout = 0

    ![Waveform Analysis](doc/simulation_waveform.png)


## 💻 How to Run the Simulation
Ensure you have Icarus Verilog installed and added to your system PATH.

### 1. Clone the repository
git clone [https://github.com/yourusername/8bit-Hardware-Adder-Subtractor.git](https://github.com/yourusername/8bit-Hardware-Adder-Subtractor.git)
cd 8bit-Hardware-Adder-Subtractor

### 2. Compile Design and Testbench
iverilog -g2012 -s tb_adder_subtractor_8bit -o build/sim_out.out adder_subtractor_8bit.v tb_adder_subtractor_8bit.v

### 3. Execute Simulation to generate VCD file
vvp build/sim_out.out

Open the generated simulation.vcd file using WaveTrace inside VS Code or via GTKWave to view the behavioral timing diagram.

## 👨‍💻 Author
Nguyễn Hữu Việt Dũng - Freshman at Hanoi University of Science and Technology (HUST).

Focus: Integrated Circuit (IC) Design & Digital Systems Architecture.


 
