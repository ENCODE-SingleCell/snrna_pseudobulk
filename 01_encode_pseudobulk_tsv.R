source('00_gene_quantification_pseudobulk.R')
## ========================================================
## load ct annotation file and prepare pseudobulk level123
## ========================================================
library(Matrix)
d = readRDS('encode4/data/celltype/proc/final.rds')
d <- d[!is.na(d$rna_dataset), ]
d$lifestage <-
  ifelse(d$lifestage %in% c('adult', 'child'),
         'adult_child',
         'embryo_postnatal')

l <-
  data.frame(
    barcode = paste0(d$rna_dataset, ':', d$rna_library, ':', d$rna_barcode),
    pseudobulk_level1 = gsub(' ', '_', paste0('level1-', d$rna_dataset, '-', d$celltype)),
    pseudobulk_level2 = gsub(
      ' ',
      '_',
      paste0(
        'level2-',
        d$species,
        '-',
        d$tissue,
        '-',
        d$celltype,
        '-',
        d$sex,
        '-',
        d$lifestage
      )
    ),
    pseudobulk_level3 = gsub(
      ' ',
      '_',
      paste0(
        'level3-',
        d$species,
        '-',
        d$generaltissue,
        '-',
        d$celltype,
        '-',
        d$lifestage
      )
    )
  )
str(l)
saveRDS(l, 'levels.rds')


## =============================================
## generate pseudobulks for uploading to ENCODE
## =============================================
for (level in paste0('pseudobulk_level', 1:3)) {
  rdir <-
    paste0(
      'data/pseudobulk/snrna/pb/uploadfile/',
      sub('.*_','',level),
      '/'
    )
  alli = unique(l[,level])
  for (i in alli) {
    gene_quantification_pseudobulk(
      dataset_path = 'data/scrna/mat/mat/',
      dataset = paste0(unique(sapply(bc, function(i){sub(':.*','',i)})),'.rds'),
      barcode = l[l[,level]==i, 1],
      savefilename = paste0(rdir, i, '.tsv')
    )
  }
}
