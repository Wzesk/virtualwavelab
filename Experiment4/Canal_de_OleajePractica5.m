 
clc
clear all;
%====Specify run directory ===================================

caso=menu('Selecciona un caso','Caso1','Caso 2','Caso3','Caso4');
if caso==1
    load Caso12.mat;ho=0.6;%H=0.10 m; T=2 s; h=0.6 m s
    elseif caso==2
    load Caso13.mat;ho=0.6;%H=0.10 m; T=3 s; h=0.6
    elseif caso==3
    load Caso14.mat;ho=0.6;%H=0.10 m; T=4 s; h=0.6   
    elseif caso==4
    load Caso15.mat;ho=0.6;%H=0.10 m; T=5 s; h=0.6   
       
end

beachX=[20 30 30 20];beachZ=[0 1 0 0];    
barrier=[0.75 0.75 0.75];

m=length(xc);n=length(yc);
dt=0.1;
N=length(time);

%

WG1=24.9;
VWG1=input('WG1 cart velocity of displacement [m/s]:');
xWG1=find(xc>WG1, 1 );
WG2=input('WG2 location behind the vertical barrier [m]:');
xWG2=find(xc>WG2, 1 );



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
  
    subplot(2,1,1)
    fill([xc(1) xc' xc(end)],[0 eta(j,:) 0],water), hold on
    fill([xc(xWG1)-1 xc(xWG1)+1 xc(xWG1)+1 xc(xWG1)-1],[ho+0.2 ho+0.2 ho+0.22 ho+0.22],'k')
    
    rueda=0.025;
    xc1=-rueda:rueda./20:rueda;
    yc1=sqrt(rueda.^2-xc1.^2);
    fill([xc1 flip(xc1)]+xc(xWG1)-1+rueda,[-yc1 flip(yc1)]+ho+0.2-rueda,'k')    
    fill([xc1 flip(xc1)]+xc(xWG1)+1-rueda,[-yc1 flip(yc1)]+ho+0.2-rueda,'k')    

    plot([xc(xWG1) xc(xWG1)],[ho-0.1 ho+0.20],'k','LineWidth',3)
    plot([WG2 WG2],[ho-0.1 ho+0.20],'r','LineWidth',3)

    text(xc(xWG1),0.9,'WG1')
       text(xc(xWG2),0.9,'WG2')

   xlabel('Along-flume distance (m)')
    ylabel('Elevation (m)')
    
%     hold on
     f1=fill([24.95 25.05 25.05 24.95],[0.3 0.3 1 1],barrier);
    
    td=title(['t = ' num2str(i*dt) '  s'],'fontsize',12,'color','black','FontWeight','bold');
    
    
     set(gca,'FontSize',14)
    axis([0 xc(end) 0 yc(end)])
        set(gca,'LineWidth',2)
    
%     set(gcf,'position',[146         311        1166         242])
%             set(gcf,'position',[499   428   994   737]) 
            %set(gcf,'position',[217         428        2119         610]) 


    hold off
    
    drawnow
   
    ETA(j)= eta(j,xWG1)-eta(1,xWG1);
    
    
    subplot(2,1,2)
    plot(time(1:j),ETA(1:j),'k'),hold on
    plot(time(1:i+1),eta(1:i+1,xWG2)-eta(1,xWG2),'--r')

 %   axis([time(i+1)-20 time(i+1) -0.15 0.15]),hold off
 
 if(i<500)
    axis([0 50 -0.1 0.15]),hold off
 else
    axis([time(j)-50 time(j) -0.1 0.15]),hold off
 end
     

    xlabel('Time (s)'),ylabel('eta (m)')
     set(gca,'FontSize',14)    
    set(gca,'LineWidth',2)
    legend('WG1','WG2')
  % pause(0.1) 
    
end

etaWG1=ETA(200:end);
etaWG2=eta(200:end,xWG2)-eta(1,xWG2);

t=time(200:end)-time(200);

%save Practica5.mat t etaWG1 etaWG2

