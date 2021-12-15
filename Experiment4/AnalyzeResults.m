eta1=etaWG1-mean(etaWG1);
eta2=etaWG2-mean(etaWG2);


figure
subplot(2,2,1)
    plot(t,eta1,'.-'), ylabel('\eta_1 (m)')
    [H,amp_c,amp_t,T,nw] = zerodown(eta1,t);
    
    set(gca,'FontSize',14)
    axis([0 t(end) -0.1 0.1])
        set(gca,'LineWidth',2)
        
        
    subplot(2,2,2)
    plot(H/2,'.-r'), ylabel('2|\eta_c| (m)')
       subplot(2,2,2), hold on
    plot(H/2,'o-b')
    eta2c_max(i) = max(H)/2;
    eta2c_min(i) = min(H)/2;
    Hi(i) = (eta2c_max(i)+eta2c_min(i))
    Hr(i) = (eta2c_max(i)-eta2c_min(i))
    Kr(i) = Hr(i)./Hi(i);
    
    set(gca,'FontSize',14)
    axis([0 length(H) 0.0 0.1])
    set(gca,'LineWidth',2)
    
    subplot(2,2,3)
    plot(t,eta2,'.-'), ylabel('\eta_2 (m)')
    [H,amp_c,amp_t,T,nw] = zerodown(eta2,t);
     set(gca,'FontSize',14)
    axis([0 t(end) -0.1 0.1])
        set(gca,'LineWidth',2)
        
    subplot(2,2,4)
    plot(H,'.-r'), ylabel('H_t (m)')
    
    subplot(2,2,4), hold on
    plot(H,'o-b')
    set(gca,'FontSize',14)
    axis([0 length(H) 0 0.1])
    set(gca,'LineWidth',2)
    Ht(i) = nanmean(H)
    Kt(i) = Ht(i)./Hi(i); % Hi = altura incidente calculada
    Ktb(i) = Ht(i)./0.1; % Altura incidente que se indicó al sistema
    
    
    %Del paper de vertical wave barriers de Kriebel y Bollmann
d=0.6; % profundidad
w=0.3; % gap
T=0.1:0.1:10;
for i=1:length(T)
    [L,k,C,Cg,n]=dispeq(T(i),d);
    Tf = (2.*k.*(d-w) + sinh(2.*k.*(d-w)))./((2.*k.*d)+sinh(2.*k.*d));
    Kt1(i) = sqrt(Tf);
    Kt2(i) = (2.*Tf)./(1+Tf); % asumiendo que Kt = 1-Kr
    kh(i) = k.*d;
end
