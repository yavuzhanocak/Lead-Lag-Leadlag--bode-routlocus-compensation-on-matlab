clc
syms T alfa s
mp=0.1;
ts=6;
Kv=20;

num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]          %%PAYDA
Gs=tf(num,den) 
C_lag(s) = (s+1/T)/(s+1/(alfa*T)) 

sys=(1.006 *s^3 + 9.082* s^2 + 14.75* s + 6.077)/( s^3 + 9.044*s^2 + 11.73* s + 4.114);%%TRANSFER FONKSÝYONUNU OLUÞTURMA

zeta=1/(sqrt(1+(pi/log(mp))^2))                 %%Mp ÝLE ZETANIN BULUNMASI
wn=4/(zeta*ts)                                  %%ZETA ÝLE Wn BULUNMASI
beta=(pi-acos(zeta))                            %%ZETA ÝLE BETA BULUNMASI

s1=complex(zeta*wn,sqrt(wn^2-(zeta*wn)^2))      %%KÖKYER EÐRÝSÝNDE ÜÇKENDEN YARARLANARAK S1 BULUNDU
pay=polyval(num,s1)                             %%PAY'DA S1 YERÝNE YAZILDI     
payda=polyval(den,s1)                           %%PAYDA'DA S1 YERÝNE YAZILDI
K=abs(payda/pay)
z=real(s1)/5
G=limit(sys*C_lag,s,0)                          %%S=0 GÖRE LÝMÝT ALINIR
alfa=double(solve((Kv-G*K),alfa))               %%Kv ELÞÝTLÝÐÝNDEN ALFA BULUNUR
p=double(z/alfa)
T=double(1/z)
Gc=tf([K 1/T],[1 1/(alfa*T)])                   %%TRANSFER FONKSÝYONU OLUÞTURULUR

Key=abs(polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1))     %%FONKSÝYONDA S1 YERÝNE YAZILIR
x=polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1)
fi=(atan(imag(x)/real(x)))                      %%TAN() YARDIMIYLA Q BULUNUR
sys2=Gs*Gc
rlocus(sys2);
sys3=feedback(sys2,[1])
figure
step(sys3+0.04)
stepinfo(sys3)