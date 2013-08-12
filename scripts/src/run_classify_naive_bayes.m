
% Load the dataset with VT mask
ds = cosmo_fmri_dataset('../data/s01/glm_T_stats_perrun.nii.gz', ...
                     'mask', '../data/s01/vt_mask.nii.gz');


% set the targets and chunks
ds.sa.targets = repmat([1:6],1,10);
chunks = []; for i = 1:10 chunks = [chunks repmat([i],1,6)]; end
ds.sa.chunks = chunks;

% Add labels as sample attributes
labels = {'monkey','lemur','mallard','warbler','ladybug','lunamoth'};
ds.sa.labels = repmat(labels,1,10);

% get indices for monkeys and mallards
idx = strcmp(ds.sa.labels,'monkey') | strcmp(ds.sa.labels,'mallard');

% Use sample attrubutes slicer to slice dataset
ds2 = sa_slicer(ds,idx);

% Now slice into odd and even runs using chunks attribute
even_idx = boolean(repmat([0 0 1 1],1,5));
odd_idx = boolean(repmat([1 1 0 0], 1,5));

evens = sa_slicer(ds2,even_idx);
odds = sa_slicer(ds2,odd_idx);

pred = cosmo_classify_naive_baysian(evens.samples, evens.sa.targets, odds.samples);
accuracy = mean(odds.sa.targets == pred');

% Answer: accuracy should be .70 

pred = cosmo_classify_naive_baysian(odds.samples, odds.sa.targets,evens.samples);
accuracy = mean(odds.sa.targets == pred');

% Answer: accuracy = .50

 