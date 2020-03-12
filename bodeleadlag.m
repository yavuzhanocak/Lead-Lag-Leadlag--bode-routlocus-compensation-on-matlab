%%faz gerilemeli-ilermeli via Frekans -Bode
clc
clear all;
syms T alfa s K
Kv=20;

num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]  
Gs=tf(num,den) 

sys(s)=(1.006 *s^3 + 9.082* s^2 + 14.75* s + 6.077)/( s^3 + 9.044*s^2 + 11.73* s + 4.114);
G=limit(K*sys*s)
K=double(solve((Kv-G),K))
bode(Gs*K)
figure(1)
margin(Gs*K);
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs*K)
 w=input('Bode diyagram�ndan w giriniz:')