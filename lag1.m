clc
syms T alfa s K w a
Kv=20;
Fp=50;
num=[4]
den=[1 2 0]
Gs=tf(num,den) 
%sys(s)=(2.646*s^3 + 32.86*s^2 + 101.8*s + 43.84)/(s^4 + 11.59*s^3 + 43.63*s^2 + 52.1*s + 75.66);
sys(s)=10/(s^2+s)
C_lag(s) = (s+1/T)/(s+1/(alfa*T))
G=limit(K*sys*s)
K=solve((Kv-G),K)
bode(Gs)
figure
margin(Gs);
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs)
fi=(Fp-Pm+6)*pi/180
alfa=double(solve((sin(fi)*(1+alfa)-(1-alfa)),alfa))
resp=mag2db(1/sqrt(alfa))
sys1=10/((w*j)^2+w*j)*K
a=abs(sys1)
Wc=(solve((a+resp),w))

sifir = Wc*sqrt(alfa)
kutup = Wc/sqrt(alfa) y