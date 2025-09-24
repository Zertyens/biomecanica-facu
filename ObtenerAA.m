function AA = ObtenerAA(SL)
    %% CADERA
    % Vectores de articulación
    I_R_HJC = normalize(cross(SL.k_pelv, SL.i1, 2), 2, 'norm');
    I_L_HJC = normalize(cross(SL.k_pelv, SL.i2, 2), 2, 'norm');

    % Cálculo del ángulo flexión-extensión
    signo = normalize(dot(I_R_HJC, SL.i_pelv, 2), 2, 'norm');
    AA.a_R_HJC = acosd(dot(I_R_HJC, SL.j_pelv, 2)).*signo;
    signo = normalize(dot(I_L_HJC, SL.i_pelv, 2), 2, 'norm');
    AA.a_L_HJC = acosd(dot(I_L_HJC, SL.j_pelv, 2)).*signo;

    % Cálculo del ángulo abducción-aducción
    AA.b_R_HJC = asind(dot(SL.k_pelv, SL.i1, 2));
    AA.b_L_HJC = -asind(dot(SL.k_pelv, SL.i2, 2));

    % Cálculo del ángulo rotación interna/externa
    signo = normalize(dot(I_R_HJC, SL.k1, 2), 2, 'norm');
    AA.g_R_HJC = -acosd(dot(I_R_HJC, SL.j1, 2)).*signo;
    signo = normalize(dot(I_L_HJC, SL.k2, 2), 2, 'norm');
    AA.g_L_HJC = acosd(dot(I_L_HJC, SL.j2, 2)).*signo;


    %% RODILLA
    % Vectores para flexión-extensión de rodillas
    I_R_KJC = normalize(cross(SL.k1, SL.i3, 2), 2, 'norm');
    I_L_KJC = normalize(cross(SL.k2, SL.i4, 2), 2, 'norm');

    % Cálculo del ángulo α (flexión-extensión)
    signo = normalize(dot(I_R_KJC, SL.i1, 2), 2, 'norm');
    AA.a_R_KJC = -acosd(dot(I_R_KJC, SL.j1, 2)).*signo;
    signo = normalize(dot(I_L_KJC, SL.i2, 2), 2, 'norm');
    AA.a_L_KJC = -acosd(dot(I_L_KJC, SL.j2, 2)).*signo;

    % Cálculo del ángulo β (abducción-aducción)
    AA.b_R_KJC = asind(dot(SL.k1, SL.i3, 2));
    AA.b_L_KJC = -asind(dot(SL.k2, SL.i4, 2));

    % Cálculo del ángulo γ (rotación interna/externa)
    signo = normalize(dot(I_R_KJC, SL.k3, 2), 2, 'norm');
    AA.g_R_KJC = -acosd(dot(I_R_KJC, SL.j3, 2)).*signo;
    signo = normalize(dot(I_L_KJC, SL.k4, 2), 2, 'norm');
    AA.g_L_KJC = acosd(dot(I_L_KJC, SL.j4, 2)).*signo;

    %% TOBILLO
    % Vectores para flexión-extensión de tobillos
    I_R_AJC = normalize(cross(SL.k3, SL.i5, 2), 2, 'norm');
    I_L_AJC = normalize(cross(SL.k4, SL.i6, 2), 2, 'norm');

    % Cálculo del ángulo α (dorsiflexión/plantarflexión)
    signo = normalize(dot(I_R_AJC, SL.j3, 2), 2, 'norm');
    AA.a_R_AJC = -acosd(dot(I_R_AJC, SL.i3, 2)).*signo;
    signo = normalize(dot(I_L_AJC, SL.j4, 2), 2, 'norm');
    AA.a_L_AJC = -acosd(dot(I_L_AJC, SL.i4, 2)).*signo;

    % Cálculo del ángulo β (abducción/aducción)
    AA.b_R_AJC = asind(dot(SL.k3, SL.i5, 2));
    AA.b_L_AJC = -asind(dot(SL.k4, SL.i6, 2));

    % Cálculo del ángulo γ (inversión/eversión)
    signo = normalize(dot(I_R_AJC, SL.k5, 2), 2, 'norm');
    AA.g_R_AJC = acosd(dot(I_R_AJC, SL.j5, 2)).*signo;
    signo = normalize(dot(I_R_AJC, SL.k6, 2), 2, 'norm');
    AA.g_L_AJC = -acosd(dot(I_L_AJC, SL.j6, 2)).*signo;