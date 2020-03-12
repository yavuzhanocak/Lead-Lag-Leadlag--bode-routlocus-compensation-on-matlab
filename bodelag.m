clc
clear all;
syms T alfa s K
Kv=20;
num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]  
Gs=tf(num,den) 
sys(s)=(1.006 *s^3 + 9.082* s^2 + 14.75* s + 6.077)/( s^3 + 9.044*s^2 + 11.73* s + 4.114); %%TRANSFER FONKSÝYONUNU OLUÞTURMA
G=limit(K*sys)
K=double(solve((Kv-G),K))
bode(Gs*K)
figure(1)
margin(Gs*K);
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs*K)
w=input('Bode diyagramýndan w giriniz:')% w=1.76 40 db
alfa=10^(-w/20)
T=10/(w*alfa)
p = 1/T
z = 1/(T*alfa)
Gc=tf([1 z],[1 p])
sys2=Gs*Gc
figure(2); hold on;
margin(Gc); hold off; 
sys3=feedback(sys2,[1])
step(sys3)
stepinfo(sys3)