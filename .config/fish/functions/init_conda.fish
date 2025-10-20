#===========================================
# @author: Shashank Singh
#
# Function to initialize Anaconda on-demand
#===========================================

function init_conda
    # Check if the conda executable exists
    if test -f /opt/anaconda3/bin/conda
        eval /opt/anaconda3/bin/conda "shell.fish" hook $argv | source
    else
        if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
            . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH /opt/anaconda3/bin $PATH
        end
    end

end
