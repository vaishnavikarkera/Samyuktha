module mem(clk, rst, wr, rd, addr, Datain, Dataout);
input clk, rst, wr, rd;
input [2:0] addr;
input [7:0] Datain;
output reg [7:0] Dataout;
// Declareing memory storage
reg [7:0] mem [0:7]; // 8 x 8-bit memory
always @(posedge clk) begin
if (rst) begin
Dataout <= 8'b0; // Initialize output on reset
end else begin
case ({wr, rd})
2'b10 : mem[addr] <= Datain; // Write operation
2'b01 : Dataout <= mem[addr]; // Read operation
default: Dataout <= 8'bz; // High impedance for other cases
endcase
end
end
endmodule
