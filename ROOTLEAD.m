mp=0.3; %%OVERSHOT 
ts=10;
 
num=[  -109.7  - 221.4  - 99.32]      %%PAY
den=[1 10.58  66.24  294.2 449.1 202.8]          %%PAYDA

sys=tf(num,den) %%TRANSFER FONK ���N KULLANILAN KOD

zeta=1/(sqrt(1+(pi/log(mp))^2)) %%MP DE�ER�NDEN ZETAYI ELDE ETT�K
wn=4/(zeta*ts)                  %%ZETAYI KULLANARAK Wn ELDE ED�LD�
beta=(pi-acos(zeta))            %%ZETA �LE BETA ELDE ED�LD�

s1=complex(-zeta*wn,sqrt(wn^2-(zeta*wn)^2))   %%K�KYER E�R�S�NDE ��KENDEN YARARLANARAK S1 BULUNDU
pay=polyval(num,s1)                           %%PAY'DA S1 YER�NE YAZILDI                  
payda=polyval(den,s1)                         %%PAYDA'DA S1 YER�NE YAZILDI
x=pay/payda;
fi=(atan(imag(x)/real(x)))                    %%TAN() YARDIMIYLA Q A�ISI BULUNDU

z=abs(s1)*sin((beta-fi)/2)/sin((beta+fi)/2)   %%SIFIRIN BULUNMASI
p=abs(s1)*sin((beta+fi)/2)/sin((beta-fi)/2)   %%KUTUPUN BULUNMASI

numc=[1 p]                                    %%Kc DE PAY      
denc=[1 z]                                    %%Kc DE PAYDA
sysc=tf(numc,denc)                            %%Kc TRANSFER FONKS�YONUNU OLU�TURMA
payc=(polyval(numc,s1))                       %%Kc PAY'DA S1 YER�NE YAZILIR
paydac=(polyval(denc,s1))                     %%Kc PAYDA'DA S1 YER�NE YAZILIR

alfa=z/p                                      %%ALFA BULUNUR
Kc=abs((payda*paydac)/(pay*payc))             %%KC ELDE ED�L�R
sys2=sys*sysc                                 %%KC VE TRANSFER FONKS�YONUN �ARPIMI
rlocus(sys2);                                 %%GRAF�K OLU�TURMA
sys3=feedback(Kc*sys2,[1])
figure
step(sys3)
stepinfo(sys3)