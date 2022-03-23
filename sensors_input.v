`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:25 11/10/2021 
// Design Name: 
// Module Name:    sensors_input 
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
 module sensors_input(
	output [7:0] height,
   input [7:0] sensor1,
   input [7:0] sensor2,
   input [7:0] sensor3,
   input [7:0] sensor4
	);

	reg [7:0] medie;
	reg [7:0] cat;
	reg [1:0] rest;
	
	always @(*) begin
		
		//Daca unul sau ambii senzori din perechea 1-3 este/sunt 0
		if (sensor1 == 8'b0 || sensor3 == 8'b0) begin
			cat = (sensor2 + sensor4) / 2;
			rest = (sensor2 + sensor4) - cat * 2 ;
			case (rest)
				'b0: medie = cat; // rest 0 inseamna 0
				'b1: medie = cat + 1; //rest 1 inseamna 0.5, trebuie aproximat
				default: medie = 0; 
			endcase
		
		//Daca unul sau ambii senzori din perechea 2-4 este/sunt 0
		end else if (sensor2 == 8'b0 || sensor4 == 8'b0) begin
			cat = (sensor1 + sensor3) / 2;
			rest = (sensor1 + sensor3) - cat * 2 ;
			case (rest)
				'b0: medie = cat; // rest 0 inseamna 0
				'b1: medie = cat + 1; // rest 1 inseamna 0.5, trebuie aproximat
				default: medie = 0; 
			endcase
		
		//Daca toti cei patru senzori au valoare nenula
		end else begin
			cat = (sensor1 + sensor2 + sensor3 + sensor4) / 4;
			rest = (sensor1 + sensor2 + sensor3 + sensor4) - cat * 4;	
			case (rest)
				'b0: medie = cat; // rest 0 inseamna 0
				'b1: medie = cat; // rest 1 inseamna 0.25
				'b10: medie = cat + 1; // rest 2 inseamna 0.5, trebuie aproximat
				'b11: medie = cat + 1; // rest 3 inseamna 0.75, trebuie aproximat
				default: medie = 0; 
			endcase
		end
	end
	
	//Atribuire continua pentru output
	assign height = medie;

endmodule
