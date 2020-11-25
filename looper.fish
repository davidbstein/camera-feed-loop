#!/usr/bin/fish
##################
# key functions: #
##################
function capture_raw
    # replace with your camera command if it is different (it probably isn't)
    gphoto2 --stdout --capture-movie
end
function clean_capture
    # if it makes you feel better, add a function to confirm camera is now off.
    echo "killing capture scripts..."
    kill (ps aux | grep gphoto | awk '{print }');
end

###################
# Video capture   #
###################
echo "initial stream - press ctrl+c to begin capture"
capture_raw | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 2> /dev/null

echo "recording loop..."
capture_raw | tee -i raw-loop-data | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 2> /dev/null
clean_capture


############
# Playback #
############
echo "starting playback"
while true
    pv -L 824k < raw-loop-data | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 2> /dev/null
end
echo "done"
