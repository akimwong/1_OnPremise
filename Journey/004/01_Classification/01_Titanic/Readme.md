#### [Anterior: Feature Engineeering](https://github.com/akimwong/1_OnPremise/tree/main/Journey/003/01_Classification/01_Titanic)

### Feature_Selection
[JPYNB: Feature_Selection](https://github.com/akimwong/1_OnPremise/blob/main/Journey/002/01_Classification/01_Titanic/02_titanic.ipynb)

#### 1er. filtro:
- `PassengerId, Ticket`: Se eliminan de origen, aparentemente no aportan señal
- `Name`: Se elimina luego de extraer el Title 

#### 2do. filtro:

Se decide en función de la matriz de correlaciones. <br/>

Sólo se <b>eliminan</b> las siguientes variables:

- `Primer Feature` luego de OneHotEncoding de las categóricas - al eliminar mejora la predicción; <br/>
- `SexMale` - muy alta correlación (87%) con `Title_Mr` - al eliminar mejora la predicción; <br/>
- `Title_Miss` - alta correlación (67%) con `Title_Mr` - al eliminar mejora la predicción; <br/>
- `Title_Mrs`  - alta correlación (55%) con `Title_Mr` - no aporta señal, al eliminar ni mejora ni empeora la predicción; <br/>
- `hasCabin` - alta correlación (73%) con `Pclass` - al eliminar mejora la predicción; <br/>

(`Title_Mr` y `Pclass` no se eliminan por ser más predictoras de la variable objetivo 'Survived'

