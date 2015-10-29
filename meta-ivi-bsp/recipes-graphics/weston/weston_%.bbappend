FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

### [an - 10/01/15] This is the only backend that seems to work for now.
EXTRA_OECONF_append_raspberrypi2 += "\
    --enable-simple-egl-clients  \
    WESTON_NATIVE_BACKEND=fbdev-backend.so \
    "
    
### [an - 10/01/15] Taken from meta-tizen-common-base/recipe-graphics/weston/weston.inc and weston-extraconf.inc

EXTRA_OECONF_append_raspberrypi2 += "   \
                    --enable-simple-clients \
                    --enable-clients \
                    --enable-wayland-compositor \
                    --enable-weston-launch \
                    --enable-drm-compositor \
                    --enable-egl \
                    --enable-fbdev-compositor \
                    --enable-setuid-install \
                    --enable-demo-clients-install \
                    --disable-vaapi-recorder \
                    --disable-headless-compositor \
                    --disable-lcms \
                    --disable-webp \
                    --disable-static \
                    --disable-setuid-install \
                    --disable-libunwind \
                    --disable-xwayland \
                    --disable-xwayland-test \
                    --disable-x11-compositor \ 
                    --disable-rpi-compositor \
                    "

EXTRA_OECONF_append_raspberrypi2 += " --disable-static --disable-setuid-install --enable-simple-clients --enable-clients --disable-libunwind --disable-xwayland --disable-xwayland-test --disable-x11-compositor --disable-rpi-compositor"
# The current experimental vc4 drivers for RPI2 don't like the glesv2 backend
#	so, only enable it for archs where this is known to work

EXTRA_OECONF_append_raspberrypi2 += "${@bb.utils.contains('PACKAGECONFIG', 'cairo-glesv2', ' --with-cairo=glesv2', '', d)}"
DEPENDS_append_raspberrypi2 += "${@bb.utils.contains('PACKAGECONFIG', 'cairo-glesv2', 'virtual/libgles2', '', d)}"

EXTRA_OECONF_append_raspberrypi2 += "   --disable-rdp-compositor "
EXTRA_OECONF_append_raspberrypi2 += "   --disable-dbus"

CFLAGS_append_raspberrypi2 +=" -I${STAGING_DIR_TARGET}/usr/include/interface/vcos/pthreads \
             -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/linux \
             "
