#### [Anterior: Feature Engineeering](https://github.com/akimwong/1_OnPremise/tree/main/Journey/003/01_Classification/01_Titanic)

### Feature_Selection
[JPYNB: Feature_Selection](https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/01_Classification/01_Titanic/02_titanic.ipynb)

Sólo se <b>eliminan</b> las siguientes variables:

- `SexMale` - muy alta correlación (87%) con `Title_Mr`;
- `hasCabin` - alta correlación (73%) con `Pclass`; <br/>

(`Title_Mr` y `Pclass` no se eliminan por ser más predictoras de la variable objetivo)

