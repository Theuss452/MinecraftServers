#!/bin/bash
# Script de instalação e configuração do servidor Forge 1.20.1 interativo

# === ENTRADAS DE DADOS ===
read -p "Digite a versão do servidor e a versao do Forge seguindo o padrao: (ex: 1.20.1-47.4.0): " FORGE_VERSION
read -p "Digite a RAM mínima (ex: 4G, 8G, 16G): " RAM_MIN
read -p "Digite a RAM máxima (ex: 8G, 16G, 24G): " RAM_MAX
read -p "Digite o número de núcleos da CPU a usar (ex: 2, 4, 6): " CPU_CORES

# === DIRETÓRIO ===
BASE_DIR="/workspace/MinecraftServers/ServerForge"
INSTALL_DIR="$BASE_DIR/$FORGE_VERSION"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

# === DOWNLOAD FORGE INSTALLER ===
echo "[INFO] Baixando Forge $FORGE_VERSION..."
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.5.0/forge-1.19.2-43.5.0-installer.jar -O forge-installer.jar



# === INSTALANDO SERVIDOR ===
echo "[INFO] Instalando Forge..."
java -jar forge-installer.jar --installServer

# === ACEITANDO EULA ===
echo "[INFO] Aceitando EULA..."
echo "eula=true" > eula.txt

# === CONFIGURANDO JVM ===
echo "[INFO] Configurando JVM no user_jvm_args.txt..."
cat > "$SERVER_DIR/user_jvm_args.txt" <<EOL
-Xms${XMS}
-Xmx${XMX}
-XX:+UseG1GC
-XX:+ParallelRefProcEnabled
-XX:MaxGCPauseMillis=200
-XX:+UnlockExperimentalVMOptions
-XX:ActiveProcessorCount=${CPU}
EOL


# === FINAL ===
echo "[INFO] Setup concluído com sucesso!"
echo "Servidor instalado em: $INSTALL_DIR"
echo "Para iniciar o servidor, execute:"
echo "cd $INSTALL_DIR && ./run.sh"
