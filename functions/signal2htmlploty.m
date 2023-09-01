function ploty=signal2htmlploty(plotytdata,visible,rmtrace)

% plotytdata=circuits{1}.PSIMCMD.data;

ploty='';
vars={plotytdata.signals.label}; % Get variables
nvars=length(vars); % number of variables

if nargin < 3
    dip('Less than 3! Return!')
    return
end

if isempty(visible)
    legendonly=false(1,nvars);
else
    legendonly=~contains(vars,visible);
end

if isempty(rmtrace)
    rmdata=false(1,nvars);
else
    rmdata=contains(vars,rmtrace);
end


t=1;
htmlploty{t}=['<div id="plotly-' plotytdata.blockName '"></div>']; t=t+1;
htmlploty{t}='<script>'; t=t+1;

tracex = ['x: ['  regexprep(num2str(plotytdata.time'),'\s+',', ') '],'];

for v=1:nvars
    if rmdata(v)
        continue
    end
    htmlploty{t}=['var trace' num2str(v,'%02i') ' = {']; t=t+1;
    htmlploty{t}=tracex; t=t+1;
    tracey = ['y: ['  regexprep(num2str(plotytdata.signals(v).values'),'\s+',', ') '],'];
    htmlploty{t}=tracey; t=t+1;
    htmlploty{t}='mode: ''lines'','; t=t+1;
    if legendonly(v) % visible: 'legendonly'
        htmlploty{t}='visible: ''legendonly'','; t=t+1;
    end
    htmlploty{t}=['name: ''' vars{v} '''' ]; t=t+1;
    htmlploty{t}='};'; t=t+1;

end

% Define Data
htmlploty{t}=[' var data' plotytdata.blockName ' = ['];
for v=1:nvars
    if rmdata(v)
        continue
    end
    if v==nvars
        htmlploty{t}=[htmlploty{t} 'trace' num2str(v,'%02i') ];
    else
        htmlploty{t}=[htmlploty{t} 'trace' num2str(v,'%02i') ' ,'];
    end
end
htmlploty{t}=[htmlploty{t} '];']; t=t+1;

% Define Layout
htmlploty{t}=[' var layout = { title:''' plotytdata.blockName ''' };']; t=t+1;
% Display using Plotly
htmlploty{t}=[' Plotly.newPlot(''plotly-' plotytdata.blockName ''' , data' plotytdata.blockName  ')']; t=t+1;
htmlploty{t}='</script>'; % t=t+1;

for t=1:length(htmlploty)
    ploty=[ploty htmlploty{t}];
end


% for i=1:length(htmlploty)
%     disp(htmlploty{i})
% end
