`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2026 10:02:03
// Design Name: 
// Module Name: advanced_traffic_controller
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


module advanced_traffic_controller(
input clk,rst,ped_req,emergency_ns,emergency_ew,traffic_ns,traffic_ew,
output reg red_ns,yellow_ns,green_ns,red_ew,yellow_ew,green_ew,walk
    );
reg [2:0]NS,PS;
reg [4:0]counter;
parameter  S_NS_GREEN=3'b000,
           S_NS_YELLOW=3'b001,
           S_EW_GREEN=3'b010,
           S_EW_YELLOW=3'b011,
           S_PEDESTRIAN=3'b100,
           S_EMERGENCY_NS=3'b101,
           S_EMERGENCY_EW=3'b110;
always @(posedge clk) begin
   if(rst) begin
     PS<=S_NS_GREEN;
     counter<=0;
   end
   else begin
      PS<=NS;
      counter<=counter+1;
   end
end
always @(*) begin
NS=PS;
if (emergency_ns)
      NS = S_EMERGENCY_NS;
   else if (emergency_ew)
      NS = S_EMERGENCY_EW;
   else if (ped_req)
      NS = S_PEDESTRIAN;
 else begin
 case(PS)
 S_NS_GREEN: begin
            if (counter == 15) begin
               if (traffic_ew)      
                  NS = S_NS_YELLOW;
               else                  
                  NS = S_NS_GREEN;
            end
         end
S_NS_YELLOW : begin
            if (counter == 5)
               NS = S_EW_GREEN;
         end
S_EW_GREEN : begin
            if (counter == 15) begin
               if (traffic_ns)       
                  NS = S_EW_YELLOW;
               else                  
                  NS = S_EW_GREEN;
            end
         end
          S_EW_YELLOW: begin
            if (counter == 5)
               NS = S_NS_GREEN;
               end
         S_PEDESTRIAN: begin
            if (counter == 10)
               NS = S_NS_GREEN;
         end
         S_EMERGENCY_NS: begin
            if (!emergency_ns)
               NS = S_NS_GREEN;
         end
S_EMERGENCY_EW : begin
            if (!emergency_ew)
               NS = S_EW_GREEN;
         end
default: NS = S_NS_GREEN;
endcase
   end
end
always @(posedge clk) begin  
 red_ns<=0;yellow_ns<=0;green_ns<=0;
 red_ew<=0;yellow_ew<=0;green_ew<=0;walk<=0;       
 case(PS)   
 S_NS_GREEN:begin
   green_ns<=1;red_ew<=1;
 end
S_NS_YELLOW : begin
  yellow_ns<=1;red_ew<=1;
end
S_EW_GREEN : begin
  green_ew<=1;red_ns<=1;
end
S_EW_YELLOW : begin
   yellow_ew<=1;red_ns<=1;
end
S_PEDESTRIAN : begin
  walk<=1;
  red_ns<=1;
  red_ew<=1;
end
S_EMERGENCY_NS : begin
  green_ns<=1;
  red_ew<=1;
end
S_EMERGENCY_EW : begin
  green_ew<=1;
  red_ns<=1;
end
endcase
end          
endmodule
