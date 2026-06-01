`default_nettype none

module tt_um_kamales_i2c_master (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    reg [7:0] data_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_reg <= 8'h00;
        else
            data_reg <= ui_in;
    end

    assign uo_out  = data_reg;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, uio_in, 1'b0};

endmodule
