
%% function data=LTspiceSim(simfilebase,params)
% addpath('F:\Dropbox\GitHub\quiz2matlab\functions') % Home PC
% addpath('A:\Dropbox\GitHub\quiz2matlab\functions') % UTFPR PC
% addpath('C:\Users\Ruseler\Dropbox\GitHub\quiz2matlab\functions')
clear all
clc

% simfilebase='F:\Dropbox\UTFPR\Moodle\MATLAB\LAB10\LAB10jfet.asc';
% simfilebase='F:\Dropbox\UTFPR\Moodle\MATLAB\LAB10\LAB10jfet2N3819.net';

% simfilebase='C:\Users\Ruseler\Dropbox\UTFPR\Moodle\MATLAB\LTspice\TBJCA.net';
paramstr='Rd=2.2e3 Vdd=20';
% transtr='0 2m 1m 1u';
tic
% data=LTspiceSim(simfilebase,paramstr,transtr);
simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB11\LAB11b.asc';
% [data1]=LTspiceSim(simfilebase);
[data1]=LTspiceSim(simfilebase,paramstr);
toc



%%  CANAL N
clear all
clc

% Vgs=[0 -0.2 -0.4 -0.6 -0.8 -1.0 -1.2 -1.4 -2];
% Vgs=[0 -1 -2 -3 -4 -5];
% Vdd=[0 0.25 0.5 0.75 1 1.5 2 5 10 15];
Vdd=[1.5 1.75 2 3 4 6 8 10];
simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB11\LAB11a.net';
tic
for y=1:length(Vdd) % Cria string com parâmetros
%     paramstr1{y}=['Rd=2.2e3 Vdd=' num2str(Vdd(y))];
    data1(1,y)=LTspiceSim(simfilebase,['Rd=2.2e3 Vdd=' num2str(Vdd(y))]);
end
toc

%% CANAL P
clear all
clc

% Vgs=[0 -0.2 -0.4 -0.6 -0.8 -1.0 -1.2 -1.4 -2];
% Vgs=[0 -1 -2 -3 -4 -5];
% Vdd=[0 0.25 0.5 0.75 1 1.5 2 5 10 15];
Vdd=[0.5 1 1.5 1.75 2 3 4 5 10];
simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB11\LAB11b.net';
tic
for y=1:length(Vdd) % Cria string com parâmetros
%     paramstr1{y}=['Rd=2.2e3 Vdd=' num2str(Vdd(y))];
    data1(1,y)=LTspiceSim(simfilebase,['Rd=2.2e3 Vdd=' num2str(Vdd(y))]);
end
toc


%% Cluster init

c = parcluster(); % Use default profile
c.NumWorkers=16;
c.NumThreads=1;

poolobj=parpool(c);

%% 

[~,y]=size(X);
% A:\Dropbox\GitHub\quiz2matlab\functions
simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB10\LAB10jfetBF245C.net';

% simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB10\LAB10jfetBF245C.net';

% tic
% for n=1:y
%     for =1:y
%         [data1(n)]=LTspiceSim(simfilebase,paramstr1{n});
%     end
% end
% toc
% save TBJCA.mat data X paramstr

%% 

simfilebase='A:\Dropbox\UTFPR\Moodle\MATLAB\LAB10\LAB10jfet2N3819.net';
tic
parfor n=1:y
    [data2(n)]=LTspiceSim(simfilebase,paramstr2{n});    
end
toc




%% Fig
imgin=[pwd '\figs\LAB11a.png'];
imgout=[pwd '\figs\LAB11au.png'];

 pngchangewhite(imgin,imgout,217,237,247) % UTFPR
%  pngchangewhite(imgin,imgout,222,242,248) % AWS

%% Build question
%Read circuit figure
pngfigstr=png2base64([pwd '\figs\LAB11au.png']);
% sortnquestions=8; % Escolha um numero determinado de questões

quizstruct.name = 'LAB11au'; %data1
% quizstruct.name = 'LAB10au2N3819';

quizstruct.question.type = 'cloze';

parname={'Rd'};
parunit={'&Omega;'};

% Vgs=[0 -1 -2 -3 -4 -5]; % Data1
% Vgs=[0 -0.2 -0.4 -0.6 -0.8 -1.0 -1.2 -1.4 -2]; % Data2
data=data1;
% data=data2;
% [x,y]=size(Xu);
% nq=randperm(y,sortnquestions); % escolha as questoes
for q=1:1
%     n=nq(q);
    parstr=param2str(2.2e3 ,parname,parunit);
    quizstruct.question.name{q}=[quizstruct.name 'q' num2str(q,'%04i') ' (' parstr ')']; % Gera nome da questão
    
    figlegstr=['Figura 1: Considere o MOSFET sendo o contido no CI4007, ' parstr ];
    figstr=['<p style="text-align: left;">' pngfigstr '</p><p style="text-align: left;">' figlegstr '<br></p>'];
    
    % Vcc=[3 6 9 12 15 18];
    tableheader1={'Vdd','V<sub>GS</sub> (V)<br />Medido/Escala','V<sub>RD</sub> (V)<br />Medido/Escala','I<sub>D</sub> (mA)<br />Calculado'};     
