# 🧬 Clustering Genomic Data in R

# Load libraries
library(ggplot2)
library(pheatmap)

# Simulate gene expression dataset
set.seed(123)
genes <- paste0("Gene", 1:50)
samples <- paste0("Sample", 1:10)
expression_matrix <- matrix(rnorm(500, mean = 5, sd = 2), nrow = 50, dimnames = list(genes, samples))

# Perform PCA
pca_result <- prcomp(t(expression_matrix), scale. = TRUE)

# Perform K-means clustering
set.seed(123)
kmeans_result <- kmeans(t(expression_matrix), centers = 3, nstart = 20)

# Add cluster info
pca_df <- data.frame(pca_result$x[, 1:2], Cluster = as.factor(kmeans_result$cluster))

# Plot PCA clusters
p <- ggplot(pca_df, aes(PC1, PC2, color = Cluster)) +
  geom_point(size = 4) +
  theme_minimal() +
  ggtitle("PCA Clustering of Genomic Data")
ggsave("pca_clusters.png", plot = p)

# Generate heatmap
pheatmap(expression_matrix, show_rownames = FALSE, show_colnames = TRUE, filename = "heatmap.png")
