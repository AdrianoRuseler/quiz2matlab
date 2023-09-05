function table=signal2htmltable(signaltable)

table='';

t=1;
htmltable{t}='<table class="table table-hover table-bordered">'; t=t+1;
htmltable{t}='<thead class="table-success">'; t=t+1;
htmltable{t}='<tr>'; t=t+1;

fields=fieldnames(signaltable); % Get fields names
[f,~]=size(fields);

d=length({signaltable.(fields{1})}); % number of table itens

% generate table header
for h=1:f
    tmp{h,:}={signaltable.(fields{h})};
    htmltable{t}=['<th>' fields{h} '</th>']; t=t+1;
end

htmltable{t}='</tr>'; t=t+1;
htmltable{t}='</thead>'; t=t+1;
htmltable{t}='<tbody>'; t=t+1;


for i=1:d % for each item in table
    htmltable{t}='<tr>'; t=t+1;
    for h=1:f
        if ischar(tmp{h}{i}) || isstring(tmp{h}{i})
            htmltable{t}=['<td>' tmp{h}{i} '</td>']; t=t+1;
        elseif isscalar(tmp{h}{i})
            htmltable{t}=['<td>' erase(real2eng(tmp{h}{i},'')," ") '</td>']; t=t+1;
        elseif isvector(tmp{h}{i})
            htmltable{t}='<td>Vector</td>'; t=t+1;
        elseif isempty(tmp{h}{i})
            htmltable{t}='<td></td>'; t=t+1;
        else
            htmltable{t}='<td></td>'; t=t+1;
        end
    end
    htmltable{t}='</tr>'; t=t+1;
end

htmltable{t}='</tbody>'; t=t+1;
htmltable{t}='</table>';

% Concatenate
for t=1:length(htmltable)
    table=[table htmltable{t}];
end

