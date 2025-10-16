module TermProject
(
   input enter, clear, clock, 
	input add, sub, mult, div,
	//input Start, Done,
	//input [1:0] OP,
	input [3:0] row,
	output[3:0] col,
	output [1:0] CCout, // CCout for lighting LEDs for ZERO and OVR conditions
	output [7:0] debug,
	output [3:0] CAT,
	output [0:6] SEG
);

   assign debug = Dividend[15:8];

   wire reset, LoadA, LoadB, LoadR, IUAU, AddSub, Sub;
	
	wire LoadAH, LoadAL, add1, sub1, mult1, div1;
	
	wire [3:0] Output;
	
	wire [1:0] sel;

   wire clk, Start, Done, Done1, clk2, clk3, clock1;
	
	wire [1:0] Op;
	
	wire [15:0] Rout, SW;
	
	wire [15:0] wire1;
	
	reg [7:0] cycle;
	
	reg [15:0] Product;
	
	reg [7:0] Multiplicand, Multiplier;
	
	reg [7:0] RegQ;
	  //reg [8:0] RegA;
	  reg [16:0] RegA, RegM;
	  reg [2:0] Count;
	  wire C0, Start1, Add, Shift;
	  int i;
	  
	  assign Product = {RegA[7:0],RegQ};
	  
	  // 3-bit counter for # iterations
	  always @ (posedge clk2)
	      if (Start1 == 1) Count <= 3'b000;
			else if (Shift == 1) Count <= Count + 1;
			
	  assign C0 = Count[2] & Count[1] & Count[0];
	  // Multiplicand register (load only)
	  always @ (posedge clk2)
	        if (Start1 == 1) //RegM <= Multiplicand;
			  begin 
			        for (i = 7; i <= 15; i = i + 1) RegM[i] <= Multiplicand[7];
					  for (i = 0; i <= 6; i = i + 1)  RegM[i] <= Multiplicand[i];
			  end 
	  // Multiplier register (load, shift)
	  always @ (posedge clk2)
	      if (Start1 == 1) RegQ <= Multiplier;
			else if (Shift == 1) RegQ <= {RegA[0],RegQ[7:1]};
	  // Accumulate register (clear, load, shift)
	  always @ (posedge clk2)
	      if (Start1 == 1)  RegA <= 16'b000000000;
			else if (Add == 1 && Count == 7) RegA <= RegA - RegM;
			          else if (Add == 1 && Count != 7) RegA <= RegA + RegM; 
			else if (Shift == 1) RegA <= RegA >>> 1; 
		always @ (posedge clk2, posedge reset)
		     if(reset == 1) Done1 = 1'b0; else if (Halt == 1) Done1 = 1'b1;
			       else Done1 = 1'b0;
	  // Instantiate controller module
	  MultControl Ctrl (clk2,~reset,RegQ[0],C0,Start1,Add,Shift,Halt);
	
	wire [8:0] alu_out;
	wire alu_cy;
	wire [8:0] mux_out;
	wire [8:0] mux_in;
	wire [8:0] R_out;
	wire [7:0] Q_out;
	wire [7:0] D_out;
	reg [15:0] Dividend, R3;
	reg [7:0] Divisor, Quotient, Remainder;
	wire Rload;
	wire Qload;
	wire Dload;
	wire Rshift;
	wire Qshift;
	wire AddSub1;
	wire Qbit;
	assign Remainder = R_out[7:0];
	assign mux_in = {1'b0, Dividend[15:8]};
	assign Quotient = Q_out;
	mux    #(9) Mux1 (alu_out,mux_in,mux_out,Qload);
	shiftreg #(9) Rreg (mux_out,R_out,clock,Rload,Rshift,Q_out[7]);
	shiftreg #(8) Qreg (Dividend[7:0],Q_out,clock,Qload,Qshift,Qbit);
	shiftreg #(8) Dreg (Divisor,D_out,clock,Dload,1'b0,1'b0);
	alu     #(8) AdSb (R_out,D_out,alu_out,AddSub1);
	dcontrol DivCtrl (clock,Start,alu_out[8],AddSub1,Dload,Rload,Qload,Rshift,Qshift,Done,Qbit);
	
	
	ClockDivider #(2500000, 32) ClockDivider_inst
	(
	   .CLK(clock),
		.CLEAR(clear),
		.OUT(clk)
	);
	/*
	FiveHz FiveHzClock_inst
	(
	   .clock(clock),
		.reset(reset),
		.FiveHz(clk3)
	);*/
	OnOffToggle OnOff
   (
     .OnOff(Start) , // input OnOff_sig
     .IN(clock) , // input IN_sig
     .OUT(clock1) // output OUT_sig
   );
   //Instantiate 5Hz clock
   FiveHz FiveHz_clock
   (
     .clock(clock1) , // input clock_sig
     .reset(~reset) , // input reset_sig
     .FiveHz(clk2) // output FiveHz_sig
   );
	
	NBitRegister #(1) NBitRegisterAdd_inst
	(
	   .D(add),
		.CLK(clock),
		.CLR(clear),
		.Q(add1)
	);
	
	NBitRegister #(1) NBitRegisterSub_inst
	(
	   .D(sub),
		.CLK(clock),
		.CLR(clear),
		.Q(sub1)
	);
	
	NBitRegister #(1) NBitRegisterMult_inst
	(
	   .D(mult),
		.CLK(clock),
		.CLR(clear),
		.Q(mult1)
	);
	
	NBitRegister #(1) NBitRegisterDiv_inst
	(
	   .D(div),
		.CLK(clock),
		.CLR(clear),
		.Q(div1)
	);
	
	ControlUnit ControlUnit_inst
	(
	   .clock(clk),
		.clear(clear),
		.enter(enter),
		.add(add1),
		.sub(sub1),
		.mult(mult1),
		.div(div1),
		.Op(Op),
		.reset(reset),
		//.LoadA(LoadA),
		.LoadAH(LoadAH),
		.LoadAL(LoadAL),
		.LoadB(LoadB),
		.Start(Start),
		.LoadR(LoadR),
		.AddSub(AddSub),
		//.Sub(Sub),
		.IUAU(IUAU),
		.Done(Done|Halt)
	);
	   
				
   InputUnit InputUnit_inst
	(
	   .clk(clock),
		.reset(~reset),
		.row(row),
		.col(col),
		.out(wire1)
	);
	
	wire zero, ovr, Halt;

   reg [7:0] AoutH, AoutL, Bout, B1;
	
	wire [15:0] R, R1, R2, Result, Aout, Pro;
	
	NBitRegister #(8) NBitRegister_AHigh
	(
	   .D(wire1[15:8]),
		.CLK(LoadAH),
		.CLR(~reset),
		.Q(AoutH)
	);
	
	NBitRegister #(8) NBitRegister_ALow
	(
	   .D(wire1[7:0]),
		.CLK(LoadAL),
		.CLR(~reset),
		.Q(AoutL)
	);
	
	/*
	NBitRegister #(16) NBitRegister_A
	(
	   .D(wire1),
		.CLK(LoadA),
		.CLR(reset),
		.Q(Aout)
	);*/
	
	assign Multiplicand = AoutL;
	
	assign Dividend = {AoutH, AoutL};
	
	/*assign Multiplicand = Aout[7:0];
	
	assign Dividend = Aout;
	
	assign AoutL = Aout[7:0];*/
	
	NBitRegister #(8) NBitRegister_B
	(
	   .D(wire1[7:0]),
		.CLK(LoadB),
		.CLR(~reset),
		.Q(Bout)
	);
	
	assign Multiplier = Bout;
	
	//assign Dividend = {AoutH, AoutL};
	
	assign Divisor = Bout;
	
	ArithmeticUnit ArithmeticUnit_inst
	(
	   .Clock(clock),
		.Reset(~reset),
		//.LoadA(LoadA),
	   .LoadAH(LoadAH),
		.LoadAL(LoadAL),
		.LoadB(LoadB),
		.LoadR(LoadR),
		.AddSub(AddSub),
		//.Sub(Sub),
		//.add(add),
		//.sub(sub),
		//.mult(mult),
		//.div(div),
		//.Start(Start),
		//.Op(Op),
		//.register(wire1),
		//.A(AoutL),
		.A(AoutL),
		.B(Bout),
		//.R2(R2),
		//.R3(R3),
		.Rout(R),
		.ZERO(CCout[0]),
		.OVR(CCout[1]),
		//.Done(Done)
	);
	
	assign R3 = {Quotient, Remainder};
	
	reg [15:0] Out, Quo, Answer;
	
	ClockDivider #(262144, 32) ClockDivider1_inst
	(
	   .CLK(clock),
		.CLEAR(~reset),
		.OUT(clk1)
	);
	/*
	NBitRegister #(16) NBitRegisterPro_inst
	(
	   .D(Pro),
		.CLK(~LoadAL|~LoadB|Done1),
		.CLR(reset),
		.Q(R2)
	);*/
	
	NBitRegister #(16) NBitRegisterPro_inst
	(
	   .D(Pro),
		.CLK(~LoadAL|~LoadB|Done1),
		.CLR(~reset),
		.Q(R2)
	);
	
	two2one #(16) two2one_inst
	(
	   .A({Multiplicand, Multiplier}),
		.B(Product),
		.S(Halt),
		.Y(Pro)
	);
	/*
	NBitRegister #(16) NBitRegisterQuo_inst
	(
	   .D(R3),
		.CLK(~LoadAL|~LoadB|Done),
		.CLR(reset),
		.Q(Quo)
	);*/
	
	register R0
	(
	   .CLK(clock),
		.RST(reset),
		.CE(1'b1),
		.M(2'b11),
		.D(R3[3:0]),
		.Q(Quo[3:0])
	);
	
	register R4
	(
	   .CLK(clock),
		.RST(reset),
		.CE(1'b1),
		.M(2'b11),
		.D(R3[7:4]),
		.Q(Quo[7:4])
	);
	
	register R5
	(
	   .CLK(clock),
		.RST(reset),
		.CE(1'b1),
		.M(2'b11),
		.D(R3[11:8]),
		.Q(Quo[11:8])
	);
	
	register R6
	(
	   .CLK(clock),
		.RST(reset),
		.CE(1'b1),
		.M(2'b11),
		.D(R3[15:12]),
		.Q(Quo[15:12])
	);
	/*
	NBitRegister #(16) LoadPro_inst
	(
	   .D(Out),
		.CLK(~LoadAL|~LoadB|Done),
		.CLR(reset),
		.Q(R2)
	);*/
	
	// Handled in Control Unit to select which result to display based on operation selected
	four2one #(16) four2one_inst
	(
	   .A(Op[0]),
		.B(Op[1]),
		.D0(R),
		.D1(R2),
		.D2(Quo),
		//.D3(R3),
		.Y(Rout)
	);
	/*
	NBitRegister #(16) LoadResult_inst
	(
	   .D(Answer),
		.CLK(LoadR),
		.CLR(~reset),
		.Q(Rout)
	);*/
	
	two2one #(16) two2one1_inst
	(
	   .A(wire1),
		.B(Rout),
		.S(IUAU),
		.Y(SW)
	);
	
	OutputUnit OutputUnit_inst
	(
	   .clock(clock),
		.reset(~reset),
		.SW(SW),
		.CAT(CAT),
		.SEG(SEG)
	);
	
endmodule	
	