%         'V<sub>RB</sub> (V)<br />Medido/Escala','V<sub>RC</sub> (V)<br />Medido/Escala'};    
%     tableheader2={'Valor ','I<sub>B</sub> (&micro;A)<br />Calculado','I<sub>C</sub> (mA)<br />Calculado','I<sub>E</sub> (mA)<br />Calculado',...
%         'I<sub>RB</sub> (&micro;A)<br />Calculado','I<sub>RC</sub> (mA)<br />Calculado', '&beta;<br />Calculado'};
    vtol=10/100; % Tolerância de 10%
    
    % [vBE,vCE,vCB,vRB,vRC,iB,iC,iE]
%     data1(q,y).signals(1).label
    
    for y=1:length(Vdd)
        tablebody1{y,1}=num2str(Vdd(y));%
        tablebody1{y,2}=clozeVmedido(data(q,y).signals(2).op,vtol);% Vgs
        tablebody1{y,3}=clozeVmedido(data(q,y).signals(1).op-data(q,y).signals(2).op,vtol);% VRd
        tablebody1{y,4}=clozeXcalc(abs(data(q,y).signals(7).op),vtol,1000);% Id
    end
%     
    [tabletext1]=clozetabgen(tablebody1,tableheader1); % Parece funcionar
%     
%     tablebody2{1,1}='Médio';%
%     tablebody2{1,2}=clozeXcalc(Ru1{q}(6),vtol,1000000);% Vsec
%     tablebody2{1,3}=clozeXcalc(Ru1{q}(7),vtol,1000);% Vd
%     tablebody2{1,4}=clozeXcalc(Ru1{q}(8),vtol,1000);% Vd
%     tablebody2{1,5}=clozeXcalc(Ru1{q}(6),vtol,1000000);% Vd
%     tablebody2{1,6}=clozeXcalc(Ru1{q}(7),vtol,1000);% Vd
%     tablebody2{1,7}=clozeXcalc(Ru1{q}(7)/Ru1{q}(6),vtol,1);% Vd
%     
%     [tabletext2]=clozetabgen(tablebody2,tableheader2); % Parece funcionar
    
    questionstr=['<p>Monte o circuito indicado na Figura 01 e faça as medições e cálculos indicados na tabela.'  figstr '<br></p>'];
    quizstruct.question.text{q}=[ questionstr ' <p>'  tabletext1  'Tabela 1: Grandezas calculadas e medidas com multímetro digital (Valor médio).<br></p>' ];
    disp(quizstruct.question.name{q}) % Mostra a questão
    quizstruct.question.generalfeedback{q}='';
    quizstruct.question.penalty{q}='0.25';
    quizstruct.question.hidden{q}='0';
end

quizstruct.questionnumbers = q; % Numero de questoes geradas.
quizstruct.xmlpath=[ pwd '\xmlfiles']; % Pasta com arquivos gerados
quizstruct.questionMAX=2500; % Numero de questoes por arquivo xml

%% Gera arquivo xml

% param2str(Xu(1,n),'&Omega;')
% Erro de codificação detectado e deve ser corrigido por um programador: $result->noticeyesno no longer supported in save_question.
cloze2moodle(quizstruct) % Exporta em arquivos xml



%% Build question
%Read circuit figure
pngfigstr=png2base64([pwd '\figs\LAB11au.png']);
% sortnquestions=8; % Escolha um numero determinado de questões

quizstruct.name = 'LAB11bu'; %data1
% quizstruct.name = 'LAB10au2N3819';

quizstruct.question.type = 'cloze';

parname={'Rd'};
parunit={'&Omega;'};

% Vgs=[0 -1 -2 -3 -4 -5]; % Data1
% Vgs=[0 -0.2 -0.4 -0.6 -0.8 -1.0 -1.2 -1.4 -2]; % Data2
data=data1;
% data=data2;
% [x,y]=size(Xu);
% nq=randperm(y,sortnquestions); % escolha as questoes
for q=1:1
%     n=nq(q);
    parstr=param2str(2.2e3 ,parname,parunit);
    quizstruct.question.name{q}=[quizstruct.name 'q' num2str(q,'%04i') ' (' parstr ')']; % Gera nome da questão
    
    figlegstr=['Figura 1: Considere o MOSFET sendo o de canal P contido no CI4007, ' parstr ];
    figstr=['<p style="text-align: left;">' pngfigstr '</p><p style="text-align: left;">' figlegstr '<br></p>'];
    
    % Vcc=[3 6 9 12 15 18];
    tableheader1={'Vdd','V<sub>GS</sub> (V)<br />Medido/Escala','V<sub>RD</sub> (V)<br />Medido/Escala','I<sub>D</sub> (mA)<br />Calculado'};     
