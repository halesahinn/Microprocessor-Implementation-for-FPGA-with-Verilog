
module Last(inclk,button,fetch,reset,decode,rw,ex,ACCout,op,adr);
input inclk,button;
input fetch,reset,decode,rw,ex;
output [7:0] ACCout;
wire cout,zout,nout,ovfout;
wire instype;
output [2:0] adr,op;
wire [11:0] instr,in0,in1,in2,in3,in4,in5,in6,in7;
wire [7:0] value,ALUout,RAMout,ALUinput;
wire [1:0] addrRam;

assign in0 = 12'b010000011001;
assign in1 = 12'b1111xxxxxx00;
assign in2 = 12'b010000101101;
assign in3 = 12'b1111xxxxxx01;
assign in4 = 12'b1100xxxxxx00;
assign in5 = 12'b1000xxxxxx01;
assign in6 = 12'b1111xxxxxx10;
assign in7 = 12'b1110xxxxxx10;

Debounce(inclk,button,clk);
programCounter(fetch,clk,reset,adr);
ROMunit(adr,in0,in1,in2,in3,in4,in5,in6,in7,instr);
instructionReg(instr,clk,decode,op,value,instype);
assign addrRam[0] = value[0];
assign addrRam[1] = value[1];
RAMunit(addrRam,rw,clk,ACCout,RAMout);


mux_2_to_1(value[0],RAMout[0],instype,ALUinput[0]); //0 sa imm al 1 se ramden okuduğunu
mux_2_to_1(value[1],RAMout[1],instype,ALUinput[1]);
mux_2_to_1(value[2],RAMout[2],instype,ALUinput[2]);
mux_2_to_1(value[3],RAMout[3],instype,ALUinput[3]);
mux_2_to_1(value[4],RAMout[4],instype,ALUinput[4]);
mux_2_to_1(value[5],RAMout[5],instype,ALUinput[5]);
mux_2_to_1(value[6],RAMout[6],instype,ALUinput[6]);
mux_2_to_1(value[7],RAMout[7],instype,ALUinput[7]);

ALUacc(ALUinput,ACCout,op,cout,zout,nout,ovfout,ALUout);
ACC(ALUout,ex,clk,ACCout);


endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ALUacc(a,accIn,op,cout,zout,nout,ovfout,out);
input [7:0] a,accIn;
input [2:0] op;
output cout,zout,nout,ovfout;
output [7:0] out;
wire c1,c2,ovf1,ovf2;
wire [7:0] add,sub,andout,orout,mov, shl,shr;

adder(a,accIn,c1,ovf1,add);
subtractor(a,accIn,c2,ovf2,sub);
andGate(a,accIn,andout);
orGate(a,accIn,orout);
move(a,mov);
shftl(a,shl);
shftr(a,shr);

mux_8_to_1(add[0],sub[0],andout[0],orout[0],mov[0],shl[0],shr[0],x,op,out[0]);
mux_8_to_1(add[1],sub[1],andout[1],orout[1],mov[1],shl[1],shr[1],x,op,out[1]);
mux_8_to_1(add[2],sub[2],andout[2],orout[2],mov[2],shl[2],shr[2],x,op,out[2]);
mux_8_to_1(add[3],sub[3],andout[3],orout[3],mov[3],shl[3],shr[3],x,op,out[3]);
mux_8_to_1(add[4],sub[4],andout[4],orout[4],mov[4],shl[4],shr[4],x,op,out[4]);
mux_8_to_1(add[5],sub[5],andout[5],orout[5],mov[5],shl[5],shr[5],x,op,out[5]);
mux_8_to_1(add[6],sub[6],andout[6],orout[6],mov[6],shl[6],shr[6],x,op,out[6]);
mux_8_to_1(add[7],sub[7],andout[7],orout[7],mov[7],shl[7],shr[7],x,op,out[7]);

