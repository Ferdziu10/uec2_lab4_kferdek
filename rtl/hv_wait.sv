`timescale 1 ns / 1 ps

module hv_wait (
    vga_if.in vii, 
    vga_if.out vio,
    input  logic clk,
    input  logic rst
);

vga_if vga_nxt ();
vga_if vga_nxt_1 ();

always_ff @(posedge clk) begin 
    if (rst) begin
        //vga_nxt_1.rgb    <= '0;
        vga_nxt_1.vcount <= '0;
        vga_nxt_1.vsync  <= '0;
        vga_nxt_1.vblnk  <= '0;
        vga_nxt_1.hcount <= '0;
        vga_nxt_1.hsync  <= '0;
        vga_nxt_1.hblnk  <= '0;
    end else begin
        vga_nxt_1.vcount <= vii.vcount;
        vga_nxt_1.vsync  <= vii.vsync;
        vga_nxt_1.vblnk  <= vii.vblnk;
        vga_nxt_1.hcount <= vii.hcount;
        vga_nxt_1.hsync  <= vii.hsync;
        vga_nxt_1.hblnk  <= vii.hblnk;
        //vga_nxt_1.rgb    <= vii.rgb;
    end
end

always_ff @(posedge clk) begin 
    if (rst) begin
        //vga_nxt.rgb    <= '0;
        vga_nxt.vcount <= '0;
        vga_nxt.vsync  <= '0;
        vga_nxt.vblnk  <= '0;
        vga_nxt.hcount <= '0;
        vga_nxt.hsync  <= '0;
        vga_nxt.hblnk  <= '0;
    end else begin
        vga_nxt.vcount <= vga_nxt_1.vcount;
        vga_nxt.vsync  <= vga_nxt_1.vsync;
        vga_nxt.vblnk  <= vga_nxt_1.vblnk;
        vga_nxt.hcount <= vga_nxt_1.hcount;
        vga_nxt.hsync  <= vga_nxt_1.hsync;
        vga_nxt.hblnk  <= vga_nxt_1.hblnk;
        //vga_nxt.rgb    <= vga_nxt_1.rgb;
    end
end

always_ff @(posedge clk) begin 
    if (rst) begin
        vio.rgb    <= '0;
        vio.vcount <= '0;
        vio.vsync  <= '0;
        vio.vblnk  <= '0;
        vio.hcount <= '0;
        vio.hsync  <= '0;
        vio.hblnk  <= '0;
    end else begin
        vio.vcount <= vga_nxt.vcount;
        vio.vsync  <= vga_nxt.vsync;
        vio.vblnk  <= vga_nxt.vblnk;
        vio.hcount <= vga_nxt.hcount;
        vio.hsync  <= vga_nxt.hsync;
        vio.hblnk  <= vga_nxt.hblnk;
        vio.rgb    <= vii.rgb;
    end
end



endmodule