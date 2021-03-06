%% To animate the Flight of Butterfly -------------------------------------
%-------------------------------------------------------------------------%
% Code written by : Martin Josemaria vuelta rojas                         %
%                   Universidad Nacional Mayor de San Masrcos             %
%                   Facultad de Ciencias fisicas                          %
%                   Seminario Permanente de astronomia y                  %
%                   ciencias espaciales                                   %
%                   Peru                                                  %
% E-mail : physics.mvr@hotmail.com                                        %
%-------------------------------------------------------------------------%
%% Butterfly: Animaci�n 3 -> Elementos aleatorios e inclinaci�n -----------
%  Lipiando los espacios
clear all
close all
clc

% Curva de la mariposa
N = 50000;
t = linspace(0,20*pi,N);
x = sin(t).*(exp(cos(t))-2*cos(4*t)+sin(t/12).^5);
y = cos(t).*(exp(cos(t))-2*cos(4*t)+sin(t/12).^5);
x = x./max(abs(x)) ;
y = y./max(abs(y)) ;

%  Aleteo de la maiposa
n    = 5000;
frec = 20*pi;
time = linspace(0,5,n);
the  = (pi/3)*sin(frec*time);
x_al = x;
y_al = y;
z_al = zeros(size(x));

%  Inclinacion de la mariposa
phi  = -pi/3;
y_al = y_al*cos(phi) + z_al*sin(phi);
z_al = z_al*cos(phi) - y_al*sin(phi);

%  Trayectoria
v    = 2;
x_tr = 0.5*v*sin((frec/2)*time);
y_tr = 2*v*time;
z_tr = 0.25*v*cos((frec/2)*time);

% Componente aleatoria
x_rn = 0.25*rand(size(time)).*cos(time).*sin(time) + ...
       0.25*rand(size(time)).*sin(time);
y_rn = 0.01*(0.5-rand(size(time)));
z_rn = 0.5*rand(size(time)).*cos(time) - ...
       0.5*rand(size(time)).*sin(time).*cos(time);

%  Propiedades de la animacion
Buterfly = figure ('Name','Butterfly - Animaci�n 3',...
                   'NumberTitle','off',...
                   'Color', 'k',...
                   'Menubar','none',...
                   'Position',[40 60 1300 600]);

Axesfly = axes('Parent',Buterfly,...
               'DataAspectRatio',[2 1 2],...
               'Position',[0 0 1 1],...
               'View',[100 60],...
               'Xlim',[-2 2],...
               'Ylim',[-1 21],...
               'Zlim',[-2 2]);
axis off;

hold(Axesfly,'all');

stop = uicontrol('style','toggle',...
                 'string','Detener',...
                 'background','white',...
                 'Position', [20 20 100 20]);

Frame = plot3(x_al+x_tr(1)+x_rn(1),...
              y_al+y_tr(1)+y_rn(1),...
              z_al+z_tr(1)+z_rn(1),...
              'Color','m');

title({'Butterfly: Animaci�n 3 (Incinaci�n y aleatoriedad)'},...
       'Color','w',...
       'HorizontalAlignment','center',...
       'FontSize',14);

%  Animaci�n
for i=1:n
    x_al = x.*cos(the(i));
    y_al = y;
    z_al = abs(x)*sin(the(i));
    
    y_al = y_al*cos(phi) + z_al*sin(phi);
    z_al = - y_al*sin(phi) + z_al*cos(phi);
    
    set(Frame,...
        'XData',x_al+x_tr(i)+x_rn(i),...
        'YData',y_al+y_tr(i)+y_rn(i),...
        'ZData',z_al+z_tr(i)+z_rn(i));
    
    if get(stop,'value')==0
        if(~mod(i,10))
            drawnow;
        end
    elseif get(stop,'value')==1
          break
    end
end

set(stop,...
    'style','pushbutton',...
    'string','Cerrar',...
    'callback','close(Buterfly)');