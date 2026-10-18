package ayp_gui

import "beetpx:bpxd"
import "beetpx:bpx"
import "../g"

topbar_draw :: proc() {
	bpxd.rect_filled(g.TOPBAR_XY, g.TOPBAR_WH, bpx.p_pico8_black)
}
