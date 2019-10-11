DESCRIPTION = "Units to initialize CAN buffer pins"

inherit systemd

COMPATIBLE_MACHINE = "(beaglebone)"
PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI = "file://set-can-pins.service \
           file://set-can-pins.sh \
          "

do_install() {
	install -d ${D}${base_libdir}/systemd/system
	install -m 0644 ${WORKDIR}/*.service ${D}${base_libdir}/systemd/system

	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/*.sh ${D}${bindir}

	install -d ${D}${sysconfdir}/systemd/system/network.target.wants
	( cd ${D}${sysconfdir}/systemd/system/network.target.wants && 
	ln -s ${D}${base_libdir}/systemd/system/set-can-pins.service set-can-pins.service 
	)
}

ALLOW_EMPTY_${PN} = "1"

FILES_${PN} = "${base_libdir}/systemd/system/set-can-pins.service \
               ${bindir}/set-can-pins.sh \
               ${sysconfdir}/systemd/ \
              "

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "set-can-pins.service"
