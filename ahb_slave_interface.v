module ahb_slave_interface(input hclk,hresetn,hwrite,hready_in,
input [1:0]htrans,input [31:0]hwdata,haddr,pr_data,
output reg hwrite_reg,hwrite_reg1,valid,
output reg [31:0]hwdata_1,hwdata_2,haddr_1,haddr_2,
output [31:0]hr_data,output reg [2:0]temp_sel);

//pipelining haddr, hwdata and the write signal

always@(posedge hclk)
begin
if(!hresetn)
begin
haddr_1<=0;
haddr_2<=0;
end
else
begin
haddr_1<=haddr;
haddr_2<=haddr_1;
end
end

always@(posedge hclk)
begin
if(!hresetn)
begin
hwdata_1<=0;
hwdata_2<=0;
end
else
begin
hwdata_1<=hwdata;
hwdata_2<=hwdata_1;
end
end

always@(posedge hclk)
begin
if(!hresetn)
begin
hwrite_reg<=0;
hwrite_reg1<=0;
end
else
begin
hwrite_reg<=hwrite;
hwrite_reg1<=hwrite_reg;
end
end

//generating valid signal

always@(*)
begin
if(hready_in==1 && haddr >= 32'h8000_0000 && haddr <32'h8c00_0000 && htrans ==2'b10 || htrans == 2'b11)
valid=1;
else
valid=0;
end

//generating temp_sel signal

always@(*)
begin
if(haddr >= 32'h8000_0000 && haddr <32'h8400_0000)
temp_sel=3'b001;
else if(haddr>=32'h8400_0000 && haddr <32'h8800_0000)
temp_sel=3'b010;
else if(haddr>=32'h8800_0000 && haddr <32'h8c00_0000)
temp_sel=3'b100;
else
temp_sel=0;
end

assign hr_data=pr_data;
endmodule
