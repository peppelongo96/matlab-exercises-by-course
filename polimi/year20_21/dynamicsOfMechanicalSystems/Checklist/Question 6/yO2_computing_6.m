clear all
close all
clc

load("Harbour_crane_structure_6_mkr")

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
LqF_A=zeros(1,74);
LqF_A(46)=1;
LqF_C=zeros(1,74);
LqF_C(22)=1;
F0=1;
QF_A=LqF_A'*F0;
QF_C=LqF_C'*F0;
for k=1:length(vett_f)
    ome=2*pi*vett_f(k);
    A=-ome^2*MFF+i*ome*CFF+KFF;
    xF_A=A\QF_A;
    xF_C=A\QF_C;
    QCF_A=(-ome^2*MCF+i*ome*CCF+KCF)*xF_A;
    QCF_C=(-ome^2*MCF+i*ome*CCF+KCF)*xF_C;
    mod1(k)=abs(QCF_A(4));
    phase1(k)=angle(QCF_A(4));
    mod2(k)=abs(QCF_C(4));
    phase2(k)=angle(QCF_C(4));
end

figure
subplot 211;plot(vett_f,mod1);grid;xlabel('[Hz]');ylabel('[N/N]');title('V_O2/F0_y_A')
subplot 212;plot(vett_f,phase1);grid;xlabel('[Hz]');ylabel('[rad]')
figure
subplot 211;plot(vett_f,mod2);grid;xlabel('[Hz]');ylabel('[N/N]');title('V_O2/F0_y_C')
subplot 212;plot(vett_f,phase2);grid;xlabel('[Hz]');ylabel('[rad]')