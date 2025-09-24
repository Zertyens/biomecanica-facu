function ant = ExtraerAntropometria(Datos)
    
    ant.A1 = Datos.antropometria.PESO;
    ant.A2 = Datos.antropometria.LONGITUD_ASIS.Valor / 100; 
    ant.A3 = Datos.antropometria.LONGITUD_PIERNA_DERECHA.Valor / 100;  
    ant.A4 = Datos.antropometria.LONGITUD_PIERNA_IZQUIERDA.Valor / 100; 
    ant.A5 = Datos.antropometria.PROFUNDIDAD_PELVIS.Valor / 100;  
    ant.A6 = Datos.antropometria.PROFUNDIDAD_PELVIS.Valor / 100;  
    ant.A7 = Datos.antropometria.LONGITUD_PIE_DERECHO.Valor / 100;  
    ant.A8 = Datos.antropometria.LONGITUD_PIE_IZQUIERDO.Valor / 100;  
    ant.A9 = Datos.antropometria.DIAMETRO_RODILLA_DERECHA.Valor / 100;  
    ant.A10 = Datos.antropometria.DIAMETRO_RODILLA_IZQUIERDA.Valor / 100;  
    ant.A11 = Datos.antropometria.DIAMETRO_RODILLA_DERECHA.Valor / 100;  
    ant.A12 = Datos.antropometria.DIAMETRO_RODILLA_IZQUIERDA.Valor / 100;  
    ant.A13 = Datos.antropometria.LONGITUD_PIE_DERECHO.Valor / 100;  
    ant.A14 = Datos.antropometria.LONGITUD_PIE_IZQUIERDO.Valor / 100;  
    ant.A15 = Datos.antropometria.ALTURA_MALEOLOS_DERECHO.Valor / 100;  
    ant.A16 = Datos.antropometria.ALTURA_MALEOLOS_IZQUIERDO.Valor / 100;  
    ant.A17 = Datos.antropometria.ANCHO_MALEOLOS_DERECHO.Valor / 100;  
    ant.A18 = Datos.antropometria.ANCHO_MALEOLOS_IZQUIERDO.Valor / 100;  
    ant.A19 = Datos.antropometria.ANCHO_PIE_DERECHO.Valor / 100;  
    ant.A20 = Datos.antropometria.ANCHO_PIE_IZQUIERDO.Valor / 100;  
end
