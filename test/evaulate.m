function rate = evaulate(func, folder)
    imgPath = strcat('./',folder,'/'); % path to folder with images
    imgType = '*.jpg'; % all pictures need to be JPG
    images = dir([imgPath imgType]); % load all images in folder

    expr = '_|\.'; % expression used to split picture name

    count_success = 0;
    count_total = length(images);

    result = struct();

    for i = 1:length(images)
        splitStr = regexp(images(i).name, expr, 'split');
        set = char(splitStr(1));
        letter = char(splitStr(2));

        letter_return = func(images(i).name);

        if (letter == letter_return)
            success = 1;
            count_success = count_success + 1;
        else
            success = 0;
        end

        result.(set).(letter) = struct('return', letter_return, 'success', success);

    end

%     clc;
    print_result(result);

    rate = count_success / count_total * 100;
    disp([char(13),'Total success rate: ', num2str(rate), '%']);

end

function print_result(result)
    sets = fieldnames(result);
    
    for idx = 1:length(sets)
        disp([' ',upper(char(sets(idx)))]);
        disp('-----------------');
        
        print_set(result.(char(sets(idx))));
    end
end

function print_set(set)
    letters = fieldnames(set);
    
    for idx = 1:length(letters)
        letter_name = char(letters(idx));
        
        if set.(letter_name).success == 1
            success = '@@@@@';
        else
            success = '     ';
        end
        
        disp(['| ',upper(letter_name),' | ',upper(set.(letter_name).return),' | ',success, ' |']);
        disp('-----------------');
    end
end