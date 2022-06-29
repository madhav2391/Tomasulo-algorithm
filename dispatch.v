module dispatch (opcode,fun7,fun3,decode_rs1,decode_rs2,decode_rd,lw_offset,clk1, clk2);

	input  [4:0] decode_rs1,decode_rs2,decode_rd;
  input  [6:0] opcode,fun7;
  input [2:0] fun3;
  input [11:0] lw_offset;  
	input clk1,clk2;
	
always @(posedge clk1)
begin/// forgot abt load store impliment it also.
    main.flagd = 0;
	if (main.tail - main.head<7)    // should think abt clearing the values of head and tail.
	begin
        
            
		if(  (opcode == 7'b0110011) &&  (main.add_rs_c <4))
        	begin 
                main.flagd   =  1;
                end
            
		else if((opcode == 7'b1100011) && (main.mul_rs_c <4))
            	begin
                main.flagd = 1;
        	end
        		
		else if((opcode == 7'b0000011) && (main.load_rs_c < 4))
            	begin
                main.flagd = 1;
        	end
        		
        
	end
    // if complete


    
    if (main.flagd == 1)
    begin
    // $display("rs1_b = %b,rs2_b = %b,func = %b",main.pr2_rs1b,main.pr2_rs2b,func);
        main.Robopcode[main.tail]=opcode;
        main.Robdest[main.tail]= decode_rd;
        main.tag[decode_rd]=1;
        main.rrf[decode_rd] = main.tail;
        main.dis_rob_ind = main.tail;
        main.status_rob_place[main.dis_rob_ind]=1;
        main.tail += 1;
        if(opcode == 7'b0110011)
            main.add_rs_c += 1;
        if(opcode == 7'b1100011)
            main.mul_rs_c += 1;
        if(opcode == 7'b0000011)
            main.load_rs_c += 1;
    end
    

// new variables

main.dis_rs1<= decode_rs1;
main.dis_rs2<=decode_rs2;
main.dis_rd<=decode_rd;
main.dis_opcode<= opcode;
main.dis_fun7<=fun7;
main.dis_fun3<=fun3;
main.dis_lw_offset<=lw_offset;

#2;
    $display("\nIssue stage :");
    $display("values of func7 = %b,values of func3 = %b,values of rs1 = %b,values of rs2 = %b,values of rd = %b,value of opcode= %b, value of lw offset=%b\n\n",main.dis_fun7,main.dis_fun3,main.dis_rs1,main.dis_rs2,main.dis_rd,main.dis_opcode,main.dis_lw_offset);
    $display("\n add rs: %d,mul rs: %d,load rs: %d",main.add_rs_c,main.mul_rs_c,main.load_rs_c);
    $display("\n flagd :%b",main.flagd);
end // always complete.
reservation r1(main.dis_rs1,main.dis_rs2,main.dis_rd,main.dis_opcode,main.dis_fun7,main.dis_fun3,main.dis_lw_offset,main.dis_rob_ind,main.flagd,clk1,clk2);
endmodule
