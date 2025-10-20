local mp = require("mp")
local utils = require("mp.utils")

-- Helper to run yad and capture output (strips trailing newline)
local function get_output(args)
	local res = utils.subprocess({ args = args, cancellable = false })
	if res.status == 0 then
		return res.stdout:gsub("\n$", "")
	else
		return nil
	end
end

-- Open a video file
local function open_file()
	local file = get_output({
		"yad",
		"--ontop",
		"--file",
		"--title=Select Video File",
		"--file-filter=Video files | *.mp4 *.mkv *.avi *.mov *.flv *.webm *.mpg *.mpeg *.ts",
		"--width=600",
		"--height=400",
	})
	if file then
		mp.commandv("loadfile", file, "replace")
	end
end

-- Open a subtitle file
local function open_subtitle()
	local subtitle = get_output({
		"yad",
		"--ontop",
		"--file",
		"--title=Select Subtitle File",
		"--file-filter=Subtitle files | *.srt *.ass *.vtt *.sub",
		"--width=600",
		"--height=400",
	})
	if subtitle then
		mp.commandv("sub-add", subtitle)
	end
end

-- Enter a network stream URL
local function open_url()
	local url = get_output({
		"yad",
		"--ontop",
		"--entry",
		"--title=Enter Network Stream URL",
		"--text=Enter the URL:",
		"--width=500",
	})
	if url and url ~= "" then
		mp.commandv("loadfile", url, "replace")
	end
end

-- Select a folder as playlist
local function open_folder_playlist()
	local folder = get_output({
		"yad",
		"--ontop",
		"--file",
		"--directory",
		"--title=Select Folder as Playlist",
		"--width=600",
		"--height=400",
	})
	if folder then
		mp.commandv("loadfile", folder, "replace")
	end
end

-- Select a playlist file
local function open_playlist_file()
	local playlist = get_output({
		"yad",
		"--ontop",
		"--file",
		"--title=Select Playlist File",
		"--file-filter=Playlist files | *.m3u *.m3u8 *.pls *.xspf",
		"--width=600",
		"--height=400",
	})
	if playlist then
		mp.commandv("loadlist", playlist, "replace")
	end
end

-- Bind keys from input.conf
mp.add_key_binding("Ctrl+o", "open_file", open_file)
mp.add_key_binding("Ctrl+Shift+o", "open_subtitle", open_subtitle)
mp.add_key_binding("Ctrl+n", "open_url", open_url)
mp.add_key_binding("Ctrl+p", "open_folder_playlist", open_folder_playlist)
mp.add_key_binding("Ctrl+Shift+p", "open_playlist_file", open_playlist_file)
