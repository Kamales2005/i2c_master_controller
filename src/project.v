`default_nettype none

module tt_um_kamales_i2c_master (
      input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

reg busy;
reg done;
reg ack;

assign uo_out = {5'b00000, ack, done, busy};

assign uio_out = 8'b0;
assign uio_oe  = 8'b0;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        busy <= 0;
        done <= 0;
        ack  <= 0;
    end
    else begin
        if (ui_in[7]) begin
            busy <= 1;
            done <= 0;
            ack  <= 0;
        end
        else begin
            busy <= 0;
            done <= 1;
            ack  <= 1;
        end
    end
end

endmodule
