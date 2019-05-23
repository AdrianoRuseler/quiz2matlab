
% Converts number to multimeter scale
function [scalecell] = num2scale(number,unitstr)

switch unitstr
    case 'V' % Voltage
        escalaVstr={'200 mV','2 V','20 V','200 V','1 kV'};
        escalaVnum=[0.2 2 20 200 1000];
        indp=find((escalaVnum-abs(number))>0); % Escolhe a melhor escala.
        strVe='{1:MULTICHOICE:';
        for a=1:length(escalaVstr)
            if a==indp(1)
                strVe = strcat(strVe,['~%100%' escalaVstr{a} ]);
            else
                strVe = strcat(strVe,['~' escalaVstr{a} ]);
            end
        end
        scalecell = strcat(strVe,'}');
        
        
    case 'A' % Current
        
    case '&Omega;' % Resistance
        
        
    otherwise
        
end


