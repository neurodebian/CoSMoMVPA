% RSA Tutorial
% Compare DSMs


subjects = {'s01','s02','s03','s04','s05','s06','s07','s08'};
masks = {'ev_mask.nii','vt_mask.nii'};


dsms = [];

%%
% In a nested loop over masks then subjects:
%       load each dataset
%       demean it, get DSM, save it in dsms

% >>
for m = 1:length(masks)
    msk = masks{m};
    for s = 1:length(subjects)
        sub = subjects{s};
        % load dataset
        data_path=cosmo_get_data_path(subjects{s});
        ds = cosmo_fmri_dataset([data_path '/glm_betas_allruns.nii'], ...
                                'mask',[data_path '/' msk]);
        % demean
        % Comment this out to see the effects of demeaning vs. not
        ds.samples = bsxfun(@minus, ds.samples, mean(ds.samples, 1));

        % add to stack
        dsms = [dsms; pdist(ds.samples, 'correlation')];
    end
end
% <<

%%
% Then add the v1 model and behavioral DSMs
models_path=cosmo_get_data_path('models');
load([models_path 'v1_model.mat']);
load([models_path 'behav_sim.mat']);
% add to dsms (hint: use squareform)
% >>
dsms = [dsms; squareform(v1_model); squareform(behav)];
% <<

%%
% Now visualize the cross-correlation matrix. Remember that corrcoef calculates
% correlation coefficients between columns and we want between rows.

% >>
cc = corrcoef(dsms');
figure(); imagesc(cc); 
% <<

%%
% Now use the values in the last to rows of the cross correlation matrix to
% visualize the distributions in correlations between the neural similarities
% and the v1 model/behavioral ratings.

% >>
cc_models = [cc(1:8,17) cc(9:16,17) cc(1:8,18) cc(9:16,18)];
labs = {'v1 model~EV','v1 model~VT','behav~EV','behav~VT'};
figure(); boxplot(cc_models); set(gca,'XTick',[1:4],'XTickLabel',labs);
% <<




