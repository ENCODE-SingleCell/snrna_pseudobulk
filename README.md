ENCODE4: Gene Quantifications for Pseudobulks

This github repository provides codes for generating gene quantifications for pseudobulks.

Note

Note 1: Many "count" values are not integers, as all of the ENCODE sc/snRNA-seq parse data was processed with this STAR Solo command: https://github.com/detrout/woldrnaseq-wrappers/blob/main/star_solo_splitseq/wrapper.py#L70 which attempts to use EM to assign multi-mapping reads.

The gene_model is defined by the following function. 

```
def get_gene_model(config):
  return "GeneFull_Ex50pAS" if config['include_intron'] else "Gene"
```

where include_intron was true for the single nucleus data.

When running STAR, the output directory name will include the gene mode. So if it was run as a single nucleus experiment the directory name will be GeneFull_Ex50pAS and should have floating point values.

All the parse data was run with GeneFull_Ex50pAS. Definition for the GeneFull_Ex50pAS can be referred to https://github.com/alexdobin/STAR/blob/b1edc1208d91a53bf40ebae8669f71d50b994851/source/parametersDefault#L863
