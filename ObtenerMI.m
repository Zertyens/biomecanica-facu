function I = ObtenerMI(peso, alt)
    % Obtener Ijj - EJE ANTERO-POSTERIOR (PERPENDICULAR AL PLANO FRONTAL)
    coefJ = [
    -100     0.480   0.626;    % Pie
    -1105    4.59    6.63;     % Pierna
    -3557    31.7    18.61     % Muslo
    ];

    Ijj = coefJ * [1; peso; alt];
    
    % Obtener Ikk - EJE MEDIAL-LATERAL (PERPENDICULAR AL PLANO SAGITAL)
    coefK = [
    -97.09 0.414 0.614;   % Pie
    -1152  4.594 6.815;   % Pierna
    -3690  32.02 19.24    % Muslo
    ];

    Ikk = coefK * [1; peso; alt];
    
    % Obtener Iii - Eje longitudinal
    coefI = [
    -15.48 0.144 0.088;   % Pie
    -70.5  1.134 0.3 ;   % Pierna
    -13.5  11.3  -2.28   % Muslo
    ];

    Iii = coefI * [1; peso; alt];
    
    %% Matrices de inercia
    I.pie = [
    Iii(1) 0 0; 
    0 Ijj(1) 0;  
    0 0 Ikk(1)
    ] / 100^2;

    I.pierna = [
    Iii(2) 0 0; 
    0 Ijj(2) 0;  
    0 0 Ikk(2)
    ] / 100^2;

    I.muslo = [
    Iii(3) 0 0; 
    0 Ijj(3) 0;  
    0 0 Ikk(3)
    ] / 100^2;
end