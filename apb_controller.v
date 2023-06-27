module apb_controller(input hclk,hresetn,hwrite_reg,hwrite,valid,
input[31:0]haddr,hwdata,hwdata_1,hwdata_2,haddr_1,haddr_2,pr_data,
input[2:0]temp_sel,
output reg penable,pwrite,
output reg hr_readyout,
output reg [2:0]psel,
output reg[31:0]paddr,pwdata);

//temporary output variables
reg penable_temp,pwrite_temp,hr_readyout_temp;
reg[2:0]psel_temp;
reg[31:0]paddr_temp,pwdata_temp;

parameter ST_IDLE=3'b000,
 ST_READ=3'b001,
 ST_RENABLE=3'b010,
 ST_WENABLE=3'b011,
 ST_WRITE=3'b100,
 ST_WWAIT=3'b101,
 ST_WRITEP=3'b110,
 ST_WENABLEP=3'b111;
reg[2:0]present,next_state;

//present state logic
always@(posedge hclk)
begin
if(!hresetn)
present<=ST_IDLE;
else
present<=next_state;
end

//next state logic
always@(*)
begin
next_state=ST_IDLE;
case(present)
ST_IDLE:
if(valid==1&&hwrite==1)
next_state=ST_WWAIT;
else if(valid==1&&hwrite==0)
next_state=ST_READ;
else
next_state=ST_IDLE;

ST_WWAIT:if(valid)
next_state=ST_WRITEP;
else
next_state=ST_WRITE;

ST_WRITE:if(valid)
next_state=ST_WENABLEP;
else
next_state=ST_WENABLE;

ST_WENABLEP:if(hwrite_reg==0)
next_state=ST_READ;
else if(valid==1&&hwrite_reg==1)
next_state=ST_WRITEP;
else if(valid==0&&hwrite_reg==1)
next_state=ST_WRITE;

ST_WRITEP:next_state=ST_WENABLEP;

ST_WENABLE:if(valid==1&&hwrite==0)
next_state=ST_READ;
else if(valid==1&&hwrite==1)
next_state=ST_WWAIT;
else if(valid==0)
next_state=ST_IDLE;

ST_READ:next_state=ST_RENABLE;

ST_RENABLE:if(valid==1&&hwrite==0)
next_state=ST_READ;
else if(valid==1&&hwrite==1)
next_state=ST_WWAIT;
else if(valid==0)
next_state=ST_IDLE;

default:next_state=ST_IDLE;
endcase
end

//temporary output logic
always@(*)
begin
case(present)

ST_IDLE: if(valid==1 && hwrite==0)
begin
paddr_temp=haddr;
pwrite_temp=hwrite;
psel_temp=temp_sel;
penable_temp=0;
hr_readyout_temp=0;
end

else if(valid==1&&hwrite==1)
begin
psel_temp=0;
penable_temp=0;
hr_readyout_temp=1;
end

else
begin
psel_temp=0;
penable_temp=0;
hr_readyout_temp=1;
end

ST_READ:
begin
penable_temp=1;
hr_readyout_temp=1;
end

ST_RENABLE:
if(valid==1 && hwrite==0)
begin
paddr_temp=haddr;
pwrite_temp=hwrite;
psel_temp=temp_sel;
penable_temp=0;
hr_readyout_temp=0;
end

else if(valid==1&&hwrite==1)
begin
psel_temp=0;
penable_temp=0;
hr_readyout_temp=1;
end

else
begin
psel_temp=0;
penable_temp=0;
hr_readyout_temp=1;
end

ST_WWAIT:
begin
paddr_temp=haddr_1;
pwdata_temp=hwdata;
pwrite_temp=hwrite;
psel_temp=temp_sel;
penable_temp=0;
hr_readyout_temp=0;
end

ST_WRITE:
begin
penable_temp=1;
hr_readyout_temp=1;
end

ST_WENABLE:if(valid==1 &&hwrite==0)
begin
hr_readyout_temp=1;
psel_temp=0;
penable_temp=0;
end

else if(valid==1 && hwrite==0)
begin
paddr_temp=haddr_1;
pwrite_temp=hwrite_reg;
psel_temp=temp_sel;
penable_temp=0;
hr_readyout_temp=0;
end

else
begin
hr_readyout_temp=1;
psel_temp=0;
penable_temp=0;
end

ST_WRITEP:
begin
penable_temp=1;
hr_readyout_temp=1;
end

ST_WENABLEP:
begin
paddr_temp=haddr_1;
pwdata_temp=hwdata;
pwrite_temp=hwrite;
psel_temp=temp_sel;
penable_temp=0;
hr_readyout_temp=0;
end
endcase
end

//output logic
always@(posedge hclk)
begin
if(!hresetn)
begin
paddr<=0;
pwdata<=0;
pwrite<=0;
psel<=0;
penable<=0;
hr_readyout<=1;
end

else
begin
paddr<=paddr_temp;
pwdata<=pwdata_temp;
pwrite<=pwrite_temp;
psel<=psel_temp;
penable<=penable_temp;
hr_readyout<=hr_readyout_temp;
end

end
endmodule