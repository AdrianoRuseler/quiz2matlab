function ploty=signal2htmlploty(plotytdata,opts)

% plotytdata=circuits{1}.PSIMCMD.data;
% opts.visible,opts.rmtrace

ploty='';
vars={plotytdata.signals.label}; % Get variables
nvars=length(vars); % number of variables

if nargin < 2
    dip('Less than 2! Return!')
    return
end

if isempty(opts.visible)
    legendonly=false(1,nvars);
else
    legendonly=~contains(vars,opts.visible);
end

if isempty(opts.rmtrace)
    rmdata=false(1,nvars);
else
    rmdata=contains(vars,opts.rmtrace);
end

% disp(opts.qname)

t=1;
htmlploty{t}=['<div id="plotly-' opts.qname '"></div>']; t=t+1;
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
htmlploty{t}=[' var data' opts.qname ' = ['];
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
htmlploty{t}=[' var layout = { title:''' opts.qname ''', xaxis: {title: ''Time (s)''}, yaxis: {title: ''Value''}};']; t=t+1;
% Display using Plotly
htmlploty{t}=[' Plotly.newPlot(''plotly-' opts.qname ''' , data' opts.qname  ', layout)']; t=t+1;
htmlploty{t}='</script>'; % t=t+1;

for t=1:length(htmlploty)
    ploty=[ploty htmlploty{t}];
end

% for i=1:length(htmlploty)
%     disp(htmlploty{i})
% end
