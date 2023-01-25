### [Anterior: Feature Engineeering](https://github.com/akimwong/1_OnPremise/tree/main/Journey/003/01_Classification/01_Titanic)

Sólo se <b>eliminan</b> las siguientes variables:

- `SexMale` - muy alta correlación (87%) con `Title_Mister`;
- `hasCabin` - alta correlación (73%) con `Pclass`; <br/>

(`Title_Mister` y `Pclass` no se eliminan por ser más predictoras de la variable objetivo)

Resultados:

1. <b>SelectKBest - Chi2:</b> Mejores: Mr, Mrs, Miss, Pclass | Peor: Embarqued Q 
2. <b>LogisticRegression - MinMaxScaler - SelectKBest - Chi2:</b> Mayor accuracy: con 11 variables
3. <b>DecisionTree:</b> Mejores: Age, Fare, Mr, Pclass | Peor: Title_Other
4. <b>ExtraTreeClassifier:</b> Mejores: Age, Fare, Mr, Pclass | Peor: Title_Other
5. <b>LogisticRegression - MinMaxScaler:</b> Mejores: Mr, Pclass, Title_Other | Peor: Mrs