mux_2_to_1(c1,c2,op[0],cout);
mux_2_to_1(ovf1,ovf2,op[0],ovfout);
assign zout = ~(out[7] | out[6] | out[5] | out[4] | out[3] | out[2] | out[1] | out[0]);
assign nout = out[7];




endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ACC(in,ex,clk, out);
input ex,clk;
input [7:0] in;
output [7:0] out;
wire exe;

assign exe = ex & clk;

DFlipFlop(exe,in[0],out[0]);
DFlipFlop(exe,in[1],out[1]);
DFlipFlop(exe,in[2],out[2]);
DFlipFlop(exe,in[3],out[3]);
DFlipFlop(exe,in[4],out[4]);
DFlipFlop(exe,in[5],out[5]);
DFlipFlop(exe,in[6],out[6]);
DFlipFlop(exe,in[7],out[7]);

endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module DFlipFlop(clk,D,Q);
input D;
input clk;
output Q;
reg Q;
always @(posedge clk) 
begin
Q<=D;
end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module Debounce(clk,button,out);
input button;
input clk;
output out;
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29;
wire w30,w31,w32,w33,w34,w35,w36,w37,w38,w39,w40,w41,w42,w43,w44,w45,w46,w47,w48,w49;
DFlipFlop(clk,button,w1);
DFlipFlop(clk,w1,w2);
DFlipFlop(clk,w2,w3);
DFlipFlop(clk,w3,w4);
DFlipFlop(clk,w4,w5);
DFlipFlop(clk,w5,w6);
DFlipFlop(clk,w6,w7);
DFlipFlop(clk,w7,w8);
DFlipFlop(clk,w8,w9);
DFlipFlop(clk,w9,w10);
DFlipFlop(clk,w10,w11);
DFlipFlop(clk,w11,w12);
DFlipFlop(clk,w12,w13);
DFlipFlop(clk,w13,w14);
DFlipFlop(clk,w14,w15);
DFlipFlop(clk,w15,w16);
DFlipFlop(clk,w16,w17);
DFlipFlop(clk,w17,w18);
DFlipFlop(clk,w18,w19);
DFlipFlop(clk,w19,w20);
DFlipFlop(clk,w20,w21);
DFlipFlop(clk,w21,w22);
DFlipFlop(clk,w22,w23);
DFlipFlop(clk,w23,w24);
DFlipFlop(clk,w24,w25);
DFlipFlop(clk,w25,w26);
DFlipFlop(clk,w26,w27);
DFlipFlop(clk,w27,w28);
DFlipFlop(clk,w28,w29);
DFlipFlop(clk,w29,w30);
DFlipFlop(clk,w30,w31);
DFlipFlop(clk,w31,w32);
DFlipFlop(clk,w32,w33);
DFlipFlop(clk,w33,w34);
DFlipFlop(clk,w34,w35);
DFlipFlop(clk,w35,w36);
DFlipFlop(clk,w36,w37);
DFlipFlop(clk,w37,w38);
DFlipFlop(clk,w38,w39);
DFlipFlop(clk,w39,w40);
DFlipFlop(clk,w40,w41);
DFlipFlop(clk,w41,w42);
DFlipFlop(clk,w42,w43);
DFlipFlop(clk,w43,w44);
DFlipFlop(clk,w44,w45);
DFlipFlop(clk,w45,w46);
DFlipFlop(clk,w46,w47);
DFlipFlop(clk,w47,w48);
DFlipFlop(clk,w48,w49);
assign out=w39&w38& w37& w36& w35& w34& w33&w32&w31&w30&w49&w48& w47& w46& w45& w44& w43&w42&w11&w40&w29&w28& w27& w26& w25& w24& w23&w22&w21&w20&w19&w18& w17& w16& w15& w14& w13&w12&w11&w10& w9&w8& w7& w6& w5& w4& w3&w2&w1;

endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module adder(a,b,cout,ovfout,out);
input [7:0] a,b;
output cout,ovfout;
output [7:0] out;
wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30;
assign out[0] = a[0] ^ b[0];   
assign w1 = a[0] & b[0];  //cin 1
assign w2 = a[1] ^ b[1];
assign w3 = a[1] & b[1];
assign out[1] = w1 ^ w2; //add carry the new adding bit
assign w4 = w1 & w2;
assign w5 = w3 | w4; // new carry
assign w6 = a[2] ^ b[2]; 
assign w7 = a[2] & b[2];
assign out[2] = w5 ^ w6; 
assign w8 = w5 & w6;
assign w9 = w8 | w7; // new carry in w9
assign w10 = a[3] ^ b[3];
assign w11 = a[3] & b[3];
assign out[3] = w9 ^ w10;
assign w12 = w9 & w10;
assign w13 = w12 | w11; // new carry in w13
assign w14 = a[4] ^ b[4];
assign w15 = a[4] & b[4];
assign out[4] = w13 ^ w14;
assign w16 = w13 & w14;
assign w17 = w16 | w15; // cin w17
assign w18 = a[5] ^ b[5];
assign w19 = a[5] & b[5];
assign out[5] = w17 ^ w18;
assign w20 = w17 & w18;
assign w21 = w20 | w19; // cin w21
assign w22 = a[6] ^ b[6];
assign w23 = a[6] & b[6];
assign out[6] = w21 ^ w22;
assign w24 = w21 & w22;
assign w25 = w24 | w23; //cin w25
assign w26 = a[7] ^ b[7];
assign w27 = a[7] & b[7];
assign out[7] = w25 ^ w26;
assign w28 = w25 & w26;
assign cout = w28 | w27;
assign w29 = ~out[7] & (a[7] & b[7]);
assign w30 = out[7] & (~a[7] & ~b[7]);
assign ovfout = w29 | w30;
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module subtractor(a,b,cout,ovfout,out);
input [7:0] a;
input [7:0] b;
output cout,ovfout;
output[7:0] out;
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w29,w30,w31,w32,w33,w34,w35,w36,w37,w38;
wire w39,w40,w41,w42,w43,w44,w45,w46,w47,w48,w49,w50,w51,w52,w53,w54,w55,w56,w57,w58;
wire [7:0] ib;

assign ib[0] = 1'b1 ^ ~b[0];   
assign w1 = 1'b1 & ~b[0];  //cin 1
assign w2 = 1'b0 ^ ~b[1];
assign w3 = 1'b0 & ~b[1];
assign ib[1] = w1 ^ w2; //add carry the new adding bit
assign w4 = w1 & w2;
assign w5 = w3 | w4; // new carry
assign w6 = 1'b0 ^ ~b[2]; 
assign w7 = 1'b0 & ~b[2];
assign ib[2] = w5 ^ w6; 
assign w8 = w5 & w6;
assign w9 = w8 | w7; // new carry in w9
assign w10 = 1'b0 ^ ~b[3];
assign w11 = 1'b0 & ~b[3];
assign ib[3] = w9 ^ w10;
assign w12 = w9 & w10;
assign w13 = w12 | w11; // new carry in w13
assign w14 = 1'b0 ^ ~b[4];
assign w15 = 1'b0 & ~b[4];
assign ib[4] = w13 ^ w14;
assign w16 = w13 & w14;
assign w17 = w16 | w15; // cin w17
assign w18 = 1'b0 ^ ~b[5];
assign w19 = 1'b0 & ~b[5];
assign ib[5] = w17 ^ w18;
assign w20 = w17 & w18;
assign w21 = w20 | w19; // cin w21
assign w22 = 1'b0 ^ ~b[6];
assign w23 = 1'b0 & ~b[6];
assign ib[6] = w21 ^ w22;
assign w24 = w21 & w22;
assign w25 = w24 | w23; //cin w25
assign w26 = 1'b0 ^ ~b[7];
assign ib[7] = w25 ^ w26;

