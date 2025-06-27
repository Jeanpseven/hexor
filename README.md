# 🔍 hexor.sh

---
The Hex code F*cker
---

**`hexor.sh`** é um script Bash que converte arquivos contendo bytes no formato `0x**,0x**,0x**, ...` (hexadecimais separados por vírgula) para seu equivalente binário. Ele também detecta automaticamente se o conteúdo está compactado com **GZIP** e descompacta o conteúdo para exibição ou salvamento.

---

## 🚀 Funcionalidades

- 📥 Recebe como entrada um arquivo `.txt` com dados hexadecimais estilo `0x**`
- 🔁 Converte os dados para um arquivo binário real
- 🔍 Detecta automaticamente se o conteúdo é GZIP
- 📂 Descomprime e exibe o conteúdo descompactado, se aplicável
- 💾 Permite salvar a saída (binária ou descompactada)

---

## 📦 Requisitos

- `bash`
- `xxd` (vem com `vim-common`)
- `gunzip` (pacote `gzip`)
- `file`
- `strings`

Instale com:

```bash
sudo apt update
sudo apt install vim-common gzip coreutils
```

Troubles with msdos?
dos2unix

Troubles with Unix?
unix2dos

