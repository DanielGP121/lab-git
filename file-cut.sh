#!/bin/bash

# Versión "acorazada" con más depuración y verificaciones.
TASK_ID=$SLURM_PROCID
FILES=("Sample1.fastq" "Sample2.fastq" "Sample3.fastq" "Sample4.fastq")
input_file=${FILES[$TASK_ID]}

echo "--- [Worker $TASK_ID] Iniciando. Objetivo: $input_file ---"

# Verificación 1: ¿Existe el fichero?
if [ ! -f "$input_file" ]; then
    echo "--- [Worker $TASK_ID] ERROR CRÍTICO: No se encuentra el fichero de entrada '$input_file'. Abortando."
    exit 1
fi

# Contar líneas
total_lines=$(wc -l < "$input_file")
echo "--- [Worker $TASK_ID] DEBUG: 'wc -l' ha devuelto '$total_lines' líneas para $input_file."

# Verificación 2: ¿Se han podido leer las líneas?
if [ "$total_lines" -le 0 ]; then
    echo "--- [Worker $TASK_ID] ERROR CRÍTICO: Se han leído 0 o menos líneas de '$input_file'. No se puede continuar. Abortando."
    exit 1
fi

# Lógica de corte (solo se ejecuta si las verificaciones pasan)
user_number=$(echo $USER | sed 's/alumno//')
if [ "$user_number" == "01" ]; then
  divisor=10
else
  divisor=$(echo $user_number | sed 's/^0*//')
fi

lines_to_keep=$((total_lines / divisor))
echo "--- [Worker $TASK_ID] DEBUG: Se conservarán '$lines_to_keep' líneas."

head -n "$lines_to_keep" "$input_file" > "${input_file}.tmp"
mv "${input_file}.tmp" "$input_file"

echo "--- [Worker $TASK_ID] ÉXITO: Fichero $input_file procesado."