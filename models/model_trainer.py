import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
import seaborn as sns
import joblib 
import matplotlib.pyplot as plt
import numpy as np

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).

df = pd.read_csv('train.csv', sep=';', header=None, names=["fecha_inicio", "fecha_fin", "nivel", "n_comandos"])

df['fecha_inicio'] = pd.to_datetime(df['fecha_inicio'])
df['fecha_fin'] = pd.to_datetime(df['fecha_fin'])
df['duracion_segundos'] = (df['fecha_fin'] - df['fecha_inicio']).dt.total_seconds()


##############################################################################
#
# 1. CREACION DEL MODELO PARA "FACIL"                                        
#
##############################################################################

df_nivel = df[df['nivel'] == 'facil'].copy()
# Definir un umbral de rendimiento (mediana)
df_nivel['combinado'] = df_nivel['n_comandos'] * df_nivel['duracion_segundos']
umbral_rendimiento = df_nivel['combinado'].median()
# Crear la columna de etiqueta ('=' para rendimiento bajo o igual, '+' para rendimiento alto)
df_nivel['etiqueta'] = df_nivel['combinado'].apply(lambda x: '+' if x <= umbral_rendimiento else '=')

X = df_nivel[['n_comandos', 'duracion_segundos']]
y = df_nivel['etiqueta']

plt.figure(figsize=(10, 6))
scatter = sns.scatterplot(
    x=df_nivel['n_comandos'], 
    y=df_nivel['duracion_segundos'], 
    hue=df_nivel['etiqueta'],
    palette={'+': 'green', '=': 'blue'}
)
scatter.legend_.set_title("Resultado")
new_labels = ["Subir dificultade ( + )", "Manter dificultade ( = )"]
for t, new_label in zip(scatter.legend_.texts, new_labels):
    t.set_text(new_label)
plt.title(f'Rendemento na dificultade Sinxela')
plt.xlabel('Número de comandos')
plt.ylabel('Duración en segundos')
plt.grid(True)
plt.savefig("graficas/scatter_facil.png", dpi=300, bbox_inches="tight")


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
modelo = LogisticRegression()
modelo.fit(X_train, y_train)

y_pred = modelo.predict(X_test)
# Guardar el modelo
report=classification_report(y_test, y_pred)
with open("reportes/reporte_facil.txt", "w") as archivo:
    archivo.write(report)
joblib.dump(modelo, 'modelos/model_facil.joblib')

##############################################################################
#
# 2. CREACION DEL MODELO PARA "HARD"                                        
#
##############################################################################

df_nivel = df[df['nivel'] == 'hard'].copy()
# Definir un umbral de rendimiento (mediana)
df_nivel['combinado'] = df_nivel['n_comandos'] * df_nivel['duracion_segundos']
umbral_rendimiento = df_nivel['combinado'].median()
# Crear la columna de etiqueta ('-' para rendimiento bajo o igual, '=' para rendimiento alto)
df_nivel['etiqueta'] = df_nivel['combinado'].apply(lambda x: '=' if x <= umbral_rendimiento else '-')

X = df_nivel[['n_comandos', 'duracion_segundos']]
y = df_nivel['etiqueta']

# Crear un scatter plot 2D con colores para la etiqueta
plt.figure(figsize=(10, 6))
scatter = sns.scatterplot(
    x=df_nivel['n_comandos'], 
    y=df_nivel['duracion_segundos'], 
    hue=df_nivel['etiqueta'],
    hue_order=['=', '-'],
    palette={'=': 'blue', '-': 'red'}
)
scatter.legend_.set_title("Resultado")
new_labels = ["Manter dificultade ( = )", "Baixar dificultade ( - )"]
for t, new_label in zip(scatter.legend_.texts, new_labels):
    t.set_text(new_label)
plt.title(f'Rendemento na dificultade Dificil')
plt.xlabel('Número de comandos')
plt.ylabel('Duración en segundos')
plt.grid(True)
plt.savefig("graficas/scatter_hard.png", dpi=300, bbox_inches="tight")

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
modelo = LogisticRegression()
modelo.fit(X_train, y_train)

y_pred = modelo.predict(X_test)
# Guardar el modelo
report=classification_report(y_test, y_pred)
with open("reportes/reporte_hard.txt", "w") as archivo:
    archivo.write(report)
joblib.dump(modelo, 'modelos/model_hard.joblib')


##############################################################################
#
# 3. CREACION DEL MODELO PARA "INTER"                                        
#
##############################################################################

df_nivel = df[df['nivel'] == 'inter'].copy()
# Definir un umbral de rendimiento (mediana)
df_nivel['combinado'] = df_nivel['n_comandos'] * df_nivel['duracion_segundos']
percentil_33 = df_nivel['combinado'].quantile(0.33)
percentil_66 = df_nivel['combinado'].quantile(0.66)

def asignar_etiqueta(duracion):
    if duracion <= percentil_33:
        return '+'  # Rendimiento alto
    elif duracion <= percentil_66:
        return '='  # Rendimiento medio
    else:
        return '-'  # Rendimiento bajo
df_nivel['etiqueta'] = df_nivel['combinado'].apply(asignar_etiqueta)
X = df_nivel[['n_comandos', 'duracion_segundos']]
y = df_nivel['etiqueta']
plt.figure(figsize=(10, 6))
scatter=sns.scatterplot(
    x=df_nivel['n_comandos'], 
    y=df_nivel['duracion_segundos'], 
    hue=df_nivel['etiqueta'],
    hue_order=['+', '=', '-'],
    palette={'+': 'green', '=': 'blue', '-': 'red'}
)
scatter.legend_.set_title("Resultado")
new_labels = ["Subir dificultade ( + )", "Manter dificultade ( = )", "Baixar dificultade ( - )"]
for t, new_label in zip(scatter.legend_.texts, new_labels):
    t.set_text(new_label)
plt.title(f'Rendemento na dificultade Intermedia')
plt.xlabel('Número de comandos')
plt.ylabel('Duración en segundos')
plt.grid(True)
plt.savefig("graficas/scatter_inter.png", dpi=300, bbox_inches="tight")
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
#modelo = LogisticRegression(multi_class='multinomial', solver='lbfgs', max_iter=1000)
modelo = LogisticRegression()
modelo.fit(X_train, y_train)

y_pred = modelo.predict(X_test)
# Guardar el modelo
report=classification_report(y_test, y_pred)
with open("reportes/reporte_inter.txt", "w") as archivo:
    archivo.write(report)
joblib.dump(modelo, 'modelos/model_inter.joblib')

##############################################################################
#
# X. CREACION DE GRAFICAS                                  
#
##############################################################################

niveles = df['nivel'].unique()
for nivel in niveles:
    df_nivel = df[df['nivel'] == nivel].copy()

    plt.figure(figsize=(10, 6))
    plt.scatter(df_nivel['n_comandos'], df_nivel['duracion_segundos'], alpha=0.5)

    plt.title(f'Rendemento na dificultade {nivel}')
    plt.xlabel('Número de comandos')
    plt.ylabel('Duración en segundos')
    plt.grid(True)

    filename = f'graficas/grafico_{nivel}.png'
    plt.savefig(filename)
    plt.close()





