
module fetch(PC,clk1,inst_out);

input [6:0] PC;
input clk1;
output reg [31:0] inst_out;
integer pc;

//These are the instructions are given.

initial begin
    
/*
LW R3, 0(R2)
DIV R2, R3, R4
MUL R1, R5, R6
ADD R3, R7, R8
MUL R1, R1, R3
SUB R4, R1, R5
ADD R1, R4, R2
*/

/*
LW R3, 0(R2)
DIV R2, R3, R4
MUL R1, R5, R6
ADD R3, R7, R8
MUL R9, R1, R3     // renamed the destination
SUB R4, R9, R5
ADD R1, R4, R2
*/

    
    

    	main.memory[0] = 32'b000000000000_00010_010_00011_0000011;
    	main.memory[1] = 32'b0000001_00100_00011_001_00010_1100011; /// one change here fun3 of div is changed to 001 from 100 
    	main.memory[2] = 32'b0000001_00110_00101_000_00001_1100011;
  	main.memory[3] = 32'b0000000_01000_00111_000_00011_0110011;
  	//main.memory[4] = 32'b0000001_00011_00001_000_00001_1100011;
	//main.memory[5] = 32'b0100000_00101_00001_000_00100_0110011;
	
	main.memory[4] = 32'b0000001_00011_00001_000_01001_1100011;
	main.memory[5] = 32'b0100000_00101_01001_000_00100_0110011;
	
	main.memory[6] = 32'b0000000_00010_00100_000_00001_0110011;
	main.memory[16] = 32'b0000000_00000_00000_000_00000_0010100; //20
end

always@(posedge clk1)
  begin
    pc = PC;
    if(pc<7)
    	inst_out = main.memory[pc];  //Here we are assigning the instruction present in the memory.
    else 
    	inst_out=32'b0;
    
    //$display("%b",PC);
  end


endmodule
