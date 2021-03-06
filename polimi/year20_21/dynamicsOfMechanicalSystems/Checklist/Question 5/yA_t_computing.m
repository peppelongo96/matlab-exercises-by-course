clear all
close all
clc

load("Harbour_crane_structure_5_mkr") % Static weight force added in node 17 (A) [Fg = Ma*g]

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
T=1.2;
dt=0.001;
vett_t=0:dt:T;
Ma=800;
g=9.81;
A_y_rel=[0.25 0.25 0.15];
phi_y_rel=[0 pi pi];
vett_yA=zeros(1,length(vett_t));
vett_y_rel=zeros(1,length(vett_t));
QF=zeros(74,1);
for k=1:3
    ome=k*2*pi/T;
    A=-ome^2*MFF+i*ome*CFF+KFF;
    y_rel=A_y_rel(k)*exp(i*phi_y_rel(k));
    y_rel_dd=-ome^2*y_rel;
    Tstring=Ma*y_rel_dd; 
    QF(46,1)=-Tstring; % Force on point A. Negative due to the reference system
    xF=A\QF;
    yA=xF(46,1);
    vett_y_rel=vett_y_rel+(abs(y_rel)*cos(ome*vett_t+angle(y_rel)));
    vett_yA=vett_yA+(abs(yA)*cos(ome*vett_t+angle(yA)));
end

figure
plot(vett_t,vett_y_rel);grid;xlabel('[s]');title ('y_r_e_l(t)')
figure
plot(vett_t,vett_yA);grid;xlabel('[s]');title ('y_A(t)')

%%

fft_y_rel=fft(vett_y_rel);
fft_y_a=fft(vett_yA);
N=length(vett_y_rel); % N=length(vett_yA)
% df=1/T;
% fmax=(N/2-1)*df;
fmax=10; % fs=20 (Shannon theorem)
df=fmax/(N/2-1);
vett_freq=0:df:fmax;

mod_y_rel(1)=1/N*abs(fft_y_rel(1));
mod_y_rel(2:N/2)=2/N*abs(fft_y_rel(2:N/2));
phase_y_rel(1:N/2)=angle(fft_y_rel(1:N/2));

mod_y_a(1)=1/N*abs(fft_y_a(1));
mod_y_a(2:N/2)=2/N*abs(fft_y_a(2:N/2));
phase_y_a(1:N/2)=angle(fft_y_a(1:N/2));

figure
subplot 211;stem(vett_freq,mod_y_rel);xlabel('[Hz]');ylabel('[m]');title('y_r_e_l')
subplot 212;stem(vett_freq,phase_y_rel);grid;xlabel('[Hz]');ylabel('[rad]')
figure
subplot 211;stem(vett_freq,mod_y_a);grid;xlabel('[Hz]');ylabel('[m/N]');title('yA/-Tstring');	
subplot 212;stem(vett_freq,phase_y_a);grid;xlabel('[Hz]');ylabel('[rad]')
x_zoom=0.1;
figure
subplot 211;stem(vett_freq,mod_y_rel);xlabel('[Hz]');ylabel('[m]');title("y_r_e_l (zoomed to "+x_zoom+"Hz)");xlim([0 x_zoom])
subplot 212;stem(vett_freq,phase_y_rel);grid;xlabel('[Hz]');ylabel('[rad]');xlim([0 x_zoom])
figure
subplot 211;stem(vett_freq,mod_y_a);grid;xlabel('[Hz]');ylabel('[m/N]');title("yA/-Tstring (zoomed to "+x_zoom+"Hz)");xlim([0 x_zoom])
subplot 212;stem(vett_freq,phase_y_a);grid;xlabel('[Hz]');ylabel('[rad]');xlim([0 x_zoom])


