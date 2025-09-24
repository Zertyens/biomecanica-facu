function VA = ObtenerVA(alpha, beta, gamma)
    %% Calculo de las derivadas
    wa = diff([alpha; alpha(end)])*340;
    wb = diff([beta; beta(end)])*340;
    wg = diff([gamma; gamma(end)])*340;

    %% Calculo de la velocidad
    VA.wx = wa .* sind(beta) .* sind(gamma) + wb .* cosd(gamma);
    VA.wy = wa .* sind(beta) .* cosd(gamma) - wb .* sind(gamma);
    VA.wz = wa .* cosd(beta) + wg;
    
end 