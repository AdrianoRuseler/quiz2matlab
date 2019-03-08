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
% Process simview data
function circuit = simview2data(circuit)


simview=circuit.PSIMCMD.simview;


% Verifies PSIM variables to be compatible with MATLAB
xfrom = simview.main.xfrom;
xto = simview.main.xto;

xdata=circuit.PSIMCMD.data.time(circuit.PSIMCMD.data.time>=xfrom&circuit.PSIMCMD.data.time<=xto);
if isempty(xdata)
    warndlg('Vetor xdata vazio!! Salve o arquivo *.ini via SINVIEW!!','!! Warning !!')
end
simview.main.xdata=xdata; % save time data (x axis data)

for i=1:length(circuit.PSIMCMD.data.signals) % Associa dados a cada variável de medição
    ydata = circuit.PSIMCMD.data.signals(:,i).values(circuit.PSIMCMD.data.time>=xfrom&circuit.PSIMCMD.data.time<=xto);
    if isempty(xdata)
        warndlg('Vetor ydata vazio!! Salve o arquivo *.ini via SINVIEW!!','!! Warning !!')
    end
    assignin('base',circuit.PSIMCMD.data.signals(i).label,ydata); % Cada leitura vira uma variável
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

% simview.runtime=toc;

circuit.PSIMCMD.simview=simview;


% TODO:

