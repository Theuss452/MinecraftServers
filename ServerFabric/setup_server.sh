#!/bin/bash

echo "=== Instalador automático do servidor Fabric ==="

# Perguntar versão
read -p "Digite a versão do Minecraft (ex: 1.20.1): " VERSION

# Perguntar memória
read -p "Digite a memória mínima (Xms), ex: 4G: " XMS
read -p "Digite a memória máxima (Xmx), ex: 8G: " XMX

# Perguntar núcleos
read -p "Digite quantos núcleos deseja usar: " CPU

# Criar diretório
SERVER_DIR="/workspace/MinecraftServers/ServerFabric/${VERSION}"
mkdir -p "$SERVER_DIR"
cd "$SERVER_DIR" || exit

# Baixar Fabric Installer
echo "[INFO] Baixando Fabric installer..."
wget -O fabric-installer.jar https://meta.fabricmc.net/v2/versions/loader/${VERSION}/0.15.11/1.0.0/server/jar

echo "[INFO] Executando Fabric installer..."
java -jar fabric-installer.jar server -mcversion ${VERSION} -downloadMinecraft

# Aceitar EULA
echo "eula=true" > eula.txt

# Configurar JVM
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

# Aviso final
echo "=== Servidor Fabric ${VERSION} instalado em: $SERVER_DIR ==="
echo "Para iniciar o servidor, use:"
echo "cd $SERVER_DIR && java @user_jvm_args.txt -jar fabric-installer.jar nogui"
