function FA = ObtenerFA(FP, aCM, masas)
% FA = ObtenerFA(FP, aCM, masas) calcula las Fuerzas de Reacción Articular
% (FA) en el tobillo, rodilla y cadera utilizando un método de
% Dinámica Inversa (bottom-up).
%
% La función aplica la 2da Ley de Newton (Sumatoria de Fuerzas = m * a)
% para cada segmento, despejando la fuerza proximal desconocida.
%
% Entradas:
%   FP    - Estructura con datos de la Plataforma de Fuerza (Fuerzas Externas).
%           Debe contener FP.P1 y FP.P2 con campos .Fx, .Fy, .Fz (N x 1).
%   aCM   - Estructura con la aceleración lineal (N x 3) del centro de masa
%           de cada segmento (ej. aCM.a_p_RFoot).
%   masas - Estructura con los valores escalares de la masa de cada
%           segmento en KILOGRAMOS (ej. masas.pieD).
%
% Salida:
%   FA    - Estructura con las fuerzas de reacción articular (proximales)
%           expresadas en NEWTONS en el sistema de coordenadas global.
%           FA.tobillo_D, FA.tobillo_I: Fuerza proximal del pie (N x 3).
%           FA.rodilla_D, FA.rodilla_I: Fuerza proximal de la pierna (N x 3).
%           FA.cadera_D,  FA.cadera_I:  Fuerza proximal del muslo (N x 3).
%

	fuerza_externa_d = [FP.P2.Fx, FP.P2.Fy, FP.P2.Fz];
    fuerza_externa_i = [FP.P1.Fx, FP.P1.Fy, FP.P1.Fz];

    FA.tobillo_D = calcular_fuerza_proximal(masas.pieD, aCM.a_p_RFoot, zeros(533,3), fuerza_externa_d);
    FA.tobillo_I = calcular_fuerza_proximal(masas.pieI, aCM.a_p_LFoot, zeros(533,3), fuerza_externa_i);

    FA.rodilla_D = calcular_fuerza_proximal(masas.piernaD, aCM.a_p_RCalf, -FA.tobillo_D, zeros(533,3));
    FA.rodilla_I = calcular_fuerza_proximal(masas.piernaI, aCM.a_p_LCalf, -FA.tobillo_I, zeros(533,3));

    FA.cadera_D = calcular_fuerza_proximal(masas.musloD, aCM.a_p_RThigh, -FA.rodilla_D, zeros(533,3));
    FA.cadera_I = calcular_fuerza_proximal(masas.musloI, aCM.a_p_LThigh, -FA.rodilla_I, zeros(533,3));
end

function f_proximal = calcular_fuerza_proximal(masa_seg, a_seg, f_distal, f_externa)

a_gravedad = zeros(533,3);
a_gravedad(:,3) = -9.8;

f_proximal = masa_seg * a_seg - f_distal - f_externa - masa_seg * a_gravedad;
end