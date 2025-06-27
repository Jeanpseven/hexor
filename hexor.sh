#!/bin/bash

# Verifica se o caminho foi passado
if [ -z "$1" ]; then
    echo "Uso: $0 <caminho_do_arquivo_hex>"
    exit 1
fi

INPUT_FILE="$1"
TMP_HEX="/tmp/cleaned_hex_$$.txt"
OUTPUT_BIN="/tmp/output_bin_$$.bin"
OUTPUT_DECOMP="/tmp/decompressed_$$.txt"

# Verifica se o arquivo existe
if [ ! -f "$INPUT_FILE" ]; then
    echo "Arquivo não encontrado: $INPUT_FILE"
    exit 1
fi

# Limpa os 0x e vírgulas, e gera string contínua
cat "$INPUT_FILE" | tr -d '\n' | sed 's/0x//g' | tr -d ',' > "$TMP_HEX"

# Converte hex para binário
xxd -r -p "$TMP_HEX" > "$OUTPUT_BIN"

# Mostra tipo do arquivo
echo "Arquivo convertido: $OUTPUT_BIN"
file "$OUTPUT_BIN"

# Verifica se é gzip e descomprime
if file "$OUTPUT_BIN" | grep -qi 'gzip compressed'; then
    echo "Detectado conteúdo gzip, descompactando..."
    gunzip -c "$OUTPUT_BIN" > "$OUTPUT_DECOMP"
    echo "Conteúdo descompactado salvo em: $OUTPUT_DECOMP"
    echo "Visualização (primeiras linhas):"
    head -n 30 "$OUTPUT_DECOMP"
    FINAL_OUTPUT="$OUTPUT_DECOMP"
else
    echo "Visualização do conteúdo (strings detectáveis):"
    strings "$OUTPUT_BIN" | head -n 30
    FINAL_OUTPUT="$OUTPUT_BIN"
fi

# Pergunta se deseja salvar
read -p "Deseja salvar o conteúdo final? (s/n): " ANSWER
if [[ "$ANSWER" == "s" ]]; then
    read -p "Informe o caminho de saída (ex: /tmp/saida_final): " SAVE_PATH
    cp "$FINAL_OUTPUT" "$SAVE_PATH"
    echo "Salvo em: $SAVE_PATH"
else
    echo "Saída final armazenada temporariamente em: $FINAL_OUTPUT"
fi

# Limpa arquivos temporários intermediários
rm -f "$TMP_HEX"
