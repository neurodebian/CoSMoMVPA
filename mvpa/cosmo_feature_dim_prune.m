function ds_pruned=cosmo_feature_dim_prune(ds, labels)

cosmo_check_dataset(ds);

if nargin<2
    labels=ds.a.dim.labels;
elseif ischar(labels)
    labels={labels};
end


if ~iscell(labels) && all(cellfun(@ischar,labels))
    error('expected cell with labels, or single string');
end

% removes the values in ds.a.dim that are not used

ndim=numel(labels);
ds_pruned=ds; % output

for dim=1:ndim
    label=ds.a.dim.labels{dim};
    values=ds.a.dim.values{dim};
    fa=ds.fa.(label);
    [unq_idxs,foo,map_idxs]=unique(fa);
    
    ds_pruned.fa.(label)=map_idxs(:)';
    if iscell(values)
        values={values{unq_idxs}};
    else
        values=reshape(values(unq_idxs),1,[]);
    end
    ds_pruned.a.dim.values{dim}=values;
end