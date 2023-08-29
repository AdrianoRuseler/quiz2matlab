function chart=signal2htmlchart(chartdata)

% chartdata=circuits{1}.PSIMCMD.data;
npts=100; % pontos por plot
N = length(chartdata.time);
ind = round(linspace(1,N,npts));

t=1;
htmlchart{t}='<div class="container-sm border">'; t=t+1;
htmlchart{t}=['<canvas id="line-chart-' chartdata.blockName '"></canvas>']; t=t+1;
htmlchart{t}='</div>'; t=t+1;
htmlchart{t}=' '; t=t+1;
htmlchart{t}=['<script> new Chart(document.getElementById("line-chart-' chartdata.blockName '"), { type : ''line'', data : {']; t=t+1;

xlabel=chartdata.time(ind)';
htmlchart{t}=['labels : [' regexprep(num2str(xlabel),'\s+',', ') '],']; t=t+1;
htmlchart{t}='datasets : [ '; t=t+1;

vars={chartdata.signals.label}; % Get variables
nvars=length(vars); % number of variables

for v=1:nvars
    % disp(vars{v})
    tmpvar=chartdata.signals(v).values(ind)';
    htmlchart{t}=['{ data : [ ' regexprep(num2str(tmpvar),'\s+',', ') '],']; t=t+1;
    htmlchart{t}=['label : "' vars{v} '"},']; t=t+1;
end

htmlchart{t}='] } }); </script>'; % t=t+1;


chart='';
for t=1:length(htmlchart)
    chart=[chart htmlchart{t}];
end


% B = erase(real2eng(tmp{h}{i},'')," ")

% for i=1:length(htmlchart)
%     disp(htmlchart{i})
% end
