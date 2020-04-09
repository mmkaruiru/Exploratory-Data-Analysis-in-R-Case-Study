# Importation of Dataset(United Nations Voting Dataset)
#Loading RDS file from website.
#First Run the file through a built in decomposser function (gzcon)
#Then load it through RBase function readRDS

unData =readRDS(gzcon(url("https://assets.datacamp.com/production/repositories/420/datasets/ddfa750d993c73026f621376f3c187f276bf0e2a/votes.rds")))

#Observing firs 5 rows of the dataset
head(unData)


