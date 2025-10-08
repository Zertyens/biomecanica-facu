function I = ObtenerMI(peso, alt)
    % Obtener Ijj
    coefJ = [
    -0.829  0.0077  0.0073;   % Pie
    -1.592  0.0362  0.0121;   % Pierna
     2.649  0.1463  0.0137    % Muslo
    ];

    Ijj = coefJ * [1; peso; alt];
    
    % Obtener Ikk
    coefK = [
    -97.09 0.414 0.614;   % Pie
    -1152 4.594 6.815;   % Pierna
    -3690 32.02 19.24    % Muslo
    ];

    Ikk = coefK * [1; peso; alt];
    
    % Obtener Iii
    coefI = [
    -15.48 0.144 0.088;   % Pie
    -70.5 1.134 0.3 ;   % Pierna
    -13.5 11.3 -2.28    % Muslo
    ];

    Iii = coefI * [1; peso; alt];
    
    %% Matrices de inercia
    I.IPie = [
    Iii(1) 0 0; 
    0 Ijj(1) 0;   
    0 0 Ikk(1)
    ] / 100^2;

    I.IPierna = [
    Iii(2) 0 0; 
    0 Ijj(2) 0;   
    0 0 Ikk(2)
    ] / 100^2;

    I.IMuslo = [
    Iii(3) 0 0; 
    0 Ijj(3) 0;   
    0 0 Ikk(3)
    ] / 100^2;
end