
function [tbj]=tbj2quiz(circuit,device)

% Name:       q1
% Model:    bc546b
% Ib:       7.25e-05
% Ic:       3.18e-02
% Vbe:      7.32e-01
% Vbc:     -4.61e+01
% Vce:      4.68e+01

% quiz.table{1,2}.vartype='tbj'; % Single only
% device='q1';

tmpstr=strsplit(device,':'); %

tbj.name = tmpstr{1};
tbj.type = tmpstr{2};

tbj.jvon = 0.45; % On voltage for junction PN
tbj.vcesat = 0.25; % Sat if less than this
% tbj.betasat = 50; % Sat if less than this
% tbj.beon;
% tbj.bcon;

if isfield(circuit,'model')
    for ml=1:length(circuit.model) % number of .model lines
        for p=1:length(circuit.model(ml).parnamesim)
            tbj.(circuit.model(ml).parnamesim{p})=circuit.model(ml).parvalue(p);
        end
    end
end


ndevgroups=length(circuit.LTspice.log.sdop); % Number os groups, TBJ, Fet...
for g=1:ndevgroups
    devnames={circuit.LTspice.log.sdop{g}.Name}; % Data variables
    devfields{g} = fieldnames(circuit.LTspice.log.sdop{g}); % Grupo g
    devind=find(contains(devnames{:},tbj.name,'IgnoreCase',true));
    
    if devind % Found device in group
        tbj.fields = devfields{g};
        optind=g;
        for p=1:length(devfields{g})
            tbj.(devfields{g}{p})=circuit.LTspice.log.sdop{g}.(devfields{g}{p})(devind);
        end
    end
end


tbj.Ie=tbj.Ib+tbj.Ic;
tbj.re=tbj.Rpi/(tbj.BetaDC+1);
tbj.Veb=-tbj.Vbe;
tbj.Vcb=-tbj.Vbc;
tbj.Vec=-tbj.Vce;

% disp(tbj)

switch tbj.type
    case 'npn'
        
        % NPN
        if tbj.Vbe < tbj.jvon % off
            tbj.pbe='{1:MULTICHOICE:~Direta~%100%Reversa}';
            tbj.beon = 0;
        else
            tbj.pbe='{1:MULTICHOICE:~%100%Direta~Reversa}';
            tbj.beon = 1;
        end
                
        % NPN
        if tbj.Vbc <= 0.1 % off
            tbj.pbc='{1:MULTICHOICE:~Direta~%100%Reversa}';
            tbj.bcon = 0;
        else
            tbj.pbc='{1:MULTICHOICE:~%100%Direta~Reversa}';
            tbj.bcon = 1;
        end
        
        % NPN
        tbj.sat=0; % is saturate
        tbj.ampmode=0;
        if (tbj.beon&&tbj.bcon) %||(tbj.Vce<tbj.vcesat)||(tbj.BetaDC<tbj.betasat) % Saturado
            tbj.mop='{1:MULTICHOICE:~Corte~%100%Saturação~Ativo Direto~Ativo Reverso}';
            tbj.sat=1;
            disp('Modo Saturado!')
        elseif tbj.beon
            tbj.mop='{1:MULTICHOICE:~Corte~Saturação~%100%Ativo Direto~Ativo Reverso}';
            tbj.ampmode=1;
        elseif tbj.bcon
            tbj.mop='{1:MULTICHOICE:~Corte~Saturação~Ativo Direto~%100%Ativo Reverso}';
        else
            tbj.mop='{1:MULTICHOICE:~%100%Corte~Saturação~Ativo Direto~Ativo Reverso}';
        end
        
    case 'pnp'
        % PNP
        if tbj.Veb < tbj.jvon % off
            tbj.peb='{1:MULTICHOICE:~Direta~%100%Reversa}';
            tbj.ebon = 0;
        else
            tbj.peb='{1:MULTICHOICE:~%100%Direta~Reversa}';
            tbj.ebon = 1;
        end
        
        % PNP
        if tbj.Vcb <= 0.1 % off
            tbj.pcb='{1:MULTICHOICE:~Direta~%100%Reversa}';
            tbj.cbon = 0;
        else
            tbj.pcb='{1:MULTICHOICE:~%100%Direta~Reversa}';
            tbj.cbon = 1;
        end
        
        
        % NPN
        tbj.sat=0; % is saturate
        tbj.ampmode=0;
        if (tbj.ebon&&tbj.cbon) %||(tbj.Vce<tbj.vcesat)||(tbj.BetaDC<tbj.betasat) % Saturado
            tbj.mop='{1:MULTICHOICE:~Corte~%100%Saturação~Ativo Direto~Ativo Reverso}';
            tbj.sat=1;
            disp('Modo Saturado!')
        elseif tbj.ebon
            tbj.mop='{1:MULTICHOICE:~Corte~Saturação~%100%Ativo Direto~Ativo Reverso}';
            tbj.ampmode=1;
        elseif tbj.cbon
            tbj.mop='{1:MULTICHOICE:~Corte~Saturação~Ativo Direto~%100%Ativo Reverso}';
        else
            tbj.mop='{1:MULTICHOICE:~%100%Corte~Saturação~Ativo Direto~Ativo Reverso}';
        end
        
    otherwise
         disp('TBJ type not found!!!!')
         disp(tbj)
       
end