assign out[0] = a[0] ^ ib[0];   
assign w29 = a[0] & ib[0];  //cin 1
assign w30 = a[1] ^ ib[1];
assign w31 = a[1] & ib[1];
assign out[1] = w29 ^ w30; //add carry the new adding bit
assign w32 = w29 & w30;
assign w33 = w31 | w32; // new carry
assign w34 = a[2] ^ ib[2]; 
assign w35 = a[2] & ib[2];
assign out[2] = w33 ^ w34; 
assign w36 = w33 & w34;
assign w37 = w36 | w35; // new carry in w9
assign w38 = a[3] ^ ib[3];
assign w39 = a[3] & ib[3];
assign out[3] = w37 ^ w38;
assign w40 = w37 & w38;
assign w41 = w40 | w39; // new carry in w13
assign w42 = a[4] ^ ib[4];
assign w43 = a[4] & ib[4];
assign out[4] = w41 ^ w42;
assign w44 = w41 & w42;
assign w45 = w44 | w43; // cin w17
assign w46 = a[5] ^ ib[5];
assign w47 = a[5] & ib[5];
assign out[5] = w45 ^ w46;
assign w48 = w45 & w46;
assign w49 = w48 | w47; // cin w21
assign w50 = a[6] ^ ib[6];
assign w51 = a[6] & ib[6];
assign out[6] = w49 ^ w50;
assign w52 = w49 & w50;
assign w53 = w52 | w51; //cin w25
assign w54 = a[7] ^ ib[7];
assign w55 = a[7] & ib[7];
assign out[7] = w53 ^ w54;
assign w56 = w53 & w54;
assign cout = w56 | w55;
assign w57 = ~out[7] & (a[7] & ~ib[7]);
assign w58 = out[7] & (~a[7] & ib[7]);
assign ovfout = w57 | w58;
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module andGate(a,b,out);
input [7:0] a, b;
output [7:0] out;
assign out[0] = a[0] & b[0];
assign out[1] = a[1] & b[1];
assign out[2] = a[2] & b[2];
assign out[3] = a[3] & b[3];
assign out[4] = a[4] & b[4];
assign out[5] = a[5] & b[5];
assign out[6] = a[6] & b[6];
assign out[7] = a[7] & b[7];
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module orGate(a,b,out);
input [7:0] a, b;
output [7:0] out;
assign out[0] = a[0] | b[0];
assign out[1] = a[1] | b[1];
assign out[2] = a[2] | b[2];
assign out[3] = a[3] | b[3];
assign out[4] = a[4] | b[4];
assign out[5] = a[5] | b[5];
assign out[6] = a[6] | b[6];
assign out[7] = a[7] | b[7];
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module move(a,out);
input [7:0] a;
output [7:0] out;
assign out[0] = a[0];
assign out[1] = a[1];
assign out[2] = a[2];
assign out[3] = a[3];
assign out[4] = a[4];
assign out[5] = a[5];
assign out[6] = a[6];
assign out[7] = a[7];
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module shftl(in,out);
input [7:0] in;
output [7:0] out;
assign out[0] = 0;
assign out[1] = in[0];
assign out[2] = in[1];
assign out[3] = in[2];
assign out[4] = in[3];
assign out[5] = in[4];
assign out[6] = in[5];
assign out[7] = in[6];
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module shftr(in,out);
input [7:0] in;
output [7:0] out;
assign out[0] = in[1];
assign out[1] = in[2];
assign out[2] = in[3];
assign out[3] = in[4];
assign out[4] = in[5];
assign out[5] = in[6];
assign out[6] = in[7];
assign out[7] = 0;
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module mux_2_to_1(a,b,s,out);
input s,a,b;
output out;
wire w1,w2;
assign w1 = a & (~s);
assign w2 = b & s;
assign out = w1| w2;
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module mux_8_to_1(in0,in1,in2,in3,in4,in5,in6,in7,s,out);
input in0,in1,in2,in3,in4,in5,in6,in7; 
input [2:0] s;
output out;
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20;
assign w1 = in0 & ~s[0];
assign w2 = in1 & s[0];
assign w3 = in2 & ~s[0];
assign w4 = in3 & s[0];
assign w5 = in4 & ~s[0];
assign w6 = in5 & s[0];
assign w7 = in6 & ~s[0];
assign w8 = in7 & s[0];
assign w9 = w1 | w2;
assign w10 = w3 | w4;
assign w11 = w5 | w6;
assign w12 = w7 | w8;
assign w13 = w9 & ~s[1];
assign w14 = w10 & s[1];
assign w15 = w11 & ~s[1];
assign w16 = w12 & s[1];
assign w17 = w13 | w14;
assign w18 = w15 | w16;
assign w19 = w17 & ~s[2];
assign w20 = w18 & s[2];
assign out = w19 | w20;
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module ROMunit(adr,in0,in1,in2,in3,in4,in5,in6,in7,out);
input [2:0] adr;
wire s1,s2,s3,s4,s5,s6,s7,s8,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19;
wire w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32,w33,w34,w35,w36,w37,w38,w39,w40,w41,w42;
wire w43,w44,w45,w46,w47,w48,w49,w50,w51,w52,w53,w54,w55,w56,w57,w58,w59,w60,w61,w62,w63,w64,w65;
wire w66,w67,w68,w69,w70,w71,w72,w73,w74,w75,w76,w77,w78,w79,w80,w81,w82,w83,w84,w85,w86,w87,w88;
wire w89,w90,w91,w92,w93,w94,w95,w96;
input [11:0] in0,in1,in2,in3,in4,in5,in6,in7;
output [11:0] out;

