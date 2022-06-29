module reservation (dis_rs1,dis_rs2,dis_rd,dis_opcode,dis_fun7,dis_fun3,dis_lw_offset,dis_rob_ind,flagd,clk1,clk2);

input [4:0] dis_rs1,dis_rs2,dis_rd;
input [6:0] dis_opcode,dis_fun7;
input [2:0] dis_fun3;
input [11:0] dis_lw_offset; 
input [2:0] dis_rob_ind; // int rob_ind  
input flagd;
input clk1,clk2;
integer a;
integer aa,zx,zx1;
integer add_index,mul_index,load_index;
always @(posedge clk2)
  begin
  		
  		
  		for(a = 0; a<= 2; a++)
      begin
        if(dis_opcode==7'b0110011)
        begin
          if(main.RSaddbusy[a] == 0)
          begin
                add_index =a;
                a=10;
              end
          end
        else if(dis_opcode == 7'b1100011)
        begin
          if(main.RSmulbusy[a] == 0)
          begin
                mul_index =a;
                a=11;
          end
        end
        else if(dis_opcode == 7'b0000011)
        begin
          if(main.RSloadbusy[a]== 0)
          begin
                load_index =a;
                a= 12;
          end
        end
      end
  		
  		
  		
  	 if (flagd == 1)
      begin
       
        if (dis_opcode==7'b0110011)  //RS for add
        begin
            main.RSaddfun7[add_index] <= dis_fun7;
            main.RSaddfun3[add_index] <= dis_fun3;
            main.RSaddbusy[add_index]<=1;
            if(main.tag[dis_rs1]==1)
            begin
            	 main.RSaddtag1[add_index] <= main.rrf[dis_rs1];
          		main.RSaddready1[add_index]<=0;
            end
            else
            begin
            	main.RSadd1[add_index]<=main.arf[dis_rs1];
            	main.RSaddready1[add_index]<=1;
            	main.RSaddtag1[add_index]<=dis_rs1;
            end
            
            if(main.tag[dis_rs2]==1)
            begin
            	 main.RSaddtag2[add_index] <= main.rrf[dis_rs2];
          		main.RSaddready2[add_index]<=0;
            end
            else
            begin
            	main.RSadd2[add_index]<=main.arf[dis_rs2];
            	main.RSaddready2[add_index]<=1;
            	main.RSaddtag2[add_index]<=dis_rs2;
            end
                       
            main.RSadddest[add_index] <= dis_rob_ind;
            main.RSaddexe[add_index] <= 0;

        end
        //RS for mul
        else if (dis_opcode == 7'b1100011)
        begin
            main.RSmulfun7[mul_index][0] <= dis_fun7;
            main.RSmulfun3[mul_index][0] <= dis_fun3;
            main.RSmulbusy[mul_index]<=1;
            if(main.tag[dis_rs1]==1)
            begin
            	 main.RSmultag1[mul_index] <= main.rrf[dis_rs1];
          		main.RSmulready1[mul_index]<=0;
            end
            else
            begin
            	main.RSmul1[mul_index]<=main.arf[dis_rs1];
            	main.RSmulready1[mul_index]<=1;
            	main.RSmultag1[mul_index]<=dis_rs1;
            end
            
            if(main.tag[dis_rs2]==1)
            begin
            	 main.RSmultag2[mul_index] <= main.rrf[dis_rs2];
          		main.RSmulready2[mul_index]<=0;
            end
            else
            begin
            	main.RSmul2[mul_index]<=main.arf[dis_rs2];
            	main.RSmulready2[mul_index]<=1;
            	main.RSmultag2[mul_index]<=dis_rs2;
            end
                       
            main.RSmuldest[mul_index] <= dis_rob_ind;
            main.RSmulexe[mul_index] <= 0;
				end
				
        //RS for load
        else if (dis_opcode == 7'b0000011)
        begin
            main.RSloadfun3[load_index] <= dis_fun3;
            main.RSloadbusy[load_index] <=1;
            if(main.tag[dis_rs1]==1)
            begin
            	 main.RSloadtag1[load_index] <= main.rrf[dis_rs1];
          		main.RSloadready1[load_index]<=0;
            end
            else
            begin
            	main.RSload1[load_index]<=main.arf[dis_rs1];
            	main.RSloadready1[load_index]<=1;
            	main.RSloadtag1[load_index]<=dis_rs1;
            end
            
            main.RSloaddest[load_index] <= dis_rob_ind;
            main.RSloadexe[load_index] <= 0;
            main.RSloadoff[load_index]<=dis_lw_offset;

        end
      end
  
  
  for (aa=0;aa<=2;aa++)
  begin 
 $display("RS ADD %d",aa); 
$display("Source1 data: %b,Source2 data:%b, Busy: %b, Execution:%b Fun7: %b, Fun3: %b, Source1 Tag:%b , Source2 Tag: %b, Source1 Ready:%b , Source2 Ready: %b, Destination ind: %d ", main.RSadd1[aa],main.RSadd2[aa],main.RSaddbusy[aa],main.RSaddexe[aa],main.RSaddfun7[aa],main.RSaddfun3[aa],main.RSaddtag1[aa],main.RSaddtag2[aa],main.RSaddready1[aa],main.RSaddready2[aa],main.RSadddest[aa]);
$display("\n");  
  end
  
  $display("\n\n");
  for (aa=0;aa<=2;aa++)
  begin 
 $display("RS MUL %d",aa); 
$display("Source1 data: %b,Source2 data:%b, Busy: %b, Execution:%b Fun7: %b, Fun3: %b, Source1 Tag:%b , Source2 Tag: %b, Source1 Ready:%b , Source2 Ready: %b, Destination ind: %d ", main.RSmul1[aa],main.RSmul2[aa],main.RSmulbusy[aa],main.RSmulexe[aa],main.RSmulfun7[aa],main.RSmulfun3[aa],main.RSmultag1[aa],main.RSmultag2[aa],main.RSmulready1[aa],main.RSmulready2[aa],main.RSmuldest[aa]);
$display("\n") ; 
  end
    
end // always end

 always@(posedge clk2)
  begin 
  if (!(main.exeadd[0]&&main.exeadd[1]&&main.exeadd[2]))
  	begin 
  	 for (zx=0;zx<3;zx++)	
  		begin 
  			if((main.RSaddready1[zx]==1)&&(main.RSaddready2[zx]==1)&&(main.RSaddexe[zx]==0))
  			begin
  				if ( main.exeadd[0]==0 )
  				begin
  					main.exeadd1[0]<=main.RSadd1[zx];
  					main.exeadd2[0]<=main.RSadd2[zx];
  					main.exeaddfun7[0]<=main.RSaddfun7[zx];
  					main.exeadddest[0]<=main.RSadddest[zx];
  					main.RSaddexe[zx]<=1;
  					
  					main.exeadd[0]<=1;
  					zx=7;
  				end
  				
  				else if ( main.exeadd[1]==0 )
  				begin
  					main.exeadd1[1]<=main.RSadd1[zx];
  					main.exeadd2[1]<=main.RSadd2[zx];
  					main.exeaddfun7[1]<=main.RSaddfun7[zx];
  					main.exeadddest[1]<=main.RSadddest[zx];
  					main.RSaddexe[zx]<=1;
  					//zx=8;
  					main.exeadd[1]<=1;
  					zx=8;
  				end
  				
  				else if ( main.exeadd[2]==0 )
  				begin
  					main.exeadd1[2]<=main.RSadd1[zx];
  					main.exeadd2[2]<=main.RSadd2[zx];
  					main.exeaddfun7[2]<=main.RSaddfun7[zx];
  					main.exeadddest[2]<=main.RSadddest[zx];
  					main.RSaddexe[zx]<=1;
  					//zx=9;
  					main.exeadd[2]<=1;
  					zx=9;
  				end
  			end
  		end
  	end
  if (!(main.exemul[0]&&main.exemul[1]&&main.exemul[2]))
  	begin 
  	 for (zx1=0;zx1<3;zx1++)
  	 	
  		begin
  			$display ("%d",zx1); 
  			if((main.RSmulready1[zx1]==1)&&(main.RSmulready2[zx1]==1)&&(main.RSmulexe[zx1]==0))
  			begin
  				if ( main.exemul[0]==0 )
  				begin
  					main.exemul1[0]<=main.RSmul1[zx1];
  					main.exemul2[0]<=main.RSmul2[zx1];
  					main.exemulfun3[0]<=main.RSmulfun3[zx1];
  					main.exemuldest[0]<=main.RSmuldest[zx1];
  					main.RSmulexe[zx1]<=1;
  					//zx1=7;
  					 main.exemul[0]<=1;
  					 zx1=7;
  				end
  				
  				else if ( main.exemul[1]==0 )
  				begin
  					main.exemul1[1]<=main.RSmul1[zx1];
  					main.exemul2[1]<=main.RSmul2[zx1];
  					main.exemulfun3[1]<=main.RSmulfun3[zx1];
  					main.exemuldest[1]<=main.RSmuldest[zx1];
  					main.RSmulexe[zx1]<=1;
  					//zx1=8;
  					main.exemul[1]<=1;
  					zx1=8;
  				end
  				
  				else if ( main.exemul[2]==0 )
  				begin
  					main.exemul1[2]<=main.RSmul1[zx1];
  					main.exemul2[2]<=main.RSmul2[zx1];
  					main.exemulfun3[2]<=main.RSmulfun3[zx1];
  					main.exemuldest[2]<=main.RSmuldest[zx1];
  					main.RSmulexe[zx1]<=1;
  					
  					main.exemul[2]<=1;
  					zx1=9;
  				end
  			end
  		end
  	end
  if (!(main.exeload))
  	begin 
  	 for (zx1=0;zx1<3;zx1++)	
  		begin 
  			if((main.RSloadready1[zx1]==1))
  			begin
  				if ( main.exeload==0 )
  				begin
  					main.exeload1<=main.RSload1[zx1];
  					main.exeloadoff<=main.RSloadoff[zx1];
  					main.exeloadfun3<=main.RSloadfun3[zx1];
  					main.exeloaddest<=main.RSloaddest[zx1];
  					main.RSloadexe[zx1]<=1;
  					zx1=7;
  					main.exeload<=1;
  				end
  				
  			end
  		end
  	end
  
  
  
  end
adder1 exa1(main.exeadd1[0],main.exeadd2[0],main.exeadddest[0],main.exeaddfun7[0],main.exeadd[0],clk1,clk2);
adder2 exa2(main.exeadd1[1],main.exeadd2[1],main.exeadddest[1],main.exeaddfun7[1],main.exeadd[1],clk1,clk2);
adder3 exa3(main.exeadd1[2],main.exeadd2[2],main.exeadddest[2],main.exeaddfun7[2],main.exeadd[2],clk1,clk2);

multer1 exm1(main.exemul1[0],main.exemul2[0],main.exemuldest[0],main.exemulfun3[0],main.exemul[0],clk1,clk2);
multer2 exm2(main.exemul1[1],main.exemul2[1],main.exemuldest[1],main.exemulfun3[1],main.exemul[1],clk1,clk2);
multer3 exm3(main.exemul1[2],main.exemul2[2],main.exemuldest[2],main.exemulfun3[2],main.exemul[2],clk1,clk2);

loader1 exl1(main.exeload1,main.exeloadoff,main.exeloaddest,main.exeload,clk1,clk2);  
endmodule
