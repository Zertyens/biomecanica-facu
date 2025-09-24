function CM = ObtenerCM(mar, CA)
CM.p_RThigh = CA.p_RHip + 0.39*(CA.p_RKnee - CA.p_RHip);
CM.p_LThigh = CA.p_LHip + 0.39*(CA.p_LKnee - CA.p_LHip);
CM.p_RCalf = CA.p_RKnee + 0.42*(CA.p_RAnkle - CA.p_RKnee);
CM.p_LCalf = CA.p_LKnee + 0.42*(CA.p_LAnkle - CA.p_LKnee);
CM.p_RFoot = mar.p2 + 0.44*(CA.p_RToe - mar.p2);
CM.p_LFoot = mar.p9+ 0.44*(CA.p_LToe - mar.p9);

end
