%% Dataset Basics
% Set the targets and the chunks
%
% There are 10 runs with 6 volumes per run. The runs are vertically stacked one
% above the other. The six volumes in each run correspond to the stimuli:
% 'monkey','lemur','mallard','warbler','ladybug','lunamoth', in that order. Add
% numeric targets labels (samples atribute) such that 1 corresponds to 'monkey',
% 2 corresponds to 'lemur', etc. Then add numeric chunks (another samples
% attribute) so that 1 corresponds to run1, 2 corresponds to run2, etc.

%% Load the dataset
% >>

data_path=cosmo_get_data_path('s01');
ds = cosmo_fmri_dataset([data_path '/glm_T_stats_perrun.nii'], ...
                        'mask', [data_path '/brain_mask.nii']);
% <<
%% set targets
% >>
ds.sa.targets = repmat([1:6]',10,1); 
% <<
%% set chunks
% >>
ds.sa.chunks = floor(((1:60)-1)/6)'+1;
% <<

%% Show the results

% print the dataset
ds

% print the sample attributes
ds.sa

% print the chunks
ds.sa.chunks

% print the targets
ds.sa.targets



