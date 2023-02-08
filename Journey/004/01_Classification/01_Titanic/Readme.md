#### [Anterior: Feature Engineeering](https://github.com/akimwong/1_OnPremise/tree/main/Journey/003/01_Classification/01_Titanic)

### Feature_Selection
[JPYNB: Feature_Selection](https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/01_Classification/01_Titanic/02_titanic.ipynb)

Se decide en función de la matriz de correlaciones. <br/>

Sólo se <b>eliminan</b> las siguientes variables:

- `SexMale` - muy alta correlación (87%) con `Title_Mr` - mejora la predicción; <br/>
- `Title_Miss` - alta correlación (67%) con `Title_Mr` - mejora la predicción; <br/>
- `Title_Mrs`  - alta correlación (55%) con `Title_Mr` - no aporta señal, ni mejora ni empeora la predicción; <br/>
- `hasCabin` - alta correlación (73%) con `Pclass` - mejora la predicción; <br/>

(`Title_Mr` y `Pclass` no se eliminan por ser más predictoras de la variable objetivo)

