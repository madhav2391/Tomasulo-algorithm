
module main(pc,clk1,clk2);

  input[6:0] pc;
  input clk1,clk2;

  wire [31:0] inst; //This is for getting instruction from ins set
  
  reg [4:0] decode_rs1,decode_rs2,decode_rd;
  reg [6:0] opcode,fun7;
  reg[2:0] fun3;
  reg[11:0] lw_offset;  
  
 reg [6:0]pcreg;
integer add_rs_c,mul_rs_c,load_rs_c; //These are needed in issue stage
reg [2:0] head,tail;
reg flagd;

 
 
 
/***************************************************************/

/************************ memory.v******************************/

	reg [31:0] arf[0:31]; // 32 regs length 32
  reg [31:0] memory[0:255]; //Memory
  reg [2:0] rrf[0:31]; // contains tag of rob
	reg tag[0:31];// says if we have data in the arf or tag in the rrf
// 1 ante tag undi ani
  reg status_rob_place[0:7];
  reg status_rob_value[0:7]; // for every rob place-occupied,value available
  
  
// below three as per pdf.  
  reg [31:0] Robdata[0:7];  //32 beacuse we need to wirte data. 
  reg [4:0] Robdest[0:7];
  reg [6:0] Robopcode[0:7];
  reg [4:0] Robpc[0:7];

/********************************************************************/

//integer flag= status_rob_place[0]+status_rob_place[1]+status_rob_place[2]+status_rob_place[3]+status_rob_place[4]+status_rob_place[5]+status_rob_place[6]+status_rob_place[7];
integer i;
integer k;
integer ff;


reg [4:0] dis_rs1,dis_rs2,dis_rd;
reg [6:0] dis_opcode,dis_fun7;
reg[2:0] dis_fun3;
reg[11:0] dis_lw_offset; 
reg[2:0] dis_rob_ind; // int rob_ind  


/*******************************************************Rs***********************************************************/
reg [31:0]RSadd1[0:2];//first operand 
reg [31:0]RSadd2[0:2];//second operand
reg RSaddbusy[0:2];// busy bit for availability
reg RSaddexe[0:2]; // busy bit for execution
reg [6:0]RSaddfun7[0:2];
reg [2:0]RSaddfun3[0:2];
reg [4:0]RSaddtag1[0:2];  //Tag of Operand A
reg [4:0]RSaddtag2[0:2];
reg RSaddready1[0:2];
reg RSaddready2[0:2];
reg [2:0]RSadddest[0:2];
integer rsat;


reg [31:0]RSmul1[0:2];//first operand 
reg [31:0]RSmul2[0:2];//second operand
reg RSmulbusy[0:2];// busy bit for availability
reg RSmulexe[0:2]; // busy bit for execution
reg [6:0]RSmulfun7[0:2];
reg [2:0]RSmulfun3[0:2];
reg [4:0]RSmultag1[0:2];  //Tag of Operand A
reg [4:0]RSmultag2[0:2];
reg RSmulready1[0:2];
reg RSmulready2[0:2];
reg [2:0]RSmuldest[0:2];
integer rsmt;


reg [31:0]RSload1[0:2];//first operand 
//reg [31:0]RSload2[0:2];//second operand
reg RSloadbusy[0:2];// busy bit
//reg [6:0]RSloadfun7[0:2];
reg [2:0]RSloadfun3[0:2];
reg [4:0]RSloadtag1[0:2];  //Tag of Operand A
reg RSloadready1[0:2];
reg [11:0]RSloadoff[0:2];
reg [2:0]RSloaddest[0:2];
reg RSloadexe[0:2]; // busy bit for execution
//integer rsmt;


reg exeadd[0:2];
reg [31:0]exeadd1[0:2];
reg [31:0]exeadd2[0:2];
reg [6:0]exeaddfun7[0:2];
reg [2:0]exeadddest[0:2];
reg [31:0]adde1out;
reg [31:0]adde2out;
reg [31:0]adde3out;

reg exemul[0:2];
reg [31:0]exemul1[0:2];
reg [31:0]exemul2[0:2];
reg [2:0]exemulfun3[0:2];
reg [2:0]exemuldest[0:2];
reg [31:0]mule1out;
reg [31:0]mule2out;
reg [31:0]mule3out;


reg exeload;
reg [31:0]exeload1;
reg [11:0]exeloadoff;
reg [2:0]exeloadfun3;
reg [2:0]exeloaddest;
reg [31:0]loade1out;


/*initial begin
 for(k= 0;k < 8;k++)
 begin
      ff=ff+tomas.status_rob_place[k];
end
end
*/
integer cot;
reg rbc;
integer r1;
task WB;
//@(negedge clk2)
begin
	if (status_rob_value[rbc]==1 && rbc<8)
	
	begin
	arf[Robdest[rbc]]=Robdata[rbc];
	tag[Robdest[rbc]]=0;
	status_rob_place[rbc]=0;
	rbc=rbc+1;
	end

end



endtask










always@(inst)
begin
cot=0;
for(i= 0;i < 8;i++)
	begin
      		cot=cot+status_rob_place[i];
	end
end

//$display("%d",cot);
reg [6:0]pc1;
initial begin
pc1=0;
pcreg=pc1;
end 

always @(posedge clk2)

begin

	if (cot<8)
      pcreg = pcreg+1;
    else 
    	pcreg=pcreg;
end
fetch k1(pcreg,clk1,inst);
//pc=5'b00000;
always @(inst)
  begin
  $display("\nIn fetch stage:");
  //$display("%b",in)
  fun7 = inst[31:25];
  decode_rs1 = inst[19:15];
  decode_rs2 = inst[24:20];
  fun3=inst[14:12];
  decode_rd = inst[11:7];
  opcode=inst[6:0];
  lw_offset=inst[31:20];
  $display("%b",inst);
  $display("\n Decoded Values:");
  $display("values of pc = %b,values of func7 =%b,values of func3 = %b,values of rs1 = %b,values of rs2 = %b,values of rd = %b,value of opcode= %b, value of lw offset=%b\n\n",pc,fun7,fun3,decode_rs1,decode_rs2,decode_rd,opcode,lw_offset);
end
dispatch d1 (opcode,fun7,fun3,decode_rs1,decode_rs2,decode_rd,lw_offset,clk1, clk2);
always@(negedge clk2)
	WB;

endmodule
