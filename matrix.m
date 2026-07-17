function [A ,B, C, D,n,m,p]=matrix(option)


% Thermal resistivity=L/(A*k)
    % L tickness (m)
    % A area (m^2)
    % k thermal conductivity=(W/(m*K))
% thermal capacitance=c*p*A*L/2;
    % p density (kg/m^2)
    % c specific heat (J/(kg*K))
    %% PARAMÉTEREK A MODELLBE
kbrick=1.3;
kAir=0.026;
kConc=2.1;                          % beton
kParq=0.2;                          % parket
kTile=1.28;                         % csempe
kWin=1.2;                           % ablak
kDoorIn=0.8;                           % ablak
kDoorOut=1.3;                           % ablak
lWin=0.05;
lDoor=0.05;
cAir=1005;
pAir=1.22;
WallOut=0.4;
WallIn=0.2;
ticknessPl=0.3;
height=2.5;
pBrick=2300;
pConc=2243;
cBrick=880;
cConc=840;
Asz1=3.4*4;
Asz2=6*3.4;
Asz3=6*1.6+2.15*0.9;
Asz4=2.5*2.15;
Rl=0.05;


Rf1=WallOut/(kbrick*(5.85*height+1.5));
Rf2=WallIn/(kbrick*(3.05*height+0.5*0.9));
Rf3=WallOut/(kbrick*(0.5*height+0.5*3.5));
Rf4=WallIn/(kbrick*6.1*height);
Rf5=WallIn/(kbrick*(1.3*height+0.5*0.9));
Rf6=WallIn/(kbrick*1.6*height);
Rf7=WallIn/(kbrick*5.1*height);
Rf8=WallOut/(kbrick*(0.7*height+1*1.5));
Rf9=WallIn/(kbrick*(3.75*height+0.5*0.9));
Rf10=WallOut/(kbrick*(1.6*height+0.55*2));
Rf11=WallIn/(kbrick*2.5*height);

Ra1=lWin/(kWin*(1.4*1.5));
Ra2=lDoor/(kDoorIn*(0.9*2));
Ra3=lWin/(kWin*(3.5*1.5));
Ra4=Ra2;
Ra5=Ra2;
Ra6=Ra1;
Ra7=lDoor/(kDoorOut*2*(0.9*2));
Ra8=Ra2;
Ra9=lWin/(kWin*(0.55*0.55));

Rt1=0.15/(kConc*3.4*4)+0.03/(kParq*3.4*4);                                           % talaj
Rt2=0.15/(kConc*6*3.4)+0.03/(kParq*6*3.4);
Rt3=0.15/(kConc*Asz3)+0.03/(kTile*Asz3)+0.01;
Rt4=0.15/(kConc*2.5*2.15)+0.03/(kTile*2.5*2.15);
Rpl1=ticknessPl/(kbrick*Asz1);
Rpl2=ticknessPl/(kbrick*Asz2);
Rpl3=ticknessPl/(kbrick*Asz3);
Rpl4=ticknessPl/(kbrick*Asz4);
Csz1=1500000;                                               %cAir*pAir*13.43*height/2
Cf1=cBrick*pBrick*(height*5.85+1.5*1)*WallOut/2;
Ct1=cConc*pConc*Asz1*0.3/2;
Cf2=cBrick*pBrick*(3.05*height+0.5*0.9)*WallIn/2;
Csz2=2000000;                                               %cAir*pAir*18*height/2
Cf3=150000;
Cf4=cBrick*pBrick*6.1*height*WallIn/2;
Ct2=cConc*pConc*Asz2*0.3/2;
Cf5=cBrick*pBrick*(1.3*height+0.5*0.9)*WallIn/2;
Csz3=2000000;                                       %cAir*pAir*12*height/2
Cf6=cBrick*pBrick*1.6*height*WallIn/2;
Ct3=cConc*pConc*Asz3*0.3/2;
Cf8=cBrick*pBrick*(0.5*height+0.5*0.9)*WallOut/2;
Cf7=cBrick*pBrick*(5.1*height)*WallIn/2;
Cf11=cBrick*pBrick*2.5*height*WallIn/2;
Csz4=500000;                                        %cAir*pAir*5*height/2
Cf9=cBrick*pBrick*(3.75*height+0.5*0.9)*WallIn/2;
Cf10=cBrick*pBrick*(1.65*height+0.5*2)*WallOut/2;
Ct4=cConc*pConc*Asz4*0.3/2;
Cpl1=cBrick*pBrick*Asz1*ticknessPl/2;
Cpl2=cBrick*pBrick*Asz2*ticknessPl/2;
Cpl3=cBrick*pBrick*Asz3*ticknessPl/2;
Cpl4=cBrick*pBrick*Asz4*ticknessPl/2;
Cm1=200000;
Cm2=200000;
Cm3=750000;
Cm4=500000;

