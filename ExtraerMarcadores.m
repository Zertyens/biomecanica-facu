function mar = ExtraerMarcadores(Valores)
    % Extract marker position data from Datos structure
    % Assuming data is available in workspace
    
    mar.p1 = Valores.r_met;  % Right metatarsal head II
    mar.p2 = Valores.r_heel; % Right heel
    mar.p3 = Valores.r_mall; % Right lateral malleolus
    mar.p4 = Valores.r_bar_2; % Right tibial wand
    mar.p5 = Valores.r_knee_1; % Right femoral epicondyle
    mar.p6 = Valores.r_bar_1; % Right femoral wand
    mar.p7 = Valores.r_asis; % Right ASIS
    mar.p8 = Valores.l_met;  % Left metatarsal head II
    mar.p9 = Valores.l_heel; % Left heel
    mar.p10 = Valores.l_mall; % Left lateral malleolus
    mar.p11 = Valores.l_bar_2; % Left tibial wand
    mar.p12 = Valores.l_knee_1; % Left femoral epicondyle
    mar.p13 = Valores.l_bar_1; % Left femoral wand
    mar.p14 = Valores.l_asis; % Left ASIS
    mar.p15 = Valores.sacrum; % Sacrum
end