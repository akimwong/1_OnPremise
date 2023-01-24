[(conclusiones EDA ...)](https://github.com/akimwong/1_OnPremise/tree/main/Journey/002/01_Classification/01_Titanic/)

se <b>eliminan</b> las siguientes variables:

- `PassengerId` - aparentemente no aporta información predictora;
- `Survived` - variable objetivo;
- `Name` - previamente se extrae el 'Title' de cada nombre (Mr, Miss, Mr, etc.);
- `Ticket` - aparentemente no aporta información predictora;
- `Cabin` - previamente se crea columna 'hasCabin' donde, NaN = no tiene cabina (0), código X = sí tiene cabina (1).

se <b>transforman</b> las siguientes variables numéricas:

- `SibSp`, `Parch` - 0 = viaja solo, 1 = no viaja solo

Se <b>infieren</b> de la siguiente manera:

- `Age` - en pipeline sklearn usando kNN;
- `Embarked` - usando la moda.

Se hará <b>scaling</b> en pipeline de sklearn de las siguientes variables numéricas:
- `Fare`;
- `Age`.

Se hará <b>one-hot-encode</b> en pipeline sklearn de las siguientes variables categóricas:

- `Sex`;
- `Embarked`;
- `Title`.

<b>No se modificará</b> - al estar en formato numérico y ser ordinal:

- `Pclass`.

[código Feature_Engineering](https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/01_Classification/01_Titanic/02_titanic_feature_engineeering.ipynb)
