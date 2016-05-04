MaPhase
A hidden markov progeny phaser

A Hidden Markov Model (HMM) implementation to phase a progeny from
a biparental cross.


it asumes: 
- phased and imputed parent genotypes as two haplotypes per parent as vectors of (0,1,3)
- genotyped progeny member, as a genotype. Alleles as (0,1,2,3)

Assumes biallelic loci
for the parental haplotyoes 0 is the reference allele, 1 is the alternate allele

for the progeny genotype 0 is homozygous reference, 1 is heterozygous, 2 is reference alternate

For parental haplotypes or progeny genotypes 3 is missing data.

It identifies parental segments and recombination breaks

A tutorial on the development of the model is:
https://github.com/lmavila/HMMTutorial.git


