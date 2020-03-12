clc
clear all;
mp=0.9;
ts=10;
K=20;
T2=10;

num=[1.006  9.082  14.75 6.077]      %%PAY
den=[1 9.044  11.73 4.114 ]          %%PAYDA


sys=tf(num,den)                     %%TRANSFER FONKSÝYONUNU OLUÞTURMA

zeta=1/(sqrt(1+(pi/log(mp))^2))     %%Mp ÝLE ZETANIN BULUNMASI
wn=4/(zeta*ts)                      %%ZETA ÝLE Wn BULUNMASI
beta=pi-acos(zeta)                  %%ZETA ÝLE BETA BULUNMASI
s1=complex(zeta*wn,sqrt(wn^2-(zeta*wn)^2))

pay=polyval(num,s1)
payda=polyval(den,s1)
x=pay/payda;
fi=(atan(imag(x)/real(x)))*180/pi    %%TAN() YARALANARAK Q BULMA

p=abs(s1)*sin((beta-fi)/2)/sin((beta+fi)/2) %%KUTUP BULMA
z=abs(s1)*sin((beta+fi)/2)/sin((beta-fi)/2) %%SIFIR BULMA
numc=[1 z]
denc=[1 p]
sysc=tf(numc,denc)                          
T1=1/z
alfa=double(T1*p)
numc1=[1 T2]
denc1=[1 1/(alfa*T2)]
sysc1=tf(numc1,denc1)
Key=abs(polyval(numc1,s1)/polyval(denc1,s1))    %%S1 YERÝNE YAZILMASI
x=polyval(numc1,s1)/polyval(denc1,s1)
fi=(atan(imag(x)/real(x)))
sys2=sysc1*sysc*sys*K
rlocus(sys2);
sys3=feedback(sys2,[1])
figure
step(sys3)
stepinfo(sys3)