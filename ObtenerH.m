function H = ObtenerH(I, VA)

    %Miembro Derecho
    H.musloD = (I.muslo * VA.musloD')';
    H.piernaD = (I.pierna * VA.piernaD')';
    H.pieD = (I.pie * VA.pieD')';

    %Miembro Izquierdo
    H.musloI = (I.muslo * VA.musloI')';
    H.piernaI = (I.pierna * VA.piernaI')';
    H.pieI = (I.pie * VA.pieI')';
    
end