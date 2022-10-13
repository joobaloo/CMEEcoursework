from traceback import TracebackException


taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
# 
chiroptera_taxas = [taxa[i][0] for i in range(len(taxa)) if taxa[i][1] == 'Chiroptera']
rodentia_taxas = [taxa[i][0] for i in range(len(taxa)) if taxa[i][1] == 'Rodentia']
afrosoricida_taxas = [taxa[i][0] for i in range(len(taxa)) if taxa[i][1] == 'Afrosoricida']
carnivora_taxas = [taxa[i][0] for i in range(len(taxa)) if taxa[i][1] == 'Carnivora']

orders = set([taxa[i][1] for i in range(len(taxa))])

d = {'Chiroptera' : chiroptera_taxas, 'Rodentia' : rodentia_taxas, 'Afrosoricida' : afrosoricida_taxas, 'Carnivora' : carnivora_taxas}
print(d)
"""this is techinically fine but there must be a way to use a loop?"""

# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc
