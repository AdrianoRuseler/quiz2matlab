% =========================================================================
% *** simview2matlab 
% *** Converts PSIM ini generated in Simview Settings to Struct data
% ***  
% =========================================================================
% ***
% *** The MIT License (MIT)
% *** 
% *** Copyright (c) 2019 AdrianoRuseler
% *** 
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% *** 
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% *** 
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================

function circuit = simview2matlab(circuit)

% circuit.PSIMCMD.simview=[]; % Limpa campo? Why??
tic
% Read ini file
inistruct = ini2struct(circuit.PSIMCMD.inifile);  
if isempty(inistruct)
    return
end

% Creates the simview structure
simview.main.xaxis=inistruct.x1main.xaxis;
simview.main.numscreen=str2double(inistruct.x1main.numscreen);
simview.main.xfrom= str2double(inistruct.x1main.xfrom); % x limit
simview.main.xto= str2double(inistruct.x1main.xto);
simview.main.scale= str2double(inistruct.x1main.scale);
simview.main.xinc= str2double(inistruct.x1main.xinc);
simview.main.fft= logical(str2double(inistruct.x1main.fft));
simview.main.default= logical(str2double(inistruct.x1main.default));

simview.view.fontheight=str2double(inistruct.x1view.fontheight);
simview.view.bkcolor=str2double(inistruct.x1view.bkcolor);
simview.view.fontweight=str2double(inistruct.x1view.fontweight);
simview.view.grid=logical(str2double(inistruct.x1view.grid));
simview.view.fgcolor=str2double(inistruct.x1view.fgcolor);
simview.view.fontitalic=str2double(inistruct.x1view.fontitalic);
simview.view.gridcolor=str2double(inistruct.x1view.gridcolor);
simview.view.hideaxistext=logical(str2double(inistruct.x1view.hideaxistext));


for s=0:str2double(inistruct.x1main.numscreen)-1 % Screens Loop
    eval(['simview.screen' num2str(s) '.scale=str2double(inistruct.x1screen' num2str(s) '.scale);'])
    eval(['simview.screen' num2str(s) '.yinc=str2double(inistruct.x1screen' num2str(s) '.yinc);'])
    eval(['simview.screen' num2str(s) '.default=logical(str2double(inistruct.x1screen' num2str(s) '.default));'])
    eval(['simview.screen' num2str(s) '.yfrom=str2double(inistruct.x1screen' num2str(s) '.yfrom);'])
    eval(['simview.screen' num2str(s) '.curvecount=str2double(inistruct.x1screen' num2str(s) '.curvecount);'])
    eval(['simview.screen' num2str(s) '.db=logical(str2double(inistruct.x1screen' num2str(s) '.db));'])
    eval(['simview.screen' num2str(s) '.auto=logical(str2double(inistruct.x1screen' num2str(s) '.auto));'])
    eval(['simview.screen' num2str(s) '.yto=str2double(inistruct.x1screen' num2str(s) '.yto);'])
    
    % Curves Loop
    for c=0:str2double(eval(['inistruct.x1screen' num2str(s) '.curvecount']))-1
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.formula=inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_formula;'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.label=inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_label;'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.symbol=str2double(inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_symbol);'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.source=str2double(inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_source);'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.connect=str2double(inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_connect);'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.thickness=str2double(inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_thickness);'])
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.color=str2double(inistruct.x1screen' num2str(s) '.curve_'  num2str(c) '_color);'])   
    end
end


%% Verifies PSIM variables to be compatible with MATLAB
xfrom = simview.main.xfrom;
xto = simview.main.xto;

xdata=circuit.PSIMCMD.data.time(circuit.PSIMCMD.data.time>=xfrom&circuit.PSIMCMD.data.time<=xto);
if isempty(xdata)
    warndlg('Vetor xdata vazio!! Salve o arquivo *.ini via SINVIEW!!','!! Warning !!')
end
simview.main.xdata=xdata; % save time data (x axis data)

for i=1:length(circuit.PSIMCMD.data.signals) % Associa dados a cada vari�vel de medi��o
    ydata = circuit.PSIMCMD.data.signals(:,i).values(circuit.PSIMCMD.data.time>=xfrom&circuit.PSIMCMD.data.time<=xto);
    if isempty(xdata)
        warndlg('Vetor ydata vazio!! Salve o arquivo *.ini via SINVIEW!!','!! Warning !!')
    end
    assignin('base',circuit.PSIMCMD.data.signals(i).label,ydata); % Cada leitura vira uma vari�vel
end

% plot(xdata,ydata)
% Evaluate screen formula
for s=0:simview.main.numscreen-1 % Screens Loop
    for c=0:eval(['simview.screen' num2str(s) '.curvecount'])-1 % Curves Loop
        formula{s+1,c+1}= eval(['simview.screen' num2str(s) '.curve' num2str(c) '.formula']);
        if verLessThan('matlab', '8.2.0')
            form = genvarname(formula{s+1,c+1});
%             modified=1; % Just force update
        else
            [form, ~] = matlab.lang.makeValidName(formula{s+1,c+1},'ReplacementStyle','delete'); % Problem here for minus signal
        end          
        formuladata=evalin('base',form);        
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.data=formuladata;'])        
        ymean=mean(formuladata);
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.ymean=ymean;'])
        ymax=max(formuladata);
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.ymax=ymax;'])
        ymin=min(formuladata);
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.ymin=ymin;'])    
        ydelta=abs(ymax-ymin);
        eval(['simview.screen' num2str(s) '.curve' num2str(c) '.ydelta=ydelta;']) 
    end
end

% Clear variables from workspace
% disp('Clear variables from workspace:')
for i=1:length(circuit.PSIMCMD.data.signals)
    evalin('base', ['clear ' circuit.PSIMCMD.data.signals(i).label])     
end

simview.runtime=toc;

%% Save data struct
circuit.PSIMCMD.simview=simview;

disp(['Dados do arquivo ' circuit.PSIMCMD.inifile ' importados!'])

%% Plota dados

% psim2plot(circuit); % Plota resposta

% TODO:

