 
clc
clear all;
%====Specify run directory ===================================

caso=menu('Selecciona un caso','Caso1','Caso 2','Caso3','Caso 4');
if caso==1
    load Caso1.mat;beachX=[0 30 30 0];ho=0.6;%H=0.15 m; T=2 s; h=0.6 m s
    elseif caso==2
    load Caso2.mat;beachX=[0 30 30 0];ho=0.6;%H=0.15 m; T=4 s; h=0.6
    elseif caso==3
    load Caso3.mat;beachX=[0 30 30 0];ho=0.4;%H=0.10 m; T=2 s; h=0.4
    elseif caso==4
    load Caso4.mat;beachX=[0 30 30 0];ho=0.4;%H=0.10 m; T=4 s; h=0.4
    
end

beachZ=[0 1 0 0];
m=length(xc);n=length(yc);
dt=0.1;
N=length(time);

%

WG1=input('Introduce la posicion del sensor 1:');
WG2=input('Introduce la posicion del sensor 2:');
xWG1=find(xc>WG1, 1 );
xWG2=find(xc>WG2, 1 );

%===============================
%Animation loop
%===============================
water=[0 0 1];
j=0;
figure(1)
subplot(2,1,1)
xlabel('Distance (m)'),ylabel('z (m)');
axis([0 xc(end) 0 yc(end)]);
set(gcf,'position',[146         311        1166         242]);


subplot(2,1,2)
graf1=plot(time,eta(:,xWG1)-ho,'k'),hold on;
graf2=plot(time,eta(:,xWG2)-ho,'--r');
xlabel('Time (s)'),ylabel('eta (m)');

for i=0:N-1
    j=j+1;
    
    subplot(2,1,1)
    fill([xc(1) xc' xc(end)],[0 eta(j,:) 0],water), hold on
    plot([WG1 WG1],[ho-0.1 ho+0.20],'k','LineWidth',3);
    plot([WG2 WG2],[ho-0.1 ho+0.20],'r','LineWidth',3);
    text(xc(xWG1),0.9,'WG1');
    text(xc(xWG2),0.9,'WG2');
    
%     hold on
%     f1=fill(beachX,beachZ,sand);
    
    td=title(['t = ' num2str(i*dt) '  s'],'fontsize',12,'color','black','FontWeight','bold');
    
    
    
    hold off
    
    drawnow
   
    
    subplot(2,1,2)
%     plot(time(i:i+1),eta(i:i+1,xWG1)-ho,'k'),hold on
%     plot(time(i:i+1),eta(i:i+1,xWG2)-ho,'--r')
    refreshdata(graf1,'caller');
    refreshdata(graf2,'caller');
    axis([time(i+1)-20 time(i+1) -0.15 0.15]),hold off
    %xlabel('Time (s)'),ylabel('eta (m)')
    
   pause(0.1) 
    
end

% NS=inputdlg('Introduce el numero de sensores de nivel:')
% 
% uiwait(msgbox('Posiciona el cursor del mouse en la posición donde deseas colocar el sensor y presiona el botón izquierdo para definir ubicación','ATENCIÓN','modal'));
% figure(1)
% grid on
% axis([8 27 0 yc(end)])
% 
% for i=1:str2num(NS{1,1})
%     [X,Y] = ginput(1);
%     xS(i)=X;
%     y(i)=Y;
%     hold on
%     plot([X X],[0.5 0.8],'r','LineWidth',3)
%     idx=min(find(xc>X));
%     hS(i)=abs(h(idx)-0.6);
%     eval(['WG' num2str(i) '= eta(:,idx);']);
%     text(X,0.9,['WG' num2str(i) ])
%     WG=eta(:,idx);
% end
