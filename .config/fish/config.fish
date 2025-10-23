#===================================
# @author: Shashank Singh
# Theme: Tokyonight
#
# Configurations for the Fish shell
#===================================

# ========================
# Set Default Theme
# ========================

fish_config theme choose tokyonight

# ========================
# Load utility functions
# ========================

source ~/.config/fish/functions/utility_functions.fish

# ========================
# Initialize SSH Agent
# ========================

#init_ssh_agent

# ========================
# Initialize Starship
# ========================

starship init fish | source

# ========================
# Environment Variables
# ========================

set -x -g EDITOR $HOME/.local/bin/lvim # Default editor
set -x -g CHROME_EXECUTABLE /opt/brave-bin/brave # For Flutter to detect the browser
set -x -g JAVA_HOME /usr/lib/jvm/java-21-openjdk # OpenJDK 21 LTS
set -x -g GRADLE_HOME /usr/share/java/gradle # Gradle (Latest)
set -x -g SSH_AUTH_SOCK /run/user/1000/gcr/ssh
set -x -g ANDROID_HOME "$HOME/Android/Sdk"

# ========================
# Environment Variables
# ========================

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
end
