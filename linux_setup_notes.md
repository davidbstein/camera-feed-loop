# When setting up on linux

You need a v4l2 loopback virtual camera setup. There are some important settings:

```
  exclusive_caps=1 # needed so chrome will actually recognize the camera, but messed with multiple things accessing stream at once
  devices=2 # if you're doing OBS, you need to loopbacks, one for the camera, one for the processed feed.
```


Use modprobe to unload and reload the driver from the kernel:

```
sudo modprobe -r v4l2loopback
modprobe v4l2loopback devices=2 \
  video_nr=0 card_label="Loopback Camera" exclusive_caps=1 \
  video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  # creates two vitual cameras on /dev/video0 and /dev/video1 (from the nr arguments)
```
