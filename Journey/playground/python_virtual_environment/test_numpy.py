import numpy as np


# Instrucciones para configurar un entorno virtual en Windows
def print_virtual_env_instructions():
    print("\nPasos para configurar un entorno virtual en Windows:")
    print("1. Crear el entorno virtual: python -m venv nombre_entorno")
    print("2. Activarlo: nombre_entorno\\Scripts\\activate")
    print("3. Instalar dependencias: pip install numpy")
    print("4. Ejecutar el programa: python nombre_programa.py")
    print("5. Desactivarlo: deactivate")
    print("-" * 40)

# Mostrar instrucciones
print_virtual_env_instructions()

# Prueba simple con numpy
array = np.array([1, 2, 3, 4, 5])
print("\nArray original:", array)
print("Suma:", np.sum(array))
print("Promedio:", np.mean(array))