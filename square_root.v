`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:25 11/10/2021 
// Design Name: 
// Module Name:    square_root 
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
module square_root(
	output [15:0] out,
   input [7:0] in
   );
	
	reg [31:0] in_aux;
	reg [15:0] base;
	reg [15:0] result;
	
	always@(*) begin
		//Shiftare la stanga pentru precizia radacinii 
		//numerelor care nu sunt patrate perfecte
		in_aux = in << 16; 
		base = 1 << 15;
		result = 0;
		repeat(16) begin 
			result = result + base;
			if(result * result > in_aux) begin
				result = result - base; // Baza nu ar fi trebuit adaugata, asa ca scadem din nou
			end
			base = base >> 1; //Echivalent cu impartirea la 2
		end
	end
	
	//Atribuire continua pentru output
	assign out = result;

endmodule
