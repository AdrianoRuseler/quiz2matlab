function html=k2table(kMap) % create html code to store file

% html=kMap;

[l,c]=size(kMap);

% <table class="table">

theadstr='<thead><tr>';
for j=1:c
    theadstr=[theadstr '<th>' kMap{1,j} '</th>'];
end
theadstr=[theadstr '</tr></thead>'];

tbodystr='<tbody>';
for i=2:l
    tbodystr=[tbodystr '<tr>'];
    for j=1:c
        if j==1
            tbodystr=[tbodystr '<td><strong>' kMap{i,j} '</strong></td>'];
        else
            switch kMap{i,j}
                case '0'
                    tbodystr=[tbodystr '<td>{1:MULTICHOICE:%100%0~1~X}</td>'];
                case '1'
                    tbodystr=[tbodystr '<td>{1:MULTICHOICE:0~%100%1~X}</td>'];
                otherwise
                    tbodystr=[tbodystr '<td>{1:MULTICHOICE:0~1~%100%X}</td>'];
            end
        end
    end
    tbodystr=[tbodystr '</tr>'];
end

html=['<div class="table-responsive-sm"><table class="table table-bordered table-hover" style="width:100px">' theadstr tbodystr '</table></div>'];



