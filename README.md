# dori: Diversity of Representation Index

```diff
+ Diversity of Representation Index (DORI): Computes DORI_b and DORI_w for multidimensional political representation.
```

The **dori** R package implements the Diversity of Representation Index (DORI) introduced in:

> Acquarone, Iris E. (2025). *DORI Index: Measuring Diversity in Representative Institutions.*  
> (See paper for full theoretical exposition.) :contentReference[oaicite:0]{index=0}

DORI provides a multidimensional measure of institutional diversity by incorporating:
- **Variety** of social groups represented  
- **Balance** of their presence within legislatures  
- **Proportionality** of representation relative to population shares (weighted DORI)

The package includes two main functions:
- `dori_b()` — **Balanced DORI**, focusing on variety and evenness  
- `dori_w()` — **Weighted DORI**, incorporating descriptive representation gaps (Equation 2 in the paper)

Both functions implement the DORI formulas as defined in Acquarone (2025). They can be used with any dataset containing group proportions, and they reproduce the computations shown in the paper when supplied with the appropriate inputs (e.g., gender and racial proportions for U.S. state legislatures 2009–2021, Canadian and German examples). 

## Installation

```r
devtools::install_github("ietchacq/dori")

```

## Usage

```r
library(dori)
```

### Toy Example

Example with toy data.

```r
groups <- matrix(c(
  0.4, 0.6,   # pfem, pmale
  0.1, 0.9    # paa, pnonAA
), nrow = 1, byrow = TRUE)

groups_soc <- matrix(c(
  0.5, 0.5, 
  0.3, 0.7
), nrow = 1, byrow = TRUE)

vars <- c(1,1,2,2) #2 vars with 2 groups

dori_b(groups, vars)
dori_w(groups, groups_soc, vars)
```

### Balanced DORI (DORI_b)

Example with df as in paper.

```r
# Matrix of proportions in the legislature (each row = one unit)
groups <- cbind(
  pfem   = df$pfem,
  pmale  = 1 - df$pfem,
  paa    = df$paa,
  pnonAA = 1 - df$paa
)

# Identity-variable mapping:
#   1 = gender (pfem, pmale)
#   2 = race   (paa, pnonAA)

vars <- c(1,1,2,2)

df$dori_b <- dori_b(groups, vars)
```

### Weighted DORI (DORI_w)

```r
# Population proportions matrix (same variable order)
groups_soc <- cbind(
  pfem_soc   = df$pfem_soc,
  pmale_soc  = 1 - df$pfem_soc,
  paa_soc    = df$paa_soc,
  pnonAA_soc = 1 - df$paa_soc
)

df$dori_w <- dori_w(groups, groups_soc, vars)
```

## Interpreting DORI

- **DORI_b** ranges 0–1  
  - 0 = complete homogeneity (all representation concentrated in one group)  
  - higher values = more variety and more balanced representation across groups

- **DORI_w** adjusts the above by descriptive representation  
  - higher values = greater *representatively* diverse  
  - can be negative under extreme overrepresentation


## Citation

If you use this package, please cite:

Acquarone, Iris E. (2025)_. DORI Index: Measuring Diversity in Representative Institutions._

Preprint available at: https://osf.io/preprints/osf/8zur9_v2. R package available at: https://github.com/ietchacq/dori

## Contact

For questions, issues, or contributions:
- GitHub Issues: https://github.com/ietchacq/dori/issues
- Email: ietchacq@gmail.com


