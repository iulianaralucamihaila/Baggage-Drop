`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:05 11/10/2021 
// Design Name: 
// Module Name:    display_and_drop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display_and_drop(
	output [6:0] seven_seg1, 
   output [6:0] seven_seg2,
   output [6:0] seven_seg3,
   output [6:0] seven_seg4,
   output [0:0] drop_activated,
   input [15:0] t_act,
   input [15:0] t_lim,
   input drop_en
   );
	
	reg [6:0] seven_seg1_aux;
	reg [6:0] seven_seg2_aux;
	reg [6:0] seven_seg3_aux;
	reg [6:0] seven_seg4_aux;
	reg drop_aux;
	
	always@(*) begin
			
		//Pentru afisarea mesajului cold
		if(t_act < t_lim && drop_en == 0) begin
			seven_seg1_aux = 7'b011_1001;
			seven_seg2_aux = 7'b101_1100;
			seven_seg3_aux = 7'b011_1000;
			seven_seg4_aux = 7'b101_1110;
			drop_aux = 0;
		end
		
		//Pentru afisarea mesajului drop
		if(t_act < t_lim && drop_en == 1) begin
			seven_seg1_aux = 7'b101_1110;
			seven_seg2_aux = 7'b101_0000;
			seven_seg3_aux = 7'b101_1100;
			seven_seg4_aux = 7'b111_0011;
			drop_aux = 1;
		end
				
		//Pentru afisarea mesajului hot
		if(t_act > t_lim && drop_en == 1) begin
			seven_seg1_aux = 7'b000_0000;
			seven_seg2_aux = 7'b111_0110;
			seven_seg3_aux = 7'b101_1100;
			seven_seg4_aux = 7'b111_1000;
			drop_aux = 0;
		end
		
    end
	
	 //Atribuire continua pentru output-uri
    assign seven_seg1 = seven_seg1_aux;
	 assign seven_seg2 = seven_seg2_aux;
	 assign seven_seg3 = seven_seg3_aux;
	 assign seven_seg4 = seven_seg4_aux;
	 assign drop_activated = drop_aux;

endmodule
