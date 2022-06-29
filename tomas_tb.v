
module tomasulo_tb;

reg[6:0] pc;
reg clk1,clk2;
integer  k;
integer clock_cycle;
integer i,ir;
main tomas(
.pc(pc),
.clk1(clk1),
.clk2(clk2)
);

initial begin
  $dumpfile("vcd.vcd");
  $dumpvars(0,tomasulo_tb);
  clk1 = 0; clk2 = 0; pc = 0;
  clock_cycle = 1;
  repeat(100)
    begin
      $display("\n\nCLOCK CYCLE : %d",clock_cycle);
      for(ir=1;ir<11;ir++)
	begin
      		$display("\n arf[%d]=%d",ir,tomas.arf[ir]);
	end	    
	for(ir=0;ir<8;ir++)
	begin
      		$display("\n robdata[%d]=%d",ir,tomas.Robdata[ir]);
	end
      
      #10 clk1 = 1; #10 clk1 = 0;
      #10 clk2 = 1; #10 clk2 = 0;
      clock_cycle += 1;
   end
end
initial begin
for(i= 0;i < 8;i++)
begin
      tomas.status_rob_place[i]=0;
      
end

for(i= 0;i < 3;i++)
begin
      tomas.RSaddbusy[i]=0;
      tomas.RSaddexe[i]=0;
      tomas.RSmulbusy[i]=0;
      tomas.RSmulexe[i]=0;
      tomas.RSloadbusy[i]=0;
      tomas.RSloadexe[i]=0;
      tomas.exeadd[i]=0;
      tomas.exeadd1[i]=0;
      tomas.exeadd2[i]=0;
	tomas.exeaddfun7[i]=0;
	tomas.exeadddest[i]=0;
	tomas.exemul[i]=0;
      tomas.exemul1[i]=0;
      tomas.exemul2[i]=0;
	tomas.exemulfun3[i]=0;
	tomas.exemuldest[i]=0;
	tomas.exeload=0;
	tomas.exeload1=0;
	tomas.exeloadoff=0;
	tomas.exeloaddest=0;
	tomas.RSmulfun7[i]=0;
	tomas.RSmulfun3[i]=0;
      
end



tomas.arf[0]=0;
tomas.arf[1]=12;
tomas.arf[2]=16;
tomas.arf[3]=45;
tomas.arf[4]=5;
tomas.arf[5]=3;
tomas.arf[6]=4;
tomas.arf[7]=1;
tomas.arf[8]=2;
tomas.arf[9]=2;
tomas.arf[10]=3;


tomas.adde1out=0;
tomas.adde2out=0;
tomas.adde3out=0;

tomas.mule1out=0;
tomas.mule2out=0;
tomas.mule3out=0;

tomas.loade1out=0;

tomas.dis_rob_ind=3'b000;
tomas.tail=3'b000;
tomas.head=3'b000;
tomas.add_rs_c=0;
tomas.mul_rs_c=0;
tomas.load_rs_c=0;  // head tail robind intialize chey
tomas.pcreg=0;
tomas.rbc=0;
end

always @(posedge clk2)
begin
      pc += 0;
end



endmodule
