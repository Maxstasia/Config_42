#!/bin/bash

# Path to your media file
MEDIA_FILE="../../Wallpapers/wallpaper.png"

# Determine file extension (lowercase for consistency)
EXT=$(echo "${MEDIA_FILE##*.}" | tr '[:upper:]' '[:lower:]')

# Set VLC options based on file type
if [ "$EXT" = "png" ]; then
    # For PNG, use --image-duration to refresh image to simulate looping
    VLC_OPTIONS="--fullscreen --no-osd --loop --no-audio --video-on-top"
elif [ "$EXT" = "gif" ]; then
    # For GIF, use --demux=ffmpeg and --codec=ffmpeg to force animation
    VLC_OPTIONS="--fullscreen --no-osd --loop --no-audio --demux=ffmpeg --codec=ffmpeg --video-on-top"
else
    # For MP4 and others, use --loop
    VLC_OPTIONS="--fullscreen --no-osd --loop --no-audio --video-on-top"
fi

# Display media in full-screen mode using VLC
vlc $VLC_OPTIONS "$MEDIA_FILE" &

# Give VLC a moment to open the media
sleep 3

# Run the original ft_lock command
/usr/local/bin/ft_lock &

# Wait for ft_lock window to appear
sleep 1

# Get the window ID of ft_lock
WINDOW_ID=$(xwininfo -name ft_lock 2>/dev/null | grep "Window id" | grep -o "0x[^ ]*")

# Resize and move the ft_lock window
xdotool windowsize --sync $WINDOW_ID 550 150
xdotool windowmove --sync $WINDOW_ID 0 0

# Original loop to click on the ft_lock window
while (xwininfo -name ft_lock 1>/dev/null 2>/dev/null)
do
    sleep 1
    xdotool click 1
done

# Close VLC when the loop ends (i.e., when ft_lock window closes, likely on re-login)
pkill vlc
