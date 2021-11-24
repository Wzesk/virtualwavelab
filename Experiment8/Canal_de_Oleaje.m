
clc
clear all;
%====Specify run directory ===================================

caso=menu('Selecciona un caso','Irregular (Hs=0.125 m y Tp=2.5 s)','Irregular (Hs=0.10 m y Tp=1.5 s)');
if caso==1
    load CASO12.mat;beachX=[10 30 30 10];
    elseif caso==2
    load CASO13.mat;beachX=[10 30 30 10];
    
end

beachZ=[0 1 0 0];
m=length(xc);n=length(yc);
dt=0.1;
N=length(time);
%===============================
%Animation loop
%===============================
water=[0 0 1];
j=0;
figure(1)
for i=0:N-1
    j=j+1;
    
    
    fill([xc(1) xc' xc(end)],[0 eta(j,:) 0],water)
    
    
    hold on
    f1=fill(beachX,beachZ,sand);
    
    td=title(['t = ' num2str(i*dt) '  s'],'fontsize',12,'color','black','FontWeight','bold');
    axis([0 xc(end) 0 yc(end)])
    
    set(gcf,'position',[146         311        1166         242])
    hold off
    
    drawnow
    
    
    
end

NS=inputdlg('Introduce el numero de sensores de nivel:')

uiwait(msgbox('Posiciona el cursor del mouse en la posición donde deseas colocar el sensor y presiona el botón izquierdo para definir ubicación','ATENCIÓN','modal'));
figure(1)
grid on
axis([8 27 0 yc(end)])

for i=1:str2num(NS{1,1})
    [X,Y] = ginput(1);
    xS(i)=X;
    y(i)=Y;
    hold on
    plot([X X],[0.5 0.8],'r','LineWidth',3)
    idx=min(find(xc>X));
    hS(i)=abs(h(idx)-0.6);
    eval(['WG' num2str(i) '= eta(:,idx);']);
    text(X,0.9,['WG' num2str(i) ])
    WG=eta(:,idx);
end
