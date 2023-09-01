function ploty=signal2htmlploty(plotytdata,visible)

% plotytdata=circuits{1}.PSIMCMD.data;

t=1;
htmlploty{t}=['<div id="plotly-' plotytdata.blockName '"></div>']; t=t+1;
htmlploty{t}='<script>'; t=t+1;

vars={plotytdata.signals.label}; % Get variables
nvars=length(vars); % number of variables
legendonly=~contains(vars,visible);

tracex = ['x: ['  regexprep(num2str(plotytdata.time'),'\s+',', ') '],'];

for v=1:nvars
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



htmlploty{t}='var data = [trace01';
for v=2:nvars
    htmlploty{t}=[htmlploty{t} ', trace' num2str(v,'%02i')];
end
htmlploty{t}=[htmlploty{t} '];'];
t=t+1;

htmlploty{t}=['var layout = { title:''' plotytdata.blockName ''' };']; t=t+1;
htmlploty{t}=['Plotly.newPlot(''plotly-' plotytdata.blockName ''' , data)']; t=t+1;
htmlploty{t}='</script>'; % t=t+1;

ploty='';
for t=1:length(htmlploty)
    ploty=[ploty htmlploty{t}];
end


% for i=1:length(htmlploty)
%     disp(htmlploty{i})
% end
