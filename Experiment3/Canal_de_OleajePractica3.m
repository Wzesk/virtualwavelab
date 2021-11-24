clear all,clc,close all

%====Specify run directory ===================================

caso=menu('Select a wave type','Stationary','Progresive');
if caso==1
    load Caso7.mat;beachX=[0 30 30 0];ho=0.6;%H=0.15 m; T=2 s; h=0.6 m
    elseif caso==2
    load Caso8.mat;beachX=[0 30 30 0];ho=0.6;%H=0.075 m; T=2 s; h=0.6 m
    
end

%Introduce coordenadas de la particula
P1X=input('Location x of pressure sensor (PS1) and wave gauge (WG1):');%Ejemplo: 10.0
P1Z=input('Location z of pressure sensor (PS1):');%Ejemplo: 0.0

%Encuentra indice de las posiciones que corresponden a los indices
idx=find(xc>P1X, 1 );
idx0=idx;

idy=find(yc>P1Z, 1 );
idy0=idy;

%Extrae serie temporal de la matriz tridimensional de las componentes de la
%velocidad
P1(:)=1000.*(P(idy,idx,:)+0.049);
P1(1)=P1(2);
eta=eta-0.005;





dt=0.1;
water=[0 0 1];
i0=1;
X(i0)=xc(idx);
Y(i0)=yc(idy);





for i=2:1000


%Grafica canal y series temporales de superficie libre, y presión
    subplot(4,1,1:2)
 
    fill([xc(1) xc' xc(end)],[0 eta(i,:) 0], water),hold on
    
    h=plot(xc(idx),yc(idy),'ok')
    set(h,'MarkerFaceColor','r')
    text(xc(idx0)+0.5,yc(idy0)+0.025,'PS1','color','red')



    plot([xc(idx0) xc(idx0)],[ho-0.1 ho+0.20],'k','LineWidth',3)
    text(xc(idx0)+0.5,0.75,'WG1')

    
    td=title(['t= ' num2str(i*dt) ' s'],'fontsize',12,'color','black');
    
    xlabel('Along-flume distance (m)')
    ylabel('Elevation (m)')

    set(gca,'FontSize',14)
    axis([xc(1) xc(end) 0 0.80])
        set(gca,'LineWidth',2)

    hold off
    
    subplot(4,1,3)
    
    plot(time(1:i),eta(1:i,idx0)-ho,'k'),hold on
    axis([time(i)-20 time(i) -0.15 0.15]),hold off
    xlabel('Time (s)'),ylabel('\eta (m)')
    set(gca,'FontSize',14)    
    set(gca,'LineWidth',2)

    
    subplot(4,1,4)
    
    plot(time(1:i),P1(1:i),'r'),hold on
    axis([time(i)-20 time(i) min(P1)-200 max(P1)+200]),hold off
    xlabel('Time (s)'),ylabel('p (Pa)')
    set(gca,'FontSize',14)    
    set(gca,'LineWidth',2)





        set(gcf,'position',[0         0         994         737]) 

       drawnow

    
end
WG1=eta(:,idx0)-eta(1,idx0);

save Practica3.mat P1X P1Z WG1 P1 time