assign s1 = ~adr[2] & ~adr[1] & ~adr[0];
assign s2 = ~adr[2] & ~adr[1] & adr[0];
assign s3 = ~adr[2] & adr[1] & ~adr[0];
assign s4 = ~adr[2] & adr[1] & adr[0];
assign s5 = adr[2] & ~adr[1] & ~adr[0];
assign s6 = adr[2] & ~adr[1] & adr[0];
assign s7 = adr[2] & adr[1] & ~adr[0];
assign s8 = adr[2] & adr[1] & adr[0];


assign w1 = s1 & in0[0];
assign w2 = s1 & in0[1];
assign w3 = s1 & in0[2];
assign w4 = s1 & in0[3];
assign w5 = s1 & in0[4];
assign w6 = s1 & in0[5];
assign w7 = s1 & in0[6];
assign w8 = s1 & in0[7];
assign w9 = s1 & in0[8];
assign w10 = s1 & in0[9];
assign w11 = s1 & in0[10];
assign w12 = s1 & in0[11];
assign w13 = s2 & in1[0];
assign w14 = s2 & in1[1];
assign w15 = s2 & in1[2];
assign w16 = s2 & in1[3];
assign w17 = s2 & in1[4];
assign w18 = s2 & in1[5];
assign w19 = s2 & in1[6];
assign w20 = s2 & in1[7];
assign w21 = s2 & in1[8];
assign w22 = s2 & in1[9];
assign w23 = s2 & in1[10];
assign w24 = s2 & in1[11];
assign w25 = s3 & in2[0];
assign w26 = s3 & in2[1];
assign w27 = s3 & in2[2];
assign w28 = s3 & in2[3];
assign w29 = s3 & in2[4];
assign w30 = s3 & in2[5];
assign w31 = s3 & in2[6];
assign w32 = s3 & in2[7];
assign w33 = s3 & in2[8];
assign w34 = s3 & in2[9];
assign w35 = s3 & in2[10];
assign w36 = s3 & in2[11];
assign w37 = s4 & in3[0];
assign w38 = s4 & in3[1];
assign w39 = s4 & in3[2];
assign w40 = s4 & in3[3];
assign w41 = s4 & in3[4];
assign w42 = s4 & in3[5];
assign w43 = s4 & in3[6];
assign w44 = s4 & in3[7];
assign w45 = s4 & in3[8];
assign w46 = s4 & in3[9];
assign w47 = s4 & in3[10];
assign w48 = s4 & in3[11];
assign w49 = s5 & in4[0];
assign w50 = s5 & in4[1];
assign w51 = s5 & in4[2];
assign w52 = s5 & in4[3];
assign w53 = s5 & in4[4];
assign w54 = s5 & in4[5];
assign w55 = s5 & in4[6];
assign w56 = s5 & in4[7];
assign w57 = s5 & in4[8];
assign w58 = s5 & in4[9];
assign w59 = s5 & in4[10];
assign w60 = s5 & in4[11];
assign w61 = s6 & in5[0];
assign w62 = s6 & in5[1];
assign w63 = s6 & in5[2];
assign w64 = s6 & in5[3];
assign w65 = s6 & in5[4];
assign w66 = s6 & in5[5];
assign w67 = s6 & in5[6];
assign w68 = s6 & in5[7];
assign w69 = s6 & in5[8];
assign w70 = s6 & in5[9];
assign w71 = s6 & in5[10];
assign w72 = s6 & in5[11];
assign w73 = s7 & in6[0];
assign w74 = s7 & in6[1];
assign w75 = s7 & in6[2];
assign w76 = s7 & in6[3];
assign w77 = s7 & in6[4];
assign w78 = s7 & in6[5];
assign w79 = s7 & in6[6];
assign w80 = s7 & in6[7];
assign w81 = s7 & in6[8];
assign w82 = s7 & in6[9];
assign w83 = s7 & in6[10];
assign w84 = s7 & in6[11];
assign w85 = s8 & in7[0];
assign w86 = s8 & in7[1];
assign w87 = s8 & in7[2];
assign w88 = s8 & in7[3];
assign w89 = s8 & in7[4];
assign w90 = s8 & in7[5];
assign w91 = s8 & in7[6];
assign w92 = s8 & in7[7];
assign w93 = s8 & in7[8];
assign w94 = s8 & in7[9];
assign w95 = s8 & in7[10];
assign w96 = s8 & in7[11];



