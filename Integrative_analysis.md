# Integrated Analysis of genome data
![image](https://user-images.githubusercontent.com/47351536/229376648-d02d3e7c-5777-49a7-bf21-1bd4ba2a5498.png)

This script is used to generate a gene expression data set for use in the analysis of the relationship between gene expression and protein-protein interaction networks. The gene expression data set is obtained from the BrainSpan Atlas, which provides gene expression data for multiple brain regions at different developmental stages. The protein-protein interaction data is obtained from the STRING database, which provides information on protein-protein interactions in humans.

The script first loads the necessary packages, including Matrix, RBGL, snow, and randomForest. It then downloads the protein-protein interaction data from the STRING database and cleans up the protein IDs. The interactions with scores over 400 are kept and converted into a graph using the RBGL package. The shortest paths matrix is calculated using the johnson.all.pairs.sp function from RBGL, and the resulting graph and matrix are saved to a file.

Next, the script downloads the gene expression data from the BrainSpan Atlas and imports it into R. The script attempts to map missing entrez gene IDs via gene symbols and then converts all ages into weeks. Only brain structures found in most samples are kept, and the data is smoothed and interpolated using the lowess function. The resulting expression data is then transposed so that genes are rows, and rows of the same gene are merged into a matrix where rows are regions and columns are timepoints.

The resulting matrices are then relabeled by entrezID and scaled using the scale function. Finally, the script maps entrezIDs to ensembl protein IDs using a file obtained from the STRING database and fixes protein names by removing "9606." from them. The resulting gene expression data set can be used in further analysis to examine the relationship between gene expression and protein-protein interaction networks.





