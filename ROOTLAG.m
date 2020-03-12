clc
syms T alfa s
mp=0.1;
ts=6;
Kv=20;

num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]          %%PAYDA
Gs=tf(num,den) 
C_lag(s) = (s+1/T)/(s+1/(alfa*T)) 

sys=(1.006 *s^3 + 9.082* s^2 + 14.75* s + 6.077)/( s^3 + 9.044*s^2 + 11.73* s + 4.114);%%TRANSFER FONKS�YONUNU OLU�TURMA

zeta=1/(sqrt(1+(pi/log(mp))^2))                 %%Mp �LE ZETANIN BULUNMASI
wn=4/(zeta*ts)                                  %%ZETA �LE Wn BULUNMASI
beta=(pi-acos(zeta))                            %%ZETA �LE BETA BULUNMASI

s1=complex(zeta*wn,sqrt(wn^2-(zeta*wn)^2))      %%K�KYER E�R�S�NDE ��KENDEN YARARLANARAK S1 BULUNDU
pay=polyval(num,s1)                             %%PAY'DA S1 YER�NE YAZILDI     
payda=polyval(den,s1)                           %%PAYDA'DA S1 YER�NE YAZILDI
K=abs(payda/pay)
z=real(s1)/5
G=limit(sys*C_lag,s,0)                          %%S=0 G�RE L�M�T ALINIR
alfa=double(solve((Kv-G*K),alfa))               %%Kv EL��TL���NDEN ALFA BULUNUR
p=double(z/alfa)
T=double(1/z)
Gc=tf([K 1/T],[1 1/(alfa*T)])                   %%TRANSFER FONKS�YONU OLU�TURULUR

Key=abs(polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1))     %%FONKS�YONDA S1 YER�NE YAZILIR
x=polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1)
fi=(atan(imag(x)/real(x)))                      %%TAN() YARDIMIYLA Q BULUNUR
sys2=Gs*Gc
rlocus(sys2);
sys3=feedback(sys2,[1])
figure
step(sys3+0.04)
stepinfo(sys3)