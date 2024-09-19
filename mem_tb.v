module tb_mem();
reg clk, rst, wr, rd;
reg [2:0] addr;
reg [7:0] Datain;
wire [7:0] Dataout;
// Instantiate the memory module
mem uut (
.clk(clk),
.rst(rst),
.wr(wr),
.rd(rd),
.addr(addr),
.Datain(Datain),
.Dataout(Dataout)
);
// Clock generation (period = 10 time units)
always #5 clk = ~clk;
initial begin
// Initialize inputs
clk = 0;
rst = 1;
wr = 0;
rd = 0;
addr = 3'b000;
Datain = 8'h00;
// Test sequence
#10 rst = 0; // Release reset after 10 time units
// Write 8'hA5 into address 3'b001
#10 wr = 1; rd = 0; addr = 3'b001; Datain = 8'hA5;
// Write 8'h3C into address 3'b010
#10 wr = 1; rd = 0; addr = 3'b010; Datain = 8'h3C;
// Disable write and read from address 3'b001
#10 wr = 0; rd = 1; addr = 3'b001;
// Read from address 3'b010
#10 wr = 0; rd = 1; addr = 3'b010;
// Write 8'hFF into address 3'b011
#10 wr = 1; rd = 0; addr = 3'b011; Datain = 8'hFF;
// Read from address 3'b011
#10 wr = 0; rd = 1; addr = 3'b011;
// Test reset functionality
#10 rst = 1;
#10 rst = 0; wr = 0; rd = 1; addr = 3'b011; // Try to read after reset
// End of test
#20 $finish;
end
// Monitor outputs
initial begin
$monitor("At time %t, addr = %b, Datain = %h, Dataout = %h, wr = %b, rd = %b, rst = %b",
$time, addr, Datain, Dataout, wr, rd, rst);
end
endmodule




