clc
syms T alfa s K
Kv=20;
Fp=35;

num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]          %%PAYDA
Gs=tf(num,den) 

sys=(1.006 *s^3 + 9.082* s^2 + 14.75* s + 6.077)/( s^3 + 9.044*s^2 + 11.73* s + 4.114); %%TRANSFER FONKSÝYONUNU OLUÞTURMA

G=limit(K*sys*s)   
K=solve((Kv-G),K)
bode(num,den)       %%bode grafiði elde edilir
figure
margin(Gs);         
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs)              %% 
fi=(Fp-Pm+5)*pi/180                     %%Q deðeri bulunur
alfa=double(solve((sin(fi)*(1+alfa)-(1-alfa)),alfa))        %%alfa bulunur
resp=mag2db(1/sqrt(alfa))
Wc=(pi+Wcp)                                                 %%
z = Wc*sqrt(alfa)
p = Wc/sqrt(alfa)
Gc=tf([1 z],[1 p])
sys2=Gs*Gc
figure(1); hold on;
margin(Gc); hold off; 
sys3=feedback(sys2,[1])
step(sys3)