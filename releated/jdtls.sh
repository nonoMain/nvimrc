#!/usr/bin/env bash
#startOfFile
# Filename: jdtls.sh

# NOTES:
# ----------------------------------------------------------------------------
# '$HOME/.ls-servers/eclipse.jdt.ls' is the path to the server (update it accordingly in 'JAR' and in '-configuration')
# ----------------------------------------------------------------------------
# Options for '-configuration':
#	config_win
#	config_mac
#	config_linux

JAR="$HOME/.ls-servers/eclipse-jdt-ls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle /usr/lib/jvm/default-java/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.ls-servers/eclipse-jdt-ls/config_linux" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
#endOfFile
