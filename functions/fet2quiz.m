
function [fet]=fet2quiz(circuit,device)

% circuit=tmpcircuits{1};
% device=quiz.fettype;

% quiz.table{1,2}.vartype='tbj'; % Single only
% device='q1';

tmpstr=strsplit(device,':'); %

fet.name = lower(tmpstr{1});
fet.type = lower(tmpstr{2});

% fet.jvon = 0.45; % On voltage for junction PN
% fet.vcesat = 0.25; % Sat if less than this
% tbj.betasat = 50; % Sat if less than this
% tbj.beon;
% tbj.bcon;

% labels={circuit.LTspice.log.sdop{:}.Name}; % Data variables
% optind=find(contains(labels{:},fet.name,'IgnoreCase',true)); % Find FET

% if isempty(optind)
%     disp('FET not FOUND!!')
%     return
% end
% 

if isfield(circuit,'model')
    for ml=1:length(circuit.model) % number of .model lines
        for p=1:length(circuit.model(ml).parnamesim)
            fet.(circuit.model(ml).parnamesim{p})=circuit.model(ml).parvalue(p);
        end
    end
end

ndevgroups=length(circuit.LTspice.log.sdop); % Number os groups, TBJ, Fet...
for g=1:ndevgroups
    devnames={circuit.LTspice.log.sdop{g}.Name}; % Data variables
    devfields{g} = fieldnames(circuit.LTspice.log.sdop{g}); % Grupo g
    devind=find(contains(devnames{:},fet.name,'IgnoreCase',true));
    
    if devind % Found device in group
        fet.fields = devfields{g};
        for p=1:length(devfields{g})
            fet.(devfields{g}{p})=circuit.LTspice.log.sdop{g}.(devfields{g}{p})(devind);
        end
    end    
end



% fet.fields = fieldnames(circuit.LTspice.log.sdop{optind}); % Get FET parameters

% Name:      j2          j1
% Model:    nfet        nfet
% Id:      3.60e-02    1.60e-02
% Vgs:     8.13e-06   -2.00e+00
% Vds:     8.12e+00    1.47e+01
% Gm:      1.20e-02    8.00e-03
% Gds:     0.00e+00    0.00e+00
% Cgs:     0.00e+00    0.00e+00
% Cgd:     0.00e+00    0.00e+00
switch fet.type
    case 'njf'
        fet.Vgst=fet.Vgs-fet.Vto;
        if fet.Vgs>0
            fet.ok=0;
            disp('Vgs > 0 for NJF!')
        else
            fet.ok=1;
        end
        fet.rd=fet.Vds/fet.Id;
        fet.Idss=fet.Beta*fet.Vto^2;
        % FET operates in four region
        if fet.Vgst <=0 % Corte
            fet.mop='{1:MULTICHOICE:~%100%Região de Corte~Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=1;
            fet.sat=0;
        elseif fet.Vgst >= fet.Vds % OHM
            fet.mop='{1:MULTICHOICE:~Região de Corte~Região de Saturação~%100%Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=1;
            fet.corte=0;
            fet.sat=0;
        else % Reg. Sat.
            fet.mop='{1:MULTICHOICE:~Região de Corte~%100%Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=0;
            fet.sat=1;
        end
    case 'pjf'
        if fet.Vgs<0
            fet.ok=0;
            disp('Vgs < 0 for PJF!')
        else
            fet.ok=1;
        end
        fet.Vgst=fet.Vgs+fet.Vto;
        fet.rd=fet.Vds/fet.Id;
        fet.Idss=-fet.Beta*fet.Vto^2;
        if fet.Vgst >=0 % Corte
            fet.mop='{1:MULTICHOICE:~%100%Região de Corte~Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=1;
            fet.sat=0;
        elseif fet.Vgst <= fet.Vds % OHM
            fet.mop='{1:MULTICHOICE:~Região de Corte~Região de Saturação~%100%Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=1;
            fet.corte=0;
            fet.sat=0;
        else % Reg. Sat.
            fet.mop='{1:MULTICHOICE:~Região de Corte~%100%Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=0;
            fet.sat=1;
        end
        
    case 'nmos'       
        
        fet.Vgst=fet.Vgs-fet.Vto;
        fet.rd=fet.Vds/fet.Id;
%         fet.Idss=fet.Beta*fet.Vto^2;
        % FET operates in four region
        if fet.Vgst <=0 % Corte
            fet.mop='{1:MULTICHOICE:~%100%Região de Corte~Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=1;
            fet.sat=0;
        elseif fet.Vgst >= fet.Vds % OHM
            fet.mop='{1:MULTICHOICE:~Região de Corte~Região de Saturação~%100%Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=1;
            fet.corte=0;
            fet.sat=0;
        else % Reg. Sat.
            fet.mop='{1:MULTICHOICE:~Região de Corte~%100%Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=0;
            fet.sat=1;
        end
        
     case 'pmos'          
        fet.Vgst=-fet.Vgs+fet.Vto;
        fet.rd=fet.Vds/fet.Id;
%         fet.Idss=-fet.Beta*fet.Vto^2;
        if fet.Vgst <=0 % Corte
            fet.mop='{1:MULTICHOICE:~%100%Região de Corte~Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=1;
            fet.sat=0;
        elseif fet.Vgst >= -fet.Vds % OHM
            fet.mop='{1:MULTICHOICE:~Região de Corte~Região de Saturação~%100%Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=1;
            fet.corte=0;
            fet.sat=0;
        else % Reg. Sat.
            fet.mop='{1:MULTICHOICE:~Região de Corte~%100%Região de Saturação~Região Ôhmica~Região de Ruptura}'; % OP mode
            fet.ohm=0;
            fet.corte=0;
            fet.sat=1;
        end
    otherwise
        
end


