% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2021 AdrianoRuseler
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

% quiz.plot{p}.legend='Figura 2: Formas de onda provenientes da simulação do circuito apresentado na Figura 1.';
% quiz.plot{p}.curves={'ia','ib','ic'};
% quiz.plot{p}.curleg={'opt1','opt2','opt3','opt4'};
% quiz.plot{p}.yyaxis={'right','left','left','left'};
% quiz.plot{p}.scale=0.6; % Plot scale
% quiz.plot{p}.FontSize=7; % Plot FontSize
% quiz.plot{p}.LineStyle={'-','--',':','-.'};
% quiz.plot{p}.LineWidth=1.5;
% quiz.plot{p}.title='title';
% quiz.plot{p}.xlabel='xlabel';
% quiz.plot{p}.ylabel='Amplitude';
% quiz.plot{p}.yunit='A';

function circuit=psimplothtml(circuit)

% create plot
labels={circuit.PSIMCMD.data.signals.label}; % Data variables
% time = circuit.PSIMCMD.data.time*1000;

% vector2eng()
% [number,expstr,mult] = vector2eng(vector,unitstr)
[time,texpstr] = vector2eng(circuit.PSIMCMD.data.time,'s');

timemax=max(time);
timemin=min(time);

% Number of plots
for p=1:length(circuit.quiz.plot)
    hfig{p}=figure; % Create fig handle
    haxes{p}=axes;
    if ~isfield(circuit.quiz.plot{p},'scale')
        circuit.quiz.plot{p}.scale=0.6; %
    end

    pp=get(hfig{p},'PaperPosition')*circuit.quiz.plot{p}.scale; %
    set(hfig{p},'PaperPosition',pp)

    grid on
    hold on

    % get(hfig{p});
    % set(gca,'color', [0.8 0.8 0.8]);

    if isfield(circuit.quiz.plot{p},'FontSize')
        set(haxes{p},'FontSize',circuit.quiz.plot{p}.FontSize);
    else
        set(haxes{p},'FontSize',7);
    end

    if ~isfield(circuit.quiz.plot{p},'LineWidth')
        circuit.quiz.plot{p}.LineWidth=1.5;
    end


    if ~isfield(circuit.quiz.plot{p},'yunit')
        circuit.quiz.plot{p}.yunit='';
    end
    % yyaxis left
    % yyaxis right
    nc=length(circuit.quiz.plot{p}.curves); % Number of curves per plot

    if ~isfield(circuit.quiz.plot{p},'curleg')
        % A, B, C...
        for c=1:nc
            circuit.quiz.plot{p}.curleg{c} = char(64+c);
        end
    end

    if nc==1
        optind=find(contains(labels,circuit.quiz.plot{p}.curves{1},'IgnoreCase',true));
        if ~isempty(optind) % Label found
            [number,yprefixstr{p}] = vector2eng(circuit.PSIMCMD.data.signals(optind).values,circuit.quiz.plot{p}.yunit);
        end
    else
        mx=[];
        for c=1:nc
            optind=find(contains(labels,circuit.quiz.plot{p}.curves{c},'IgnoreCase',true));
            if ~isempty(optind) % Label found
                mx = [mx circuit.PSIMCMD.data.signals(optind).values];
            end
        end
        [number,yprefixstr{p}] = matrix2eng(mx,circuit.quiz.plot{p}.yunit);
    end



    if isfield(circuit.quiz.plot{p},'yyaxis')
        yyaxis(circuit.quiz.plot{p}.yyaxis{c})
    end

    if isfield(circuit.quiz.plot{p},'LineStyle')
        plot(haxes{p},time,number,circuit.quiz.plot{p}.LineStyle{c},'LineWidth',circuit.quiz.plot{p}.LineWidth)
    else
        plot(haxes{p},time,number,'LineWidth',circuit.quiz.plot{p}.LineWidth)
    end

    %     xlim([timemin timemax])
    set(haxes{p},'XLim',[timemin timemax])

    legend(haxes{p},circuit.quiz.plot{p}.curleg,'Interpreter','latex')

    if isfield(circuit.quiz.plot{p},'title')
        title(haxes{p},circuit.quiz.plot{p}.title,'Interpreter','latex')
    end

    if isfield(circuit.quiz.plot{p},'ylabel')
        ylabel(haxes{p},[circuit.quiz.plot{p}.ylabel yprefixstr{p}],'Interpreter','latex')
    end

    if isfield(circuit.quiz.plot{p},'xlabel')
        xlabel(haxes{p},circuit.quiz.plot{p}.xlabel,'Interpreter','latex')
    else
        xlabel(['Tempo' texpstr],'Interpreter','latex')
    end

    % save as png
    pngfile=[circuit.PSIMCMD.simsdir circuit.PSIMCMD.data.blockName '.png'];
    print(hfig{p},pngfile,'-dpng')
    close(hfig{p})

    imgout=png2mdl(pngfile,'classic');

    % Read png file and encode
    pngimgstr=png2base64(imgout); % create html code to store img

    % Generate html code
    circuit.quiz.plot{p}.html = ['<p style="text-align: left;">' pngimgstr '</p><p style="text-align: left;">' circuit.quiz.plot{p}.legend '<br></p>'];
end
