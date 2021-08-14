#!/usr/bin/env bash
#startOfFile
# Filename: jdtls.sh

# This script is for wrapping the eclipse jdt language server -> https://github.com/eclipse/eclipse.jdt.ls
# For windows users a .bat script is required instead


# NOTES:
# ----------------------------------------------------------------------------
# '$HOME/.ls-servers/eclipse.jdt.ls' is the path to the server (update it accordingly in 'JAR' and in '-configuration')
# ----------------------------------------------------------------------------
# Options for '-configuration':
#	config_win
#	config_mac
#	config_linux

JAR="$HOME/.ls-servers/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle /usr/lib/jvm/default-java/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.ls-servers/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
#endOfFile