if option==1
    Ra9=0;                                          % in bathroom the window is open
elseif option==2
    Ra1=0;                                          % in room1 the window is open
elseif option==3
    Ra3=0;                                          % in room2 the window is open
elseif option==4
    Ra6=Ra6/4;                                          % in kitcken the window is open
elseif option==5
    Ra9=0;
    Ra1=0;
elseif option==5
    Ra9=0;
    Ra3=0;
elseif option==5
    Ra9=0;
    Ra6=0;
end

    %% A MÁTRIXOK
 n=27;                              % number of states
 m=10;                              % number of inputs
 p=n;
 A=zeros(n);
 B=zeros(n,m);
 C=eye(p);
 D=[];
% C=zeros(p,n);
% D=zeros(p,m);
% C(1,1)=1;
% C(2,5)=1;

A(1,1)=-(1/(Rl)+1/(2*Rl+Ra1)+1/(Rl+Rt1/2)+1/(Rl+Rf2/2)+1/(2*Rl+Ra2)+1/(2*Rl+Ra5)+1/(Rl+Rf11/2)+1/(Rl+Rpl1/2));       % 1. szoba
A(1,3)=1/(Rl+Rt1/2);
A(1,4)=1/(Rl+Rf2/2);
A(1,5)=1/(2*Rl+Ra2);
A(1,10)=1/(2*Rl+Ra5);
A(1,15)=1/(Rl+Rf11/2);
A(1,20)=1/(Rl+Rpl1/2);
A(1,24)=1/(Rl);
A(1,:)=A(1,:)/Csz1;

A(2,2)=-2/(Rl+Rf1/2);
A(2,24)=1/(Rl+Rf1/2);
A(2,:)=A(2,:)/Cf1;

A(3,1)=1/(Rl+Rt1/2);
A(3,3)=-(1/(Rl+Rt1/2)+1/(Rt1/2));
A(3,:)=A(3,:)/Ct1;

A(4,1)=1/(Rl+Rf2/2);
A(4,4)=-2/(Rl+Rf2/2);
A(4,5)=1/(Rl+Rf2/2);
A(4,:)=A(4,:)/Cf2;

A(5,1)=1/(2*Rl+Ra2);                                        % 2. szoba
A(5,4)=1/(Rl+Rf2/2);
A(5,5)=-(1/(Rl+Rf2/2)+1/(2*Rl+Ra2)+1/(2*Rl+Ra3)+1/(Rl)+1/(Rl+Rf4/2)+1/(Rl+Rt2/2)+1/(Rl+Rf5/2)+1/(2*Rl+Ra4/2)+1/(Rl+Rpl2/2));
% A(5,6)=1/(Rl+Rf3/2);
A(5,7)=1/(Rl+Rf4/2);
A(5,8)=1/(Rl+Rt2/2);
A(5,9)=1/(Rl+Rf5/2);
A(5,10)=1/(2*Rl+Ra4/2);
A(5,21)=1/(Rl+Rpl2/2);
A(5,25)=1/(Rl);
A(5,:)=A(5,:)/Csz2;

% A(6,5)=1/(Rl+Rf3/2);
A(6,6)=-2*(1/(Rl+Rf3/2));
A(6,25)=1/(Rl+Rf3/2);
A(6,:)=A(6,:)/Cf3;

