module loader1(data1,offe,des,fla,clk1,clk2);


input [31:0]data1;
input [11:0] offe;
input [2:0]des;
input fla;
input clk1,clk2;
reg busys;
integer i1,i2,i3,i4,i5,i6;
reg [11:0]check;
always@(posedge clk1)
begin
	if (fla==1)
	begin
		busys=1;
			//i2=0;
			i4=data1;
			i5=i4+offe;
			i6=main.memory[i5];
			i2=main.arf[2];
			i3=i2+offe;
			main.loade1out<=#200 i6;
			busys<=#201 0;
			main.exeadd[0]<= #200 0;
			#202; 
	end

	if(busys == 0)
    	begin
        	$display("\n loader %d :",0);
        	$display("data1 = %b, offset = %b, des= %b,output = %b\n",data1,offe,des,main.loade1out);
        	
        	for(i1=0;i1<3;i1++)
        	begin 
        		if (main.RSaddready1[i1]==0&&main.RSaddtag1[i1]==des)
        		begin
        			main.RSadd1[i1]<=main.loade1out;
        			main.RSaddready1[i1]<=1;
        		end
        		if (main.RSaddready2[i1]==0&&main.RSaddtag2[i1]==des)
        		begin
        			main.RSadd2[i1]<=main.loade1out;
        			main.RSaddready2[i1]<=1;
        		end
        		
        		if (main.RSmulready1[i1]==0&&main.RSmultag1[i1]==des)
        		begin
        			main.RSmul1[i1]<=main.loade1out;
        			main.RSmulready1[i1]<=1;
        		
        		end
        		if (main.RSmulready2[i1]==0&&main.RSmultag2[i1]==des)
        		begin
        			main.RSmul2[i1]<=main.loade1out;
        			main.RSmulready2[i1]<=1;
        		end
        	end
        	
        	main.Robdata[des]=main.loade1out;
        	main.status_rob_value[des]=1;
        	busys=1;
    	end
end

endmodule
