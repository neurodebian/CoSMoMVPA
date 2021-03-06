function data_path=cosmo_get_data_path(subject_id)
% helper function to get the path for example data.
% this function is to be extended to work on your machine, depending on
% where you stored the test data
% 
% Inputs
%   subject_id    optional subject id identifier. If provided it gives the
%                 data directory for that subject
%
% Returns
%  data_path      path where data is stored
    
    % change the following depending on where your data resides
    data_path='../data';
    
    if ismac()
        % specific code for NNO
        [p,q]=unix('uname -n');
        if p==0 && isempty(strmatch(lower(q),'nicks-macBook-pro'))
            data_path='/Users/nick/organized/_datasets/CoSMoMVPA';
        end
    end
    
    
    if nargin>=1
        switch subject_id
            case {'finger','5cat'}
                subdir=subject_id;
            otherwise
                %ak6, use subdir of subject
    
                if isnumeric(subject_id)
                    subject_id=sprintf('s%02d', subject_id);
                end
                subdir=fullfile('ak6',subject_id);
        end
        data_path=fullfile(data_path, subdir);
    end
    
    if ~exist(data_path,'file')
        exist(data_path,'file')
        error('%s does not exist. Did you adjust %s?', data_path, mfilename());
    end
    
    if ~isempty(data_path)
        data_path=[data_path '/'];
    end
    