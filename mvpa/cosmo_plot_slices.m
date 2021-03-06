function cosmo_plot_slices(data, dim, slice_step, slice_start, slice_stop)
% Plots a set of slices from a dataset, nifti image, or 3D data array
%
% cosmo_plot_slices(data[, dim][, slice_step][, slice_start][, slice_stop])
%
% Inputs:
%  data         a dataset (from cosmo_fmri_dataset), nifti image (from
%               load_nii), or a 3D array with data. data should contain 
%               data from a single volume (sample) only.
%  dim          dimension according to which slices are plotted 
%               (default: 3).
%  slice_step   step between slices (default: 1). If negative then 
%               -slice_step indicates the number of slices
%  slice_start  the index of the first slice to plot (default: 1).
%  slice_stop   the index of the last slice to plot (default: the number of 
%               slices in the dim-th dimension).
%
% NNO Aug 2013
    
    if nargin<2 || isempty(dim), dim=3; end
    if nargin<3 || isempty(slice_step), slice_step=-20; end
    if nargin<4 || isempty(slice_start), slice_start=1; end
    if nargin<5 || isempty(slice_stop), slice_stop=[]; end % determine after selecting the right dimension
    
    if cosmo_check_dataset(data,false)
        data4D=cosmo_unflatten(data);
        sz=size(data4D);
        if sz(1)>1 error('expected single volume data'); end
        data=reshape(data4D, sz(2:4));
    end
    
    if numel(size(data))~=3
        error('expected 3D image - did you select a single volume?');
    end
    
    % get min and max values across the entire volume
    data_lin=data(:);
    mn=min(data_lin);
    mx=max(data_lin);
    
    % shift it so that we can walk over the first dimension
    data_sh=shiftdim(data, dim-1);
    
    if isempty(slice_stop)
        slice_stop=size(data_sh,1);
    end
    
    if slice_step<0
        nslices=-slice_step;
        slice_step=ceil((slice_stop-slice_start+1)/nslices);
    end
    
    % determine which slices to show
    slice_idxs=slice_start:slice_step:slice_stop;
    nslices=numel(slice_idxs);
    
    plot_ratio=.8; % ratio between number of rows and colums
    nrows=ceil(sqrt(nslices)*plot_ratio);
    ncols=ceil(nslices/nrows);
    
    % use header depending on dim
    header_labels={'i','j','k'};
    
    % order of slices and whether the slice should be transposes
    %xorder=[-1,1,1];
    %yorder=[-1,1,-1];
    %do_transpose=[true true false];
    xorder=[-1 -1 1];
    yorder=[-1 1 -1];
    do_transpose=[true false true];
    
    
    for k=1:nslices
        slice_idx=slice_idxs(k);
        slice=squeeze(data_sh(slice_idx,:,:));
        
        if xorder(dim)<0
            slice=slice(end:-1:1,:);
        end
        if yorder(dim)<0
            slice=slice(:,end:-1:1);
        end
        if do_transpose(dim)
            slice=slice';
        end
        
        subplot(nrows, ncols, k);
        imagesc(slice, [mn, mx]);
        title(sprintf('%s = %d', header_labels{dim}, slice_idx));
    end