%% RSA Visualize
%

%% Load data in EV and VT mask
% load datasets cosmo_fmri_dataset

data_path=cosmo_get_data_path('s01');

% >>
ev_ds = cosmo_fmri_dataset([data_path 'glm_betas_allruns.nii'], ...
                            'mask',[data_path 'ev_mask.nii']);

vt_ds = cosmo_fmri_dataset([data_path 'glm_betas_allruns.nii'], ...
                            'mask',[data_path 'vt_mask.nii']);
% <<

% Use pdist with correlation distance to get DSMs
% >>
ev_dsm = pdist(ev_ds.samples, 'correlation');
vt_dsm = pdist(vt_ds.samples, 'correlation');
% <<

% Using matlab's subplot function place the heat maps for EV and VT DSMs side by
% side in the top two positions of a 3 x 2 subplot figure

% >> 
figure(); subplot(3,2,1); imagesc(squareform(ev_dsm)); title('EV');
subplot(3,2,2); imagesc(squareform(vt_dsm)); title('VT');
% <<



% Now add the dendrograms for EV and LV in the middle row of the subplot figure 
labels = {'monkey','lemur','mallard','warbler','ladybug','lunamoth'}';
%
% >>
ev_hclus = linkage(ev_dsm);
vt_hclus = linkage(vt_dsm);
subplot(3,2,3); dendrogram(ev_hclus,'labels',labels,'orientation','left');
subplot(3,2,4); dendrogram(vt_hclus,'labels',labels,'orientation','left');
% <<

% Finally pu the MDS plots in the bottom row
% >>
F_ev = cmdscale(squareform(ev_dsm));
F_vt = cmdscale(squareform(vt_dsm));

subplot(3,2,5); text(F_ev(:,1), F_ev(:,2), labels);
mx = max(abs(F_ev(:)));
xlim([-mx mx]); ylim([-mx mx]);

subplot(3,2,6); text(F_vt(:,1), F_vt(:,2), labels);
mx = max(abs(F_vt(:)));        
xlim([-mx mx]); ylim([-mx mx]);
% <<
                            
