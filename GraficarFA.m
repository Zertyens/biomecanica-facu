function GraficarFA(FA, SL, Datos, Ciclo)
	% GraficarFuerzasArticulares - Grafica fuerzas articulares en ejes anatómicos
	% normalizadas por MASA corporal vs % ciclo de marcha
	%
	% Inputs:
	%   FA		- Estructura con fuerzas articulares en coordenadas globales
	%   SL		- Estructura con sistemas locales (vectores unitarios i, j, k)
	%   Datos	- Estructura con datos antropométricos
	%   Ciclo	- Estructura con información de eventos de marcha
	
	%% Parámetros
	peso = Datos.antropometria.PESO.Valor; % kg
	
	%% Calcular ejes articulares
	% (Vectorizado en la función auxiliar)
	l_R_Ankle = calcularEjeArticular(SL.i5, SL.k3);
	l_R_Knee = calcularEjeArticular(SL.i3, SL.k1);
	l_R_Hip = calcularEjeArticular(SL.i1, SL.k_pelv);
	l_L_Ankle = calcularEjeArticular(SL.i6, SL.k4);
	l_L_Knee = calcularEjeArticular(SL.i4, SL.k2);
	l_L_Hip = calcularEjeArticular(SL.i2, SL.k_pelv);
	
	%% Transformar fuerzas a coordenadas anatómicas
	% (Vectorizado en la función auxiliar)
	
	% TOBILLO DERECHO
	F_R_Ankle_PrxDis = proyectarVector(FA.tobillo_D, SL.i5);
	F_R_Ankle_MedLat = proyectarVector(FA.tobillo_D, SL.k3);
	F_R_Ankle_AntPos = -proyectarVector(FA.tobillo_D, l_R_Ankle);
	
	% RODILLA DERECHA
	F_R_Knee_PrxDis = proyectarVector(FA.rodilla_D, SL.i3);
	F_R_Knee_MedLat = proyectarVector(FA.rodilla_D, SL.k1);
	F_R_Knee_AntPos = -proyectarVector(FA.rodilla_D, l_R_Knee);
	
	% CADERA DERECHA
	F_R_Hip_PrxDis = proyectarVector(FA.cadera_D, SL.i1);
	F_R_Hip_MedLat = proyectarVector(FA.cadera_D, SL.k_pelv);
	F_R_Hip_AntPos = -proyectarVector(FA.cadera_D, l_R_Hip);
	
	% TOBILLO IZQUIERDO
	F_L_Ankle_PrxDis = proyectarVector(FA.tobillo_I, SL.i6);
	F_L_Ankle_MedLat = -proyectarVector(FA.tobillo_I, SL.k4);
	F_L_Ankle_AntPos = -proyectarVector(FA.tobillo_I, l_L_Ankle);
	
	% RODILLA IZQUIERDA
	F_L_Knee_PrxDis = proyectarVector(FA.rodilla_I, SL.i4);
	F_L_Knee_MedLat = -proyectarVector(FA.rodilla_I, SL.k2);
	F_L_Knee_AntPos = -proyectarVector(FA.rodilla_I, l_L_Knee);
	
	% CADERA IZQUIERDA
	F_L_Hip_PrxDis = proyectarVector(FA.cadera_I, SL.i2);
	F_L_Hip_MedLat = -proyectarVector(FA.cadera_I, SL.k_pelv);
	F_L_Hip_AntPos = -proyectarVector(FA.cadera_I, l_L_Hip);
	
	%% Normalizar por MASA corporal (kg)
	
	F_R_Ankle_PrxDis_norm = F_R_Ankle_PrxDis / peso;
	F_R_Ankle_MedLat_norm = F_R_Ankle_MedLat / peso;
	F_R_Ankle_AntPos_norm = F_R_Ankle_AntPos / peso;
	
	F_R_Knee_PrxDis_norm = F_R_Knee_PrxDis / peso;
	F_R_Knee_MedLat_norm = F_R_Knee_MedLat / peso;
	F_R_Knee_AntPos_norm = F_R_Knee_AntPos / peso;
	
	F_R_Hip_PrxDis_norm = F_R_Hip_PrxDis / peso;
	F_R_Hip_MedLat_norm = F_R_Hip_MedLat / peso;
	F_R_Hip_AntPos_norm = F_R_Hip_AntPos / peso;
	
	F_L_Ankle_PrxDis_norm = F_L_Ankle_PrxDis / peso;
	F_L_Ankle_MedLat_norm = F_L_Ankle_MedLat / peso;
	F_L_Ankle_AntPos_norm = F_L_Ankle_AntPos / peso;
	
	F_L_Knee_PrxDis_norm = F_L_Knee_PrxDis / peso;
	F_L_Knee_MedLat_norm = F_L_Knee_MedLat / peso;
	F_L_Knee_AntPos_norm = F_L_Knee_AntPos / peso;
	
	F_L_Hip_PrxDis_norm = F_L_Hip_PrxDis / peso;
	F_L_Hip_MedLat_norm = F_L_Hip_MedLat / peso;
	F_L_Hip_AntPos_norm = F_L_Hip_AntPos / peso;
	
	%% Calcular porcentaje del ciclo de marcha
	offset = Ciclo.PrimerFrame - Ciclo.AntesHS;
	RHS1_idx = Ciclo.FrameRHS1 - offset;
	RHS2_idx = Ciclo.FrameRHS2 - offset;
	LHS1_idx = Ciclo.FrameLHS1 - offset;
	LHS2_idx = Ciclo.FrameLHS2 - offset;
	RTO_idx = Ciclo.FrameRTO - offset;
	LTO_idx = Ciclo.FrameLTO - offset;
	
	% Ciclo derecho
	ciclo_derecho_frames = RHS2_idx - RHS1_idx + 1;
	porcentaje_derecho = linspace(0, 100, ciclo_derecho_frames);
	
	% Ciclo izquierdo
	ciclo_izquierdo_frames = LHS2_idx - LHS1_idx + 1;
	porcentaje_izquierdo = linspace(0, 100, ciclo_izquierdo_frames);
	
	%% Definir posiciones de líneas de referencia
	x_RTO = ((RTO_idx - RHS1_idx) / (ciclo_derecho_frames - 1)) * 100;
	x_LTO = ((LTO_idx - LHS1_idx) / (ciclo_izquierdo_frames - 1)) * 100;
	
	%% Organizar datos para graficar
	
	% Datos [Derecho]
	data_R = {F_R_Hip_MedLat_norm(RHS1_idx:RHS2_idx), F_R_Hip_AntPos_norm(RHS1_idx:RHS2_idx), F_R_Hip_PrxDis_norm(RHS1_idx:RHS2_idx);
			  F_R_Knee_MedLat_norm(RHS1_idx:RHS2_idx), F_R_Knee_AntPos_norm(RHS1_idx:RHS2_idx), F_R_Knee_PrxDis_norm(RHS1_idx:RHS2_idx);
			  F_R_Ankle_MedLat_norm(RHS1_idx:RHS2_idx), F_R_Ankle_AntPos_norm(RHS1_idx:RHS2_idx), F_R_Ankle_PrxDis_norm(RHS1_idx:RHS2_idx)};
			  
	% Datos [Izquierdo]
	data_L = {F_L_Hip_MedLat_norm(LHS1_idx:LHS2_idx), F_L_Hip_AntPos_norm(LHS1_idx:LHS2_idx), F_L_Hip_PrxDis_norm(LHS1_idx:LHS2_idx);
			  F_L_Knee_MedLat_norm(LHS1_idx:LHS2_idx), F_L_Knee_AntPos_norm(LHS1_idx:LHS2_idx), F_L_Knee_PrxDis_norm(LHS1_idx:LHS2_idx);
			  F_L_Ankle_MedLat_norm(LHS1_idx:LHS2_idx), F_L_Ankle_AntPos_norm(LHS1_idx:LHS2_idx), F_L_Ankle_PrxDis_norm(LHS1_idx:LHS2_idx)};
	
	% Etiquetas (Unidades cambiadas a N/kg)
	titulos = {'Fuerza Cadera', 'Fuerza Rodilla', 'Fuerza Tobillo'}; % Filas
	ylabels = {'Lateral(-)/Medial(+) [N/kg]', 'Post(+)/Ant(-) [N/kg]', 'Distal(-)/Prox(+) [N/kg]'}; % Columnas
	
	%% Crear figura con 9 subplots
	
	figure('Position', [100, 100, 900, 600]);
	
	for fila = 1:3 % Filas (Cadera, Rodilla, Tobillo)
		for col = 1:3 % Columnas (MedLat, AntPos, PrxDis)
			
			plot_idx = (fila - 1) * 3 + col;
			
			subplot(3, 3, plot_idx);
			hold on; grid on;
			
			% Graficar datos
			plot(porcentaje_derecho, data_R{fila, col}, 'Color', 'g', 'LineWidth', 1.5);
			plot(porcentaje_izquierdo, data_L{fila, col}, 'Color', 'r', 'LineWidth', 1.5);
			
			% Graficar líneas de Toe-Off (TO)
			line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5, 'HandleVisibility', 'off');	
			line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5, 'HandleVisibility', 'off');	
			
			% Etiquetas
			title(titulos{fila}, 'FontSize', 12, 'FontWeight', 'bold');
			ylabel(ylabels{col}, 'FontSize', 10);
			xlabel('% CM', 'FontSize', 10);
			xlim([0, 100]);
			
		end
	end
	
	% Título general (Unidades cambiadas a N/kg)
	sgtitle('Fuerzas Articulares en Ejes Anatómicos [N/Masa Corporal (N/kg)]', ...
			'FontSize', 14, 'FontWeight', 'bold');
	
end

%% Funciones auxiliares 

function l = calcularEjeArticular(i_seg, k_seg)
	% Calcula el eje flotante (l = i x k) de forma vectorizada
	
	% Producto cruz para todas las filas (dim 2)
	l = cross(i_seg, k_seg, 2);
	
	% Norma de cada vector fila (dim 2)
	l_norm = vecnorm(l, 2, 2);
	
	% Evitar división por cero (NaN) en vectores nulos
	l_norm(l_norm < eps) = 1; 
	
	% Normalizar (Broadcasting [N x 3] ./ [N x 1])
	l = l ./ l_norm;
end

function proyeccion = proyectarVector(F, eje)
	% Proyecta F sobre eje (F · eje) de forma vectorizada
	
	% Producto punto fila a fila: sum(A .* B, 2)
	proyeccion = sum(F .* eje, 2);
end