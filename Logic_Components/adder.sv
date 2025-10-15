module adder #(parameter WIDTH = 32)(
    input a,
    input b,
    output out
);

logic [WIDTH-1:0] a, b, out;

always_comb out = a + b;

endmodule