assign out[0] = w1 | w13 | w25 | w37 | w49 | w61 | w73 | w85;
assign out[1] = w2 | w14 | w26 | w38 | w50 | w62 | w74 | w86;
assign out[2] = w3 | w15 | w27 | w39 | w51 | w63 | w75 | w87;
assign out[3] = w4 | w16 | w28 | w40 | w52 | w64 | w76 | w88;
assign out[4] = w5 | w17 | w29 | w41 | w53 | w65 | w77 | w89;
assign out[5] = w6 | w18 | w30 | w42 | w54 | w66 | w78 | w90;
assign out[6] = w7 | w19 | w31 | w43 | w55 | w67 | w79 | w91;
assign out[7] = w8 | w20 | w32 | w44 | w56 | w68 | w80 | w92;
assign out[8] = w9 | w21 | w33 | w45 | w57 | w69 | w81 | w93;
assign out[9] = w10 | w22 | w34 | w46 | w58 | w70 | w82 | w94;
assign out[10] = w11 | w23 | w35 | w47 | w59 | w71 | w83 | w95;
assign out[11] = w12 | w24 | w36 | w48 | w60 | w72 | w84 | w96;



endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module instructionReg(instr,clk,decode,op,value,instype);
input [11:0] instr;
input clk;
input decode;
output instype;
output [2:0] op;
output [7:0] value;
wire dec;

assign dec = decode & clk;

