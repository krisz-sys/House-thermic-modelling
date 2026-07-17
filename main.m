clc;
close all;
clear all;

pkg load control;
pkg load signal;


 A1=[];
 B1=[];
 A2=[];
 B2=[];
 A3=[];
 B3=[];
 n=[];
 m=[];
 p=[];

Usz1=700;
Usz2=1500;
Usz3=700;
Usz4=250;

[A1 ,B1, C, D,n,m,p]=matrix(3);
[A2 ,B2, C, D,n,m,p]=matrix(100);
[A3 ,B3, C, D,n,m,p]=matrix(100);
    %% calculation

Ts=10;

sys=ss(A1,B1,C,[]);
sysd=c2d(sys,Ts);
[Ad1,Bd1,Cd1,Dd1]=ssdata(sysd);                                     % with windows thermal resisistance

sys=ss(A2,B2,C,[]);
sysd=c2d(sys,Ts);
[Ad2,Bd2,Cd2,Dd2]=ssdata(sysd);                                     % without windows thermal resistance

sys=ss(A3,B3,C,[]);
sysd=c2d(sys,Ts);
[Ad3,Bd3,Cd3,Dd3]=ssdata(sysd);

% t=0:Ts:1.25*24*60*60;
load("room1_signals.mat");
% load("room2_signals.mat");
% load("kitchen_signals.mat");
% load("bathroom_signals.mat");
% u(1,:)=-1*ones(1,length(t));                                        % outlet temp
u(1,:)=tempGenerator(t);
u(2,:)=5*ones(1,length(t));                                        % ground temp
u(3,:)=20*ones(1,length(t));                                        % neighbor temp
u(4,:)=4*ones(1,length(t));                                        % Corridor temp
u(5,:)=0*ones(1,length(t));                                         % 1. room heater
u(6,:)=0*ones(1,length(t));                                         % 2. room heater
u(7,:)=0*ones(1,length(t));                                         % 3. room heater
u(8,:)=0*ones(1,length(t));                                         % 4. room heater
u(9,:)=20*ones(1,length(t));                                         % upper rooms temp
Qsut=500/2;
u(10,:)=Qsut*square(0.0003*t+200)+Qsut;                                         % heater
u(10,1:500)=Qsut*2;
u(10,length(t)*2/5:length(t)/2)=Qsut*4;
u(10,length(t)*4/5:length(t)*9/10)=Qsut*2;

x=21*ones(n,1);
% start values
x(1)=21.75;
% x(1)=21.5;                                      % 1. room
x(5)=21.42;                                      % 2. room
x(10)=20.11;                                      % kitchen
x(16)=19.6;                                      % bathroom
x(24)=70;
x(25)=50;
x(26)=20;
x(27)=20;


x(2)=21;
x(3)=12;
x(4)=20;
x(6)=21;
x(7)=21;
x(8)=11;
x(9)=20;
x(11)=19;
x(12)=12;
x(13)=14.5;
x(14)=11;
x(15)=22;
x(17)=18;
x(18)=9;
x(19)=19.5;
x(20)=21;
x(22)=19;

y=x;

hist=[0.2 0.15 0.2 0.2];
heaterState=1;
ref=[20 21.9 20 20];
tempIndex=[5 6 7 8];
stateIndex=[1 5 10 16];
heat=[2000 1300 1300 500];

for i=1:length(t)-1
        temp=y(stateIndex(2),i);
        error=temp-ref(2);
        if error>hist(2)
            heaterState=0;
        elseif error<-hist(2)
            heaterState=1;
        end
    for j=1:4
        if heaterState==1
            u(tempIndex(j),i)=heat(j);
        end
    end

    if (t(i)>78000 && t(i)<=90000)                               % the a1 window is oppened
        x=Ad1*x+Bd1*u(:,i);
%     elseif (t(i)>10000 && t(i)<=20000) || (t(i)>30000 && t(i)<=40000) || (t(i)>50000 && t(i)<=60000) || (t(i)>70000 && t(i)<=80000)
%         x=Ad2*x+Bd2*u(:,i);
    else
        x=Ad3*x+Bd3*u(:,i);
    end
    y=[y x];
end

subplot(2,1,1);
hold on;
% plot(0,20);
% plot(t(end),22);
plot(t,y(1,:),'LineWidth',2);
% plot(t,y(2,:));                   % x0=21
% plot(t,y(3,:));                     % 12
% plot(t,y(4,:));                         % 20
% plot(t,y(5,:),'LineWidth',2);
% plot(t,y(6,:));                     % 21
% plot(t,y(7,:));                         % 21
% plot(t,y(8,:));                         % 11
% plot(t,y(9,:));                         % 20
% plot(t,y(10,:),'LineWidth',2);
% plot(t,y(11,:));                        % 19
% plot(t,y(12,:));                    %12
% plot(t,y(13,:));                        % 14.5
% plot(t,y(14,:));                % 11
% plot(t,y(15,:));                    % 22
% plot(t,y(16,:),'LineWidth',2);
% plot(t,y(17,:));                      % 18
% plot(t,y(18,:));                        % 9
% plot(t,y(19,:));                            % 19.5
% plot(t,y(20,:));                        % 21
% plot(t,y(21,:));                        % 20
% plot(t,y(22,:));                        % 19
% plot(t,y(23,:));                            % 19
% plot(t,u(5,:),'LineWidth',3);
% plot(t,u(6,:),'LineWidth',3);
% plot(t,u(7,:),'LineWidth',3);
% plot(t,u(8,:),'LineWidth',3);
% legend('little room','big room','kitchen','bathroom');

% subplot(2,2,1);
% plot(t,y(1,:),'LineWidth',2);
% title("room1");
% xlabel("time(s)");
% ylabel("temp(°C)");
%
% subplot(2,2,2);
% plot(t,y(5,:),'LineWidth',2);
% title("room2");
% xlabel("time(s)");
% ylabel("temp(°C)");
%
% subplot(2,2,3);
% plot(t,y(10,:),'LineWidth',2);
% title("kitchen");
% xlabel("time(s)");
% ylabel("temp(°C)");
%
% subplot(2,2,4);
% plot(t,y(16,:),'LineWidth',2);
% title("bathroom");
% xlabel("time(s)");
% ylabel("temp(°C)");


plot(t,filtered);
title('room1');
legend("simulation","measurement")
subplot(2,1,2);
% plot(t,y(10,:)-filtered);
% plot(t,y(16,:)-filtered);
% plot(t,y(5,:)-filtered);
plot(t,y(1,:)-filtered);
title('error');
% figure;
% plot(t,u(1,:))
% plot(t,u(10,:)/15)




