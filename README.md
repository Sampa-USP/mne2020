# Métodos Numéricos para Escoamentos em Nano e Micro-escalas - USP
## Terceiro período, 2020

Bem-vindo ao repositório da disciplina PME-5429. Links para as aulas podem ser encontrados na lista a seguir:

1. [Tutorial LAMMPS](./tutorial_lammps) - acesse o arquivo [main.pdf](./tutorial_lammps/main.pdf) para seguir o roteiro de quatro aulas de laboratório utilizando o LAMMPS, incluindo simulações com (1) água, (2) heptano, (3) interface água-heptano e (4) dióxido de carbono.

Para obter todos os materiais deste repositório, digitar no terminal:

`git clone https://github.com/Sampa-USP/mne2020.git`

Para atualizar os arquivos, entre no diretório `mne2020` e execute:

`git pull`

2.  [Instalações Importantes na máquina virtual]

`sudo apt-get install gedit`
`sudo apt-get install libgfortran3`

3. [Para converter um arquivo txt (ex: log.lammps_nve)  para o formato csv utilize o script:]

`column -t log.lammps_nve | sed -e 's/\s\+/,/g' > data.csv`


## Agradecimentos

