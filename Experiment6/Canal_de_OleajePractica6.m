 
clc
clear all;close all
%====Specify run directory ===================================

caso=menu('Selecciona un caso','Caso 9','Caso 10','Caso 11');
if caso==1
    load Caso9.mat;ho=0.6;%H=0.15 m; T=4 s; h=0.6 m 
    elseif caso==2
    load Caso10.mat;ho=0.6;%H=0.15 m; T=5 s; h=0.6 m
    elseif caso==3
    load Caso11.mat;ho=0.6;%H=0.15 m; T=6 s; h=0.6 m   
end

beachX=[20 30 30 20];beachZ=[0 1 0 0];    
sand=[[209 172 46]/256];

m=length(xc);n=length(yc);
dt=0.1;
N=length(time);

%
for iii=1:length(xc)
    if(xc(iii)<20)
    h(iii)=0.6;
    else
        h(iii)=0.6-0.1.*(xc(iii)-20);
    end
end

xS=input('Introduce la posición de los sensores x (m):');%Ejemplo [10 22 25]
for ii=1:length(xS)
idx(ii)=max(find(xc<xS(ii)));
end

%===============================
%Animation loop
%===============================
water=[0 0 1];
j=0;
figure(1)
for i=0:N-1
    j=j+1;
    
  
  
    subplot(2,1,1)
    fill([xc(1) xc' xc(end)],[0 eta(j,:) 0],water), hold on

  for jj=1:length(xS)
    plot([xS(jj) xS(jj)],[ho-0.1 ho+0.20],'k','LineWidth',3)
%      text(xS(jj),0.9,'WG1')
%     eval(['text(xS(jj),0.9,' ''WG'' num2str(jj))])     
    wg=text(xS(jj),0.9,['WG' num2str(jj)],'fontsize',12,'color','black','FontWeight','bold');

 end
   
  xlabel('Along-flume distance (m)')
    ylabel('Elevation (m)')    
%     hold on
     f1=fill(beachX,beachZ,sand);
    
    td=title(['t = ' num2str(i*dt) '  s'],'fontsize',12,'color','black','FontWeight','bold');
      set(gca,'FontSize',14)
    axis([0 xc(end) 0 yc(end)])
        set(gca,'LineWidth',2)
    
    set(gcf,'position',[146         311        1166         681])
    %    set(gcf,'position',[217         428        2119         610]) 


    hold off
    
    drawnow
   
    ETA(:,1:length(idx))=eta(:,idx)-eta(1,idx);
    
    
    subplot(2,1,2)
    plot(time(1:j),ETA(1:j,:)),hold on
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

etaWG=ETA;

t=time;

%save Practica6.mat t etaWG
