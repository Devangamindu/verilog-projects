`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2026 10:45:20
// Design Name: 
// Module Name: advanced_traffic_controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module advanced_traffic_controller_tb;
reg clk,rst,ped_req,emergency_ns,emergency_ew,traffic_ns,traffic_ew;
wire red_ns,yellow_ns,green_ns,red_ew,yellow_ew,green_ew,walk;
advanced_traffic_controller uut(.clk(clk),.rst(rst),.ped_req(ped_req)
,.emergency_ns(emergency_ns),.emergency_ew(emergency_ew),.traffic_ns(traffic_ns),.traffic_ew(traffic_ew)
,. red_ns(red_ns),.yellow_ns(yellow_ns),.green_ns(green_ns),.red_ew(red_ew),.yellow_ew(yellow_ew),.green_ew(green_ew),.walk(walk));
initial begin
   repeat(100)
     begin
       clk=1'b0;#5;
       clk=1'b1;#5;
     end
end
initial begin
  rst = 1;
   ped_req = 0;emergency_ns = 0;emergency_ew = 0;traffic_ns = 1;traffic_ew = 1;#20
    rst = 0;#100;
   ped_req = 1;#20;
   ped_req = 0;#50;
   emergency_ns = 1;#30;
   emergency_ns = 0;#50;
   emergency_ew = 1;#30;
   emergency_ew = 0;#50;
   traffic_ew = 0;#100;
   traffic_ew = 1;
   traffic_ns = 0;#100;  
end
endmodule
