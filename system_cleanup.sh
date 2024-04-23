#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

check_root() {
    if [ "$EUID" -eq 0 ]; then
        echo -e "${RED}Este script não deve ser executado como root. Saindo...${NC}"
        exit 1
    fi
}

check_root

# Limpeza de cache do Yay (inclui AUR)
echo "Limpando cache do Yay..."
yay -Sc

echo "Atualizando o sistema..."
sudo pacman -Syu

# Limpeza de cache do Pacman
echo "Limpando cache do Pacman..."
sudo pacman -Sc

# Remoção de pacotes órfãos
echo "Procurando e removendo pacotes órfãos..."
orphans=$(pacman -Qdtq)
if [ -z "$orphans" ]; then
    echo "Não há pacotes órfãos para remover."
else
    echo "Pacotes órfãos encontrados: $orphans"
    echo "Deseja remover os pacotes órfãos? [s/N]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY]|[sS])$ ]]; then
        sudo pacman -Rns $orphans
    else
        echo "Remoção de pacotes órfãos cancelada."
    fi
fi

echo "Limpeza concluída!"
