function SL = ObtenerSL(mar, CA)
    %% Muslo D
    SL.i1 = normalize((CA.p_RHip - CA.p_RKnee), 2, 'norm');
    SL.j1 = normalize(cross((mar.p6 - CA.p_RHip), (CA.p_RKnee - CA.p_RHip), 2), 2, 'norm');
    SL.k1 = cross(SL.i1, SL.j1, 2);

    %% Muslo I
    SL.i2 = normalize((CA.p_LHip - CA.p_LKnee), 2, 'norm');
    SL.j2 = normalize(cross((CA.p_LKnee - CA.p_LHip), (mar.p13 - CA.p_LHip), 2), 2, 'norm');
    SL.k2 = cross(SL.i2, SL.j2, 2);

    %% Pierna D
    SL.i3 = normalize((CA.p_RKnee - CA.p_RAnkle), 2, 'norm');
    SL.j3 = normalize(cross((mar.p5 - CA.p_RKnee), (CA.p_RAnkle - CA.p_RKnee), 2), 2, 'norm');
    SL.k3 = cross(SL.i3, SL.j3, 2);
    
    %% Pierna I
    SL.i4 = normalize((CA.p_LKnee - CA.p_LAnkle), 2, 'norm');
    SL.j4 = normalize(cross((CA.p_LAnkle - CA.p_LKnee), (mar.p12 - CA.p_LKnee), 2), 2, 'norm');
    SL.k4 = cross(SL.i4, SL.j4, 2);
    
    %% Pie D
    SL.i5 = normalize((mar.p2 - CA.p_RToe), 2, 'norm');
    SL.k5 = normalize(cross((CA.p_RAnkle - mar.p2), (CA.p_RToe - mar.p2), 2), 2, 'norm');
    SL.j5 = cross(SL.k5, SL.i5, 2);
    
    %% Pie I
    SL.i6 = normalize((mar.p9 - CA.p_LToe), 2, 'norm');
    SL.k6 = normalize(cross((CA.p_LAnkle - mar.p9), (CA.p_LToe - mar.p9), 2), 2, 'norm');
    SL.j6 = cross(SL.k6, SL.i6, 2);
end
