function PlotFuerzasFP(FP, fm)
% Grafica fuerzas verticales y anteroposteriores de ambas plataformas
% PlotFuerzasFP(FP, fm)

    N = length(FP.P1.Fz);
    t = (0:N-1)/fm;  % Vector de tiempo
    
    figure;
    
    % Fuerza vertical (Fz)
    subplot(2,1,1);
    plot(t, FP.P1.Fz, 'b', 'LineWidth', 1.5); hold on;
    plot(t, FP.P2.Fz, 'r', 'LineWidth', 1.5);
    grid on;
    xlabel('Tiempo [s]');
    ylabel('Fuerza Vertical [N]');
    title('Fuerzas Verticales (Fz)');
    legend('Plataforma 1', 'Plataforma 2');
    
    % Fuerza anteroposterior (Fx)
    subplot(2,1,2);
    plot(t, FP.P1.Fx, 'b', 'LineWidth', 1.5); hold on;
    plot(t, FP.P2.Fx, 'r', 'LineWidth', 1.5);
    grid on;
    xlabel('Tiempo [s]');
    ylabel('Fuerza Anteroposterior [N]');
    title('Fuerzas Anteroposteriores (Fx)');
    legend('Plataforma 1', 'Plataforma 2');
    
end