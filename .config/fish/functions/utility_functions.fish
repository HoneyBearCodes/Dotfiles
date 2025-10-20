#=================================
# @author: Shashank Singh
#
# Commonly used utility functions
#=================================

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function bak --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Displays added shell paths 
function fish_display_paths
    echo $fish_user_paths | tr " " "\n" | nl
end

# Removes specified path from path
function fish_remove_path
    set --erase --universal fish_user_paths[$argv]
end

# Initialize flutter project with gradle-8.5
function create_flutter_project
    if test (count $argv) -ne 1
        echo "Usage: create_flutter_project <project_name>"
        return 1
    end
    set project_name $argv[1]
    flutter create $project_name
    cd $project_name/android/
    sed -i 's#distributionUrl=.*#distributionUrl=file:///opt/gradle-8.5/wrappers/dists/gradle-8.5-all.zip#' gradle/wrapper/gradle-wrapper.properties
    ./gradlew wrapper
end

# Download a m3u8 playlist/fisle as an MKV file using yt-dlp
function m3u8dl
    if test (count $argv) -lt 2
        echo "Usage: m3u8dl <url> <name_without_extension>"
        return 1
    end
    yt-dlp --no-check-certificate -f best $argv[1] -o "$argv[2].mkv" --merge-output-format mkv
end