DFlipFlop(dec,instr[11],instype);
DFlipFlop(dec,instr[10],op[2]);
DFlipFlop(dec,instr[9],op[1]);
DFlipFlop(dec,instr[8],op[0]);
DFlipFlop(dec,instr[7],value[7]);
DFlipFlop(dec,instr[6],value[6]);
DFlipFlop(dec,instr[5],value[5]);
DFlipFlop(dec,instr[4],value[4]);
DFlipFlop(dec,instr[3],value[3]);
DFlipFlop(dec,instr[2],value[2]);
DFlipFlop(dec,instr[1],value[1]);
DFlipFlop(dec,instr[0],value[0]);

endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module programCounter(fetch,clk,reset,adr);
input fetch,clk,reset;
output reg [2:0] adr;
always @ (posedge clk)
if(reset)
begin
adr = 3'b000;
end
else
begin
if(fetch)
   begin
   adr <= adr + 1'b1;
   end
else
	begin
    adr <= 0;
    end
end
endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module RAMunit(a,rw,clk,in,out);
input [7:0] in;
input [1:0] a;
input rw,clk;
wire s1,s2,s3,s4,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32;
output [7:0] out;
assign s1 = ~a[0] & ~a[1];
assign s2 = a[0] & ~a[1];
assign s3 = ~a[0] & a[1];
assign s4 = a[0] & a[1];

binaryCell2(s1,rw,clk,in[0],w1);
binaryCell2(s1,rw,clk,in[1],w2);
binaryCell2(s1,rw,clk,in[2],w3);
binaryCell2(s1,rw,clk,in[3],w4);
binaryCell2(s1,rw,clk,in[4],w5);
binaryCell2(s1,rw,clk,in[5],w6);
binaryCell2(s1,rw,clk,in[6],w7);
binaryCell2(s1,rw,clk,in[7],w8);
binaryCell2(s2,rw,clk,in[0],w9);
binaryCell2(s2,rw,clk,in[1],w10);
binaryCell2(s2,rw,clk,in[2],w11);
binaryCell2(s2,rw,clk,in[3],w12);
binaryCell2(s2,rw,clk,in[4],w13);
binaryCell2(s2,rw,clk,in[5],w14);
binaryCell2(s2,rw,clk,in[6],w15);
binaryCell2(s2,rw,clk,in[7],w16);
binaryCell2(s3,rw,clk,in[0],w17);
binaryCell2(s3,rw,clk,in[1],w18);
binaryCell2(s3,rw,clk,in[2],w19);
binaryCell2(s3,rw,clk,in[3],w20);
binaryCell2(s3,rw,clk,in[4],w21);
binaryCell2(s3,rw,clk,in[5],w22);
binaryCell2(s3,rw,clk,in[6],w23);
binaryCell2(s3,rw,clk,in[7],w24);
binaryCell2(s4,rw,clk,in[0],w25);
binaryCell2(s4,rw,clk,in[1],w26);
binaryCell2(s4,rw,clk,in[2],w27);
binaryCell2(s4,rw,clk,in[3],w28);
binaryCell2(s4,rw,clk,in[4],w29);
binaryCell2(s4,rw,clk,in[5],w30);
binaryCell2(s4,rw,clk,in[6],w31);
binaryCell2(s4,rw,clk,in[7],w32);

assign out[0] = w1 | w9 | w17 | w25;
assign out[1] = w2 | w10 | w18 | w26;
assign out[2] = w3 | w11 | w19 | w27;
assign out[3] = w4 | w12 | w20 | w28;
assign out[4] = w5 | w13 | w21 | w29;
assign out[5] = w6 | w14 | w22 | w30;
assign out[6] = w7 | w15 | w23 | w31;
assign out[7] = w8 | w16 | w24 | w32;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module binaryCell2(s, rw, clk,in,out);
input s, rw,in,clk;
output out;
wire w1,w2,w3,w4,w5;
assign w1 = s & ~rw;
assign w2 = ~w1 & w5; //Q(w5) value comes from dff
assign w3 = w1 & in;
assign w4 = w2 | w3;
DFlipFlop(clk,w4,w5);
assign out = w5 & s & rw;
endmodule


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////























