module single_clock_be_sdp_bram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 16,

    parameter DATA_BYTES = DATA_WIDTH / 8
) (
    input clk_i,

    input  logic [ADDR_WIDTH-1:0] waddr, raddr,
    input  logic [DATA_WIDTH-1:0] wdata,
    input  logic [DATA_BYTES-1:0] be,
    input  logic                  we,
    output logic [DATA_WIDTH-1:0] rdata
);

    logic [DATA_BYTES-1:0][7:0] ram [2**ADDR_WIDTH];

    always @( posedge clk_i ) begin : ram_a
        if(we) begin
            if (DATA_BYTES>0) if (be[0]) ram[waddr][0] <= wdata[8*0 +: 8];
            if (DATA_BYTES>1) if (be[1]) ram[waddr][1] <= wdata[8*1 +: 8];
            if (DATA_BYTES>2) if (be[2]) ram[waddr][2] <= wdata[8*2 +: 8];
            if (DATA_BYTES>3) if (be[3]) ram[waddr][3] <= wdata[8*3 +: 8];
            if (DATA_BYTES>4) if (be[4]) ram[waddr][4] <= wdata[8*4 +: 8];
            if (DATA_BYTES>5) if (be[5]) ram[waddr][5] <= wdata[8*5 +: 8];
            if (DATA_BYTES>6) if (be[6]) ram[waddr][6] <= wdata[8*6 +: 8];
            if (DATA_BYTES>7) if (be[7]) ram[waddr][7] <= wdata[8*7 +: 8];
        end
        rdata <= ram[raddr];
    end

endmodule