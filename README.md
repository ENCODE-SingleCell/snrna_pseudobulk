ENCODE4: Gene Quantifications for Pseudobulks

This github repository provides codes for generating gene quantifications for pseudobulks.



## File annotations
`00_gene_quantification_pseudobulk.R`: the function for gene quantification of pseudobulk.

`01_encode_pseudobulk_tsv.R`: the pipeline codes for getting the barcodes for levels 1, 2, and 3 and pooling the pseudobulks.

`level1-ENCSR998YMP-smooth_muscle_cell.tsv`: an example tsv file for a pseudobulk at level1 for smooth muscle cell.

## The pseudobulk column names

As shown in `level1-ENCSR998YMP-smooth_muscle_cell.tsv`, an example tsv file for a pseudobulk at level1 for smooth muscle cell, each pseudobulk file has the following column names:

- "gene_id": The ID of genes in the form of "ENSG...".
- "gene_name": The names of the genes.
- "count": The "count" values for the pseudobulks by summing up the "counts" across all the single cells pooled to get this pseudobulk. [Note: please refer to the following note about non-integers.]
- "CPM": The "count per million" values for the pseudobulk by dividing the above "count" by library size of that pseudobulk and multiplying by 1e6.

## Note

### Many "count" values are not integers, as all of the ENCODE sc/snRNA-seq parse data was processed with this STAR Solo command: https://github.com/detrout/woldrnaseq-wrappers/blob/main/star_solo_splitseq/wrapper.py#L70 which attempts to use EM to assign multi-mapping reads.

The gene_model is defined by the following function. 

```
def get_gene_model(config):
  return "GeneFull_Ex50pAS" if config['include_intron'] else "Gene"
```

where include_intron was true for the single nucleus data.

When running STAR, the output directory name will include the gene mode. So if it was run as a single nucleus experiment the directory name will be GeneFull_Ex50pAS and should have floating point values.

All the parse data was run with GeneFull_Ex50pAS. Definition for the GeneFull_Ex50pAS can be referred to https://github.com/alexdobin/STAR/blob/b1edc1208d91a53bf40ebae8669f71d50b994851/source/parametersDefault#L863