%         'V<sub>RB</sub> (V)<br />Medido/Escala','V<sub>RC</sub> (V)<br />Medido/Escala'};    
%     tableheader2={'Valor ','I<sub>B</sub> (&micro;A)<br />Calculado','I<sub>C</sub> (mA)<br />Calculado','I<sub>E</sub> (mA)<br />Calculado',...
%         'I<sub>RB</sub> (&micro;A)<br />Calculado','I<sub>RC</sub> (mA)<br />Calculado', '&beta;<br />Calculado'};
    vtol=10/100; % Tolerância de 10%
    
    % [vBE,vCE,vCB,vRB,vRC,iB,iC,iE]
%     data1(q,y).signals(1).label
    
    for y=1:length(Vdd)
        tablebody1{y,1}=num2str(Vdd(y));%
        tablebody1{y,2}=clozeVmedido(data(q,y).signals(2).op,vtol);% Vgs
        tablebody1{y,3}=clozeVmedido(data(q,y).signals(1).op-data(q,y).signals(2).op,vtol);% VRd
        tablebody1{y,4}=clozeXcalc(abs(data(q,y).signals(7).op),vtol,1000);% Id
    end
%     
    [tabletext1]=clozetabgen(tablebody1,tableheader1); % Parece funcionar

    questionstr=['<p>Monte o circuito indicado na Figura 01 e faça as medições e cálculos indicados na tabela.'  figstr '<br></p>'];
    quizstruct.question.text{q}=[ questionstr ' <p>'  tabletext1  'Tabela 1: Grandezas calculadas e medidas com multímetro digital (Valor médio).<br></p>' ];
    disp(quizstruct.question.name{q}) % Mostra a questão
    quizstruct.question.generalfeedback{q}='';
    quizstruct.question.penalty{q}='0.25';
    quizstruct.question.hidden{q}='0';
end

quizstruct.questionnumbers = q; % Numero de questoes geradas.
quizstruct.xmlpath=[ pwd '\xmlfiles']; % Pasta com arquivos gerados
quizstruct.questionMAX=2500; % Numero de questoes por arquivo xml


%% Build question
%Read circuit figure

quizstruct.sortnquestions=250; % Escolha um numero determinado de questões
quizstruct.name = 'LAB10a'; % Nome da questão
quizstruct.figname = 'LAB10a'; % Nome da figura
quizstruct.parname={'Rg','Rd','Vgs','Vdd'};
quizstruct.parunit={'&Omega;','&Omega;',' V',' V'};
quizstruct.Xu=Xu; % Matriz com parâmetros de simulação


quizstruct.Ru=Ru1; % Matriz com resultados de simulação {'ICC'}{'IRB'}{'IRC'}{'IC'}{'VEE'}{'Veb'}{'Vec'}{'Vbc'}



quizstruct.figlegendastr='Figura 1: Considere '; % Legenda da figura
quizstruct.perguntastr='Para o circuito apresentado na Figura 1, encontre:'; % Enunciado da questão

quizstruct.question.str={'Corrente na Base (iB):','Corrente no Coletor (iC):','Corrente no Emissor (iE):','Tensão vEC:', 'Tensão vEB:','Tensão vBC:'};
quizstruct.question.units={'A','A','A','V','V','V'};
iopts=2:4;
vopts=6:8; % Vetor com tensões
quizstruct.question.crt=[1 3 2 2 1 3]; % Opção correta 
quizstruct.question.nopts(1,:)=iopts; % Numero de opções
quizstruct.question.nopts(2,:)=iopts; % Numero de opções
quizstruct.question.nopts(3,:)=iopts; % Numero de opções
quizstruct.question.nopts(4,:)=vopts; % Numero de opções
quizstruct.question.nopts(5,:)=vopts; % Numero de opções
quizstruct.question.nopts(6,:)=vopts; % Numero de opções

quizstruct = choiceclozegen(quizstruct); % Gera as questões







%% Plots   
figure
plot(datatran(n).time,datatran(n).signals(8).values)
grid on
% {datatran(n).signals(:).label}

% 'Vcc' 'Vvb' 'Vvc' 'Vvo' 'Vvi' 'IcQ1' 'IbQ1' 'IeQ1' 'IC2' 'IC1' 'IR3' 'IR2' 'IR1' 'IV2' 'IV1'


figure
plot(datatran(n).time,datatran(n).signals(7).values)
hold all
plot(datatran2(n).time,datatran2(n).signals(7).values)


figure
plot(datatran(n).time,ieCC)  
figure
plot(datatran(n).time,icCC)



    

