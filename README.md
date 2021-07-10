# raspi3-dual

The main goal of this project is to set up a Rasberry 3B+ for Dual-Screen operation, running the internal Display and the HDMI as two indepedend X-Window displays. 

In this case we do **not** want the mouse to move from screen to the other **nor** mmove any windows between the screens.

There are several instructions on the internet such as:

Which describe the same approach for running them as one big Desktop as we know it from Windows or MacOS.

Since I am an old-school programmer, I love the vanilla X11 tools:

```
sudo apt-get install xterm
````

now we can run two independend XServers an launch an xterm on each

```
sudo X :0 -layout Singlehead0 -sharevts &
xterm -d :0
````
should open an xterm on the 1st screen.

```
sudo X :1 -layout Singlehead1 -sharevts &
xterm -d :1
```

should open an xterm on the 2nd screen.

See, there are two X-Server running:

```
> ps -ef | grep X
root      4294   981  0 08:55 pts/0    00:00:00 sudo X :0 -layout Singlehead0
root      4298  4294  0 08:55 tty2     00:00:00 /usr/lib/xorg/Xorg :0 -layout Singlehead0
root      4349  4330  0 08:57 pts/3    00:00:00 sudo X :1 -layout Singlehead1
root      4353  4349  0 08:57 tty3     00:00:00 /usr/lib/xorg/Xorg :1 -layout Singlehead1
pi        4436  4414  0 08:58 pts/6    00:00:00 grep --color=auto X
```

to determine the resoution of your screens:
```
xwininfo -root -display :0
xwininfo -root -display :1
```
for calling Chrome in Kiosk mode, which was my main goal for this hack:
```
chromium-browser http://example.com -window-size=1920,1200 --start-fullscreen --kiosk --incognito --noerrdialogs --disable-translate --no-first-run --fast --fast-start --disable-infobars --disable-features=TranslateUI --disk-cache-dir=/dev/null  --password-store=basic --user-data-dir=/tmp/1 --display=:1
```
and
```
chromium-browser http://example.com -window-size=800,480 --start-fullscreen --kiosk --incognito --noerrdialogs --disable-translate --no-first-run --fast --fast-start --disable-infobars --disable-features=TranslateUI --disk-cache-dir=/dev/null  --password-store=basic --user-data-dir=/tmp/0 --display=:0
```
this is mainly kiosk mode plus ```--user-data-dir=/tmp/X```, which prevents chromium to open just another tab in the first chromium on screen 1, rather then starting a new instance. 

---

I used the following ressources on the web for this configuration, thanks to all the people out there for their work.

* https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=246384&p=1504644&hilit=Dual+framebuffer#p1504551 - a good primer, I got the 99-fbturbo.conf from there and let it mainly unchanged.
* https://www.x.org/archive/X11R6.8.0/doc/xorg.conf.5.html - the xorg.conf manpage 
* https://www.oreilly.com/library/view/x-power-tools/9780596101954/ch04.html - more descriptive than the manpage
* https://sylvaindurand.org/launch-chromium-in-kiosk-mode/ - launching Chrome in kiosk mode