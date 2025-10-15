`include "adder.sv"

module adder_tb #(parameter WIDTH = 32)();
    
    logic [WIDTH-1:0] a1, b1, out1;
    logic [7:0] a2, b2, out2;

    int finish, error;

    adder adder1 (
        .a(a1),
        .b(b1),
        .out(out1)
    );

    adder adder2 #(.WIDTH(8))(
        .a(a2),
        .b(b2),
        .out(out2)
    );

    //Initial values configuration
    initial begin
        a1   = 0;
        b1   = 0;
        a2   = 0;
        b2   = 0;
        error  = 0;
        finish = 0;

    end
  
    //Task to simulate the adder. It runs two tasks: one for stimulus and another for self-checking
    task adder_sim();
        
        fork
            stimulus();
            selfcheck();
        join

    endtask
  
    //Stimulus Task
    task stimulus();
        // Dump waves
        /*$dumpfile("dump.vcd");
        $dumpvars(0);*/
        
        for(int i=0; i<100;i++) begin
            #100
            a1   = a1 + 1;//$urandom_range(0,10);
            b1   = b1 + 4;//std::randomize(B);
            a2   = a2 + 4;//$urandom_range(0,10);
            b2   = b2 + 1;//std::randomize(B);
        end

        #100
        a1   = 0;
        b1   = 0;
        a2   = 0;
        b2   = 0;
        
        finish = 1;
    endtask
  
    //Self-check Task
    task selfcheck();
        
        int sum1, sum2;
        
        forever begin //It verifies the output every 5 time units
            @(negedge clk);
            sum1 = a1 + b1;
            sum2 = a2 + b2;
            if (sum1 != out1) error = 1;
            if (sum2 != out2) error = 1;
            if (error == 1) $display("[ADDER TB] ADDER has a bug!!!");
        end
        
    endtask

endmodule