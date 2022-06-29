module multer3 (data1,data2,des,fun3,fla,clk1,clk2);

input [31:0]data1;
input [31:0]data2;
input [2:0]des;
input [2:0]fun3;
input fla;
input clk1,clk2;
reg busys;
integer i1,i2;
always@(posedge clk1)
begin
	if (fla==1)
	begin
		busys=1;
		if(fun3==1) //div
		begin
			main.mule3out<=#1600 data1/data2;
			busys<=#1601 0;
			main.exemul[2]<= #1600 0;
			#1602; 
		end
		if(fun3==0) //mul
		begin
			main.mule3out<=#400 data1*data2;
			busys<=#401 0;
			main.exemul[2]<= #400 0;
			#402;
		end
	end

	if(busys == 1)
    	begin
        	$display("\n multer %d :",2);
        	$display("data1 = %b, data2 = %b, fun3 = %b, des= %b,output = %b\n",data1,data2,fun3,des,main.mule3out);
        	for(i1=0;i1<3;i1++)
        	begin 
        		if (main.RSaddready1[i1]==0&&main.RSaddtag1[i1]==des)
        		begin
        			main.RSadd1[i1]<=main.mule3out;
        			main.RSaddready1[i1]<=1;
        		end
        		if (main.RSaddready2[i1]==0&&main.RSaddtag2[i1]==des)
        		begin
        			main.RSadd2[i1]<=main.mule3out;
        			main.RSaddready2[i1]<=1;
        		
        		end
        		if (main.RSmulready1[i1]==0&&main.RSmultag1[i1]==des)
        		begin
        			main.RSmul1[i1]<=main.mule3out;
        			main.RSmulready1[i1]<=1;
        		
        		end
        		if (main.RSmulready2[i1]==0&&main.RSmultag2[i1]==des)
        		begin
        			main.RSmul2[i1]<=main.mule3out;
        			main.RSmulready2[i1]<=1;
        		end
        	end
        	
        	main.Robdata[des]=main.mule3out;
        	main.status_rob_value[des]=1;
        	busys=1;
        	main.mul_rs_c=main.mul_rs_c-1;
        	
        	
    	end
end

endmodule
