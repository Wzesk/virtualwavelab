 
clc
clear all;
%====Specify run directory ===================================

caso=menu('Selecciona un caso','Caso 9','Caso 10','Caso 11');
if caso==1
    load Caso1.mat;ho=0.6;%H=0.15 m; T=4 s; h=0.6 m 
    elseif caso==2
    load Caso2.mat;ho=0.6;%H=0.15 m; T=5 s; h=0.6 m
    elseif caso==3
    load Caso3.mat;ho=0.6;%H=0.15 m; T=6 s; h=0.6 m   
end

beachX=[20 30 30 20];beachZ=[0 1 0 0];    
sand=[[209 172 46]/256];

m=length(xc);n=length(yc);
dt=0.1;
N=length(time);

%

WG1=20;
VWG1=input('WG cart velocity displacement for x<20 m:');
xWG1=find(xc>WG1, 1 );

%===============================
%Animation loop
%===============================
water=[0 0 1];
j=0;
figure(1)
for i=0:N-1
    j=j+1;
    
    if(i>=200)
    xWG1=find(xc>WG1-VWG1*(time(j)-20), 1 );
    end
    xxWG1(j)=xWG1;
    disp(['El valor de xWG1 es= ',int2str(xWG1)]);
    subplot(2,1,1)
    fill([xc(1) xc' xc(end)],[0 eta(j,:) 0],water), hold on
        fill([xc(xWG1)-1 xc(xWG1)+1 xc(xWG1)+1 xc(xWG1)-1],[ho+0.2 ho+0.2 ho+0.22 ho+0.22],'k')

    
     rueda=0.025;
    xc1=-rueda:rueda./20:rueda;
    yc1=sqrt(rueda.^2-xc1.^2);
    fill([xc1 flip(xc1)]+xc(xWG1)-1+rueda,[-yc1 flip(yc1)]+ho+0.2-rueda,'k')    
    fill([xc1 flip(xc1)]+xc(xWG1)+1-rueda,[-yc1 flip(yc1)]+ho+0.2-rueda,'k')    

    plot([xc(xWG1) xc(xWG1)],[ho-0.1 ho+0.20],'k','LineWidth',3)
    
    text(xc(xWG1),0.9,'WG1')
   
  xlabel('Along-flume distance (m)')
    ylabel('Elevation (m)')    
%     hold on
     f1=fill(beachX,beachZ,sand);
    
    td=title(['t = ' num2str(i*dt) '  s'],'fontsize',12,'color','black','FontWeight','bold');
      set(gca,'FontSize',14)
    axis([0 xc(end) 0 yc(end)])
        set(gca,'LineWidth',2)
    
    set(gcf,'position',[146         311        1166         242])
    %    set(gcf,'position',[217         428        2119         610]) 


    hold off
    
    drawnow
   
    ETA(j)= eta(j,xWG1)-eta(1,xWG1);
    
    
    subplot(2,1,2)
    plot(time(1:j),ETA(1:j),'k'),hold on
 %   axis([time(i+1)-20 time(i+1) -0.15 0.15]),hold off
 if(i<500)
    axis([0 50 -0.1 0.20]),hold off
 else
    axis([time(j)-50 time(j) -0.1 0.20]),hold off
 end
     

    xlabel('Time (s)'),ylabel('eta (m)')
     set(gca,'FontSize',14)    
    set(gca,'LineWidth',2)
    
end

etaWG1=ETA(200:end);

t=time(200:end)-time(200);

%save Practica5.mat t etaWG1
