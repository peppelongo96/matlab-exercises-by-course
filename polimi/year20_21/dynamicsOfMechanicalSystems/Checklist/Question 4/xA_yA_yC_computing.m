clear all
close all
clc

load("Harbour_crane_structure_mkr")

% Structural matrices definition

MFF=M(1:74,1:74);
CFF=R(1:74,1:74);
KFF=K(1:74,1:74);

MFC=M(1:74,75:78);
CFC=R(1:74,75:78);
KFC=K(1:74,75:78);

MCF=M(75:78,1:74);
CCF=R(75:78,1:74);
KCF=K(75:78,1:74);

MCC=M(75:78,75:78);
CCC=R(75:78,75:78);
KCC=K(75:78,75:78);

%%

i=sqrt(-1);
vett_f=0:0.01:10;
QF=zeros(74,1);
F0=1; % magnitude of horizontal distributed load
FE_len=7.5; % lenght of each FE
% Distributed load force partitioning
QF(9,1)=F0*FE_len/2; % Node 5 (x)
QF(11,1)=F0*FE_len^2/12; % Node 5 (theta)
QF(18,1)=F0*FE_len; % Node 8 (x) 
QF(33,1)=F0*FE_len/2; % Node 13 (x)
QF(35,1)=-F0*FE_len^2/12; % Node 13 (theta)
for k=1:length(vett_f)
    ome=2*pi*vett_f(k);
    A=-ome^2*MFF+i*ome*CFF+KFF;
    xF=A\QF;
    xA=xF(45,1);
    yA=xF(46,1);
    xC=xF(21,1);
    yC=xF(22,1);
    mod1(k)=abs(xA);
    phase1(k)=angle(xA);
    mod2(k)=abs(yA);
    phase2(k)=angle(yA);
    mod3(k)=abs(yC);
    phase3(k)=angle(yC);
end
 
figure
subplot 211;plot(vett_f,mod1);grid;xlabel('[Hz]');ylabel('[m/N]');title('xA/F_h_d_l')
subplot 212;plot(vett_f,phase1);grid;xlabel('[Hz]');ylabel('[rad]')
figure
subplot 211;plot(vett_f,mod2);grid;xlabel('[Hz]');ylabel ('[m/N]');title ('yA/F_h_d_l')
subplot 212;plot(vett_f,phase2);grid;xlabel('[Hz]');ylabel('[rad]')
figure
subplot 211;plot(vett_f,mod3);grid;xlabel('[Hz]');ylabel ('[m/N]');title ('yC/F_h_d_l')
subplot 212;plot(vett_f,phase3);grid;xlabel('[Hz]');ylabel('[rad]')