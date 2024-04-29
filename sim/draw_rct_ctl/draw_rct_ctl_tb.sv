`timescale 1ns / 1ps

module draw_rct_ctl_tb;

    // Parametry symulacji
    parameter CLK_PERIOD = 25; // okres zegara w ps

    // Sygnały wejściowe
    logic clk = 0;
    logic rst = 1;
    logic mouse_left = 0;
    logic mouse_right = 0;
    logic [11:0] mouse_xpos = 0;
    logic [11:0] mouse_ypos = 0;

    // Sygnały wyjściowe
    logic [11:0] xpos;
    logic [11:0] ypos;

    // Instancja modułu
    draw_rct_ctl dut (
        .clk(clk),
        .rst(rst),
        .mouse_right(mouse_right),
        .mouse_left(mouse_left),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .xpos(xpos),
        .ypos(ypos)
    );

    // Generowanie zegara
    always #(CLK_PERIOD/2) clk =~clk;

    // Symulacja
    initial begin
        // Włączamy reset
        rst = 1;
        #20;

        // Resetujemy pozycję myszy
        mouse_xpos = 0;
        mouse_ypos = 0;
        #20;

        // Wyłączamy reset
        rst = 0;
        #20;

        // Pozycja myszy na górze ekranu, przycisk nie jest wciśnięty
        mouse_ypos = 0;
        mouse_left = 0;
        #50;

        // Wciśnięcie przycisku myszy
        mouse_left = 1;
        #50;

        mouse_left = 0;
        #50;

        // Czas na obserwację zmian po wciśnięciu przycisku myszy
        #13500;

        /*mouse_right = 1;
        #50;
        #200;
        mouse_right = 0;
        #500;
        mouse_left = 1;
        #50;

        mouse_left = 0;
        #50;
        #300;
*/

        // Zakończenie symulacji
        $finish;
    end

endmodule
