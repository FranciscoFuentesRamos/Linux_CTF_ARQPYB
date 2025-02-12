import joblib
import argparse
import pandas as pd
from datetime import datetime
import warnings

warnings.filterwarnings('ignore')

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
NIVEL = None

def procesar_linea(linea):

    columnas = ['inicio', 'fin', 'nivel', 'n_comandos']
    datos = dict(zip(columnas, linea.split(";")))
    inicio = datetime.fromisoformat(datos['inicio'])
    fin = datetime.fromisoformat(datos['fin'])

    duracion_segundos = int((fin - inicio).total_seconds())
    n_comandos = int(datos['n_comandos'])

    nivel = datos['nivel']
    modelo = joblib.load(f'/local/ctf/models/model_{nivel}.joblib')
    
    X_nuevo = pd.DataFrame([[n_comandos, duracion_segundos]], columns=['n_comandos', 'duracion_segundos'])
    prediccion = modelo.predict(X_nuevo)

    return prediccion[0], nivel

def ajustar_nivel(prediccion, nivel):

    niveles = {'facil': 1, 'inter': 2, 'hard': 3}
    nivel_actual = niveles[nivel]

    if prediccion == "+": # SUBIR NIVEL
        nivel_actual += 1
    elif prediccion == "-": # BAJAR NIVEL
        nivel_actual -= 1
    elif prediccion == "=": # MANTENER
        pass

    for nivel, valor in niveles.items():
        if valor == nivel_actual:
            return nivel


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Clasificar una línea de datos usando el modelo adecuado.")
    parser.add_argument("linea", type=str, help="Línea del CSV para clasificar")
    args = parser.parse_args()
    
    prediccion, nivel = procesar_linea(args.linea)
    nuevo_nivel = ajustar_nivel(prediccion, nivel)

    print(f"{nuevo_nivel}")