A(7,5)=1/(Rl+Rf4/2);
A(7,7)=-2*(1/(Rl+Rf4/2));
A(7,:)=A(7,:)/Cf4;

A(8,5)=1/(Rl+Rt2/2);
A(8,8)=-(1/(Rl+Rt2/2)+1/(Rt2/2));
A(8,:)=A(8,:)/Ct2;

A(9,5)=1/(Rl+Rf5/2);
A(9,9)=-2*(1/(Rl+Rf5/2));
A(9,10)=1/(Rl+Rf5/2);
A(9,:)=A(9,:)/Cf5;

A(10,1)=1/(2*Rl+Ra5);                           % 3. szoba homerseklete
A(10,5)=1/(2*Rl+Ra4/2);
A(10,9)=1/(Rl+Rf5/2);
A(10,10)=-(1/(Rl+Rf5/2)+1/(2*Rl+Ra4/2)+1/(2*Rl+Ra5)+1/(2*Rl+Ra6)+1/(2*Rl+Ra7)+1/(Rl+Rf6/2)+1/(Rl+Rt3/2)+1/(Rl)+1/(Rl+Rf7/2)+1/(Rl+Rf9/2)+1/(2*Rl+Ra8)+1/(Rl+Rpl3/2));
A(10,11)=1/(Rl+Rf6/2);
A(10,12)=1/(Rl+Rt3/2);
% A(10,13)=1/(Rl+Rf8/2);
A(10,14)=1/(Rl+Rf7/2);
A(10,16)=1/(2*Rl+Ra8);
A(10,17)=1/(Rl+Rf9/2);
A(10,22)=1/(Rl+Rpl3/2);
A(10,26)=1/(Rl);
A(10,:)=A(10,:)/Csz3;

A(11,10)=1/(Rl+Rf6/2);
A(11,11)=-2*(1/(Rl+Rf6/2));
A(11,:)=A(11,:)/Cf6;

A(12,10)=1/(Rl+Rt3/2);
A(12,12)=-(1/(Rt3/2)+1/(Rl+Rt3/2));
A(12,:)=A(12,:)/Ct3;

% A(13,10)=1/(Rl+Rf8/2);
A(13,13)=-2/(Rl+Rf8/2);
A(13,26)=1/(Rl+Rf8/2);
A(13,:)=A(13,:)/Cf8;

A(14,10)=1/(Rl+Rf7/2);
A(14,14)=-2*(1/(Rl+Rf7/2));
A(14,:)=A(14,:)/Cf7;

A(15,1)=1/(Rl+Rf11/2);
A(15,15)=-2/(Rl+Rf11/2);
% A(15,16)=1/(Rl+Rf11/2);
A(15,27)=1/(Rl+Rf11/2);
A(15,:)=A(15,:)/Cf11;

A(16,10)=1/(2*Rl+Ra8);
% A(16,15)=1/(Rl+Rf11/2);                             % 4. szoba homerseklete
A(16,16)=-(1/(Rl)+1/(Rl+Rf9/2)+1/(Rl+Rf10/2)+1/(2*Rl+Ra9)+1/(2*Rl+Ra8)+1/(Rl+Rpl4/2));
A(16,17)=1/(Rl+Rf9/2);
A(16,18)=1/(Rl+Rf10/2);
A(16,23)=1/(Rl+Rpl4/2);
A(16,27)=1/(Rl);
A(16,:)=A(16,:)/Csz4;

A(17,10)=1/(Rl+Rf9/2);
A(17,16)=1/(Rl+Rf9/2);
A(17,17)=-2*(1/(Rl+Rf9/2));
A(17,:)=A(17,:)/Cf9;

A(18,16)=1/(Rl+Rf10/2);
A(18,18)=-2/(Rl+Rf10/2);
A(18,:)=A(18,:)/Cf10;

A(19,16)=1/(Rl+Rt4/2);
A(19,19)=-(1/(Rl+Rt4/2)+1/(Rt4/2));
A(19,:)=A(19,:)/Ct4;

A(20,20)=-2/(Rl+Rpl1/2);
A(20,1)=1/(Rl+Rpl1/2);
A(20,:)=A(20,:)/Cpl1;

A(21,21)=-2/(Rl+Rpl2/2);
A(21,5)=1/(Rl+Rpl2/2);
A(21,:)=A(21,:)/Cpl2;

A(22,22)=-2/(Rl+Rpl3/2);
A(22,10)=1/(Rl+Rpl3/2);
A(22,:)=A(22,:)/Cpl3;

A(23,23)=-2/(Rl+Rpl4/2);
A(23,16)=1/(Rl+Rpl4/2);
A(23,:)=A(23,:)/Cpl4;

A(24,24)=-(1/(Rl)+1/(Rl+Rf1/2));                    % 1. melegito
A(24,1)=1/(Rl);
A(24,2)=1/(Rl+Rf1/2);
A(24,:)=A(24,:)/Cm1;

A(25,25)=-(1/(Rl)+1/(Rl+Rf3/2));                    % 2. melegito
A(25,5)=1/(Rl);
A(25,6)=1/(Rl+Rf3/2);
A(25,:)=A(25,:)/Cm2;

A(26,26)=-(1/(Rl)+1/(Rl+Rf8/2));                    % 3. melegito
A(26,10)=1/(Rl);
A(26,13)=1/(Rl+Rf8/2);
A(26,:)=A(26,:)/Cm3;

A(27,27)=-(1/(Rl)+1/(Rl+Rf11/2));                    % 4. melegito
A(27,16)=1/(Rl);
A(27,15)=1/(Rl+Rf11/2);
A(27,:)=A(27,:)/Cm4;

B(1,1)=1/(2*Rl+Ra1);                                % 1. szoba
B(1,:)=B(1,:)/Csz1;

B(2,1)=1/(Rl+Rf1/2);
B(2,:)=B(2,:)/Cf1;

B(3,2)=1/(Rt1/2);
B(3,:)=B(3,:)/Ct1;

B(5,1)=1/(2*Rl+Ra3);                                % 2. szoba
% B(5,6)=1;
B(5,:)=B(5,:)/Csz2;

B(6,1)=1/(Rl+Rf3/2);
B(6,:)=B(6,:)/Cf3;

B(7,3)=1/(Rl+Rf4/2);
B(7,:)=B(7,:)/Cf4;

B(8,2)=1/(Rt2/2);
B(8,:)=B(8,:)/Ct2;

B(10,1)=1/(2*Rl+Ra6);                               % 3. szoba
B(10,4)=1/(2*Rl+Ra7);
B(10,10)=1;
B(10,:)=B(10,:)/Csz3;

B(11,3)=1/(Rl+Rf6/2);
B(11,:)=B(11,:)/Cf6;

B(12,2)=1/(Rt3/2);
B(12,:)=B(12,:)/Ct3;

B(13,1)=1/(Rl+Rf8/2);
B(13,:)=B(13,:)/Cf8;

B(14,4)=1/(Rl+Rf7/2);
B(14,:)=B(14,:)/Cf7;

B(16,1)=1/(2*Rl+Ra9);                               % 4. szoba
% B(16,8)=1;
B(16,:)=B(16,:)/Csz4;

B(18,1)=1/(Rl+Rf10/2);
B(18,:)=B(18,:)/Cf10;

B(19,3)=1/(Rt4/2);
B(19,:)=B(19,:)/Ct4;

B(20,9)=1/(Rl+Rpl1/2);
B(20,:)=B(20,:)/Cpl1;

B(21,9)=1/(Rl+Rpl2/2);
B(21,:)=B(21,:)/Cpl2;

B(22,9)=1/(Rl+Rpl3/2);
B(22,:)=B(22,:)/Cpl3;

B(23,9)=1/(Rl+Rpl4/2);
B(23,:)=B(23,:)/Cpl4;

B(24,5)=1;
B(24,:)=B(24,:)/Cm1;

B(25,6)=1;
B(25,:)=B(25,:)/Cm2;

B(26,7)=1;
B(26,:)=B(26,:)/Cm3;

B(27,8)=1;
B(27,:)=B(27,:)/Cm4;







