function FA = ObtenerFA(FP, aCM, masas)
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

f_proximal = masa_seg * a_seg - f_distal - f_externa;
end