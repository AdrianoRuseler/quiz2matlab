% =========================================================================
%
%  The MIT License (MIT)
%
%  Copyright (c) 2019 AdrianoRuseler
%
%  Permission is hereby granted, free of charge, to any person obtaining a copy
%  of this software and associated documentation files (the Software), to deal
%  in the Software without restriction, including without limitation the rights
%  to use, copy, modify, merge, publish, distribute, sublicense, andor sell
%  copies of the Software, and to permit persons to whom the Software is
%  furnished to do so, subject to the following conditions
%
%  The above copyright notice and this permission notice shall be included in all
%  copies or substantial portions of the Software.
%
%  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%  SOFTWARE.
%
% =========================================================================
% TODO: Ajustar limites xlime ylim

function [circuit]=simview2plot(circuit)

% status=0; % We have to return something

if nargin <1 % input file not supplied
    % Try to Load SCOPEdata structure
%     status =1;
    return
end

%% All data must be available here:

if ~isfield(circuit.PSIMCMD,'simview')
    disp('No simview data field!')
%     status=1;
    return
elseif isempty(circuit.PSIMCMD.simview)
    disp('No data in simview filed!')
%     status=1;
    return
end
    
circuit.PSIMCMD.simview.main.hfig=figure; % Create fig handle
xdata=circuit.PSIMCMD.simview.main.xdata*1e3;

for s=0:circuit.PSIMCMD.simview.main.numscreen-1
    haxes = subplot(circuit.PSIMCMD.simview.main.numscreen,1,s+1); % Gera subplot
    hold(haxes,'all')
    grid on
    eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.handle=haxes;']) % atribue handle
    legString={};
    for c=0:eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curvecount'])-1 % Curves Loop
        %         disp('Plots!!')
        ydata = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.data']);
        legString{c+1} = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.label']);
        
        thickness = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.thickness']);
        
        color = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.color']); % Get curve color       
        colorstr = dec2hex(color,6); % Convert color to hex BGR
        colorstr2=[colorstr(5:6) colorstr(3:4) colorstr(1:2)]; % Put in order RGB
        rgb = reshape(sscanf(colorstr2.','%2x'),3,[]).'/255; % https://www.mathworks.com/matlabcentral/fileexchange/46289-rgb2hex-and-hex2rgb
        
        symbol = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.symbol']); % Get symbol data
        Markers={'none','o','s','^','*'}; % 

        plot(haxes,xdata,ydata,'LineWidth',thickness,'Color',rgb,'Marker',Markers{symbol+1}) %% Plot data
        
        ymax = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.ymax']);
        ymin = eval(['circuit.PSIMCMD.simview.screen' num2str(s) '.curve' num2str(c) '.ymin']);
        ylim([ymin ymax]) % Set y limits                
        
    end
    %     axis tight
    %     xlim(haxes,[conv.PSIMCMD.printtime conv.PSIMCMD.totaltime]*1e3); % Aqui está o problema
    xlim(haxes,[xdata(1) xdata(end)]);
    legend(haxes,legString,'Interpreter','latex');
    if ~s==circuit.PSIMCMD.simview.main.numscreen-1
        set(haxes,'XTickLabel',[])
        %         title(['RA: ' num2str(circuit.RA)],'Interpreter','latex')
    end
end

xlabel('Tempo (ms)','Interpreter','latex')


% ylabel(circuit.simview.screen0.handle,'Tens\~ao de sa\''ida (V)','Interpreter','latex')
% ylabel(circuit.simview.screen1.handle,'Corrente no indutor (A)','Interpreter','latex')

% linkaxes([circuit.PSIMCMD.simview.screen0.handle circuit.PSIMCMD.simview.screen1.handle],'x') % Linka eixos x
% get(PSIMdata.simview.main.hfig,'Position')
% get(PSIMdata.simview.screen1.handle,'Position')

%  set(circuit.PSIMCMD.simview.screen0.handle,'Position',[0.15 0.55 0.75 0.4]);
%  set(circuit.PSIMCMD.simview.screen1.handle,'Position',[0.15 0.1 0.75 0.4]);
 
 
%  print(circuit.PSIMCMD.simview.main.hfig,[circuit.latex.figsdir '\' circuit.tipo circuit.prefixname],'-depsc') % Exporta figura no formato .eps
imgin=[circuit.PSIMCMD.simsdir circuit.PSIMCMD.data.blockName '.png'];

print(circuit.PSIMCMD.simview.main.hfig,imgin,'-dpng')    

circuit.PSIMCMD.simview.figs.pngfigstr=png2base64(imgin);


imgout=[circuit.PSIMCMD.simsdir circuit.PSIMCMD.data.blockName '_clean.png'];
pngchangewhite(imgin,imgout,'clean')
circuit.PSIMCMD.simview.figs.pngfigstrclean=png2base64(imgout);
delete(imgout)

imgout=[circuit.PSIMCMD.simsdir circuit.PSIMCMD.data.blockName '_boost.png'];
pngchangewhite(imgin,imgout,'boost')
circuit.PSIMCMD.simview.figs.pngfigstrboost=png2base64(imgout);
delete(imgout)

winopen(circuit.PSIMCMD.simsdir)
%  print('PlotTest.png','-dpng')
