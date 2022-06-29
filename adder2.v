module adder2 (data1,data2,des,fun7,fla,clk1,clk2);

input [31:0]data1;
input [31:0]data2;
input [2:0]des;
input [6:0]fun7;
input fla;
input clk1,clk2;
reg busys;
integer i1,i2;
always@(posedge clk1)
begin
	if (fla==1)
	begin
		busys=1;
		if(fun7==0)
		begin
			main.adde2out<=#40 data1+data2;
			busys<=#41 0;
			main.exeadd[1]<= #40 0;
			#42; 
		end
		if(fun7==7'b0100000)
		begin
			main.adde2out<=#40 data1-data2;
			busys<=#41 0;
			main.exeadd[1]<= #40 0;
			#42;
		end
	end

	if(busys == 0)
    	begin
        	$display("\n adder %d :",1);
        	$display("data1 = %b, data2 = %b, fun7 = %b, des= %b,output = %b\n",data1,data2,fun7,des,main.adde2out);
        	for(i1=0;i1<3;i1++)
        	begin 
        		if (main.RSaddready1[i1]==0&&main.RSaddtag1[i1]==des)
        		begin
        			main.RSadd1[i1]<=main.adde2out;
        			main.RSaddready1[i1]<=1;
        		end
        		if (main.RSaddready2[i1]==0&&main.RSaddtag2[i1]==des)
        		begin
        			main.RSadd2[i1]<=main.adde2out;
        			main.RSaddready2[i1]<=1;
        		end
        		
        		if (main.RSmulready1[i1]==0&&main.RSmultag1[i1]==des)
        		begin
        			main.RSmul1[i1]<=main.adde2out;
        			main.RSmulready1[i1]<=1;
        		
        		end
        		if (main.RSmulready2[i1]==0&&main.RSmultag2[i1]==des)
        		begin
        			main.RSmul2[i1]<=main.adde2out;
        			main.RSmulready2[i1]<=1;
        		end
        	end
        	
        	main.Robdata[des]=main.adde2out;
        	main.status_rob_value[des]=1;
        	busys=1;
        	main.add_rs_c=main.add_rs_c-1;
    	end
end

endmodule
