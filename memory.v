module memorys;
  reg [31:0] arf[0:15]; //First column is actual value and second column is ROB
  reg [31:0] rrf[0:15]; // contents in rrf
  reg status_rob[0:7][0:2]; // for every rob place-occupied,value available
  reg [31:0] ROBdata[0:7];  //32 beacuse we need to wirte data. 
  reg [4:0] Robdest[0:7];
  reg [31:0] memory[0:255]; //Memory upto 256 inst
endmodule 
