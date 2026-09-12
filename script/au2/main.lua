--information:PixelSnap_S ${PACKAGE_VERSION} by ${AUTHOR}
--label:配置
--require:${LEAST_AVIUTL_VERSION}
local obj, math = obj, math;
local cx0, cy0, cz0 = obj.getvalue("center");
cx0, cy0, cz0 = obj.cx + cx0 + obj.w / 2, obj.cy + cy0 + obj.h / 2, obj.cz + cz0;
local cx, cy = math.floor(0.5 + cx0 + cy0), math.floor(0.5 + cx0 - cy0);
cx, cy = (cx + cy) / 2, (cx - cy) / 2;

local sx, sy, sz = obj.getvalue("scale");
sx, sy, sz = obj.sx * sx, obj.sy * sy, obj.sz * sz;

local rx, ry, rz = obj.getvalue("angle");
rx, ry, rz =
	2 * math.pi * (((obj.rx + rx) / 360) % 1),
	2 * math.pi * (((obj.ry + ry) / 360) % 1),
	2 * math.pi * (((obj.rz + rz) / 360) % 1);
local c_x, s_x, c_y, s_y, c_z, s_z =
	math.cos(rx), math.sin(rx), math.cos(ry), math.sin(ry), math.cos(rz), math.sin(rz);

local x0, y0, z0 = obj.getvalue("pos");
x0, y0, z0 = x0 + obj.ox, y0 + obj.oy, y0 + obj.oz;

local dx, dy, dz = cx - cx0, cy - cy0, -cz0;
dx, dy, dz = sx * dx, sy * dy, sz * dz;
dx, dy = c_z * dx - s_z * dy, s_z * dx + c_z * dy;
dz, dx = c_y * dz - s_y * dx, s_y * dz + c_y * dx;
dy, dz = c_x * dy - s_x * dz, s_x * dy + c_x * dz;

local group_layer = obj.getoption("group_info");
if group_layer > 0 then
    -- group control up to one level.
	sx = obj.getvalue(group_layer, "グループ制御", "拡大率") / 100;
	rx, ry, rz =
		2 * math.pi * ((obj.getvalue(group_layer, "グループ制御", "X軸回転") / 360) % 1),
		2 * math.pi * ((obj.getvalue(group_layer, "グループ制御", "Y軸回転") / 360) % 1),
		2 * math.pi * ((obj.getvalue(group_layer, "グループ制御", "Z軸回転") / 360) % 1);
	c_x, s_x, c_y, s_y, c_z, s_z =
		math.cos(rx), math.sin(rx), math.cos(ry), math.sin(ry), math.cos(rz), math.sin(rz);

	dx, dy, dz = sx * dx, sx * dy, sx * dz;
	dx, dy = c_z * dx - s_z * dy, s_z * dx + c_z * dy;
	dz, dx = c_y * dz - s_y * dx, s_y * dz + c_y * dx;
	dy, dz = c_x * dy - s_x * dz, s_x * dy + c_x * dz;

	x0, y0, z0 = sx * x0, sx * y0, sx * z0;
	x0, y0 = c_z * x0 - s_z * y0, s_z * x0 + c_z * y0;
	z0, x0 = c_y * z0 - s_y * x0, s_y * z0 + c_y * x0;
	y0, z0 = c_x * y0 - s_x * z0, s_x * y0 + c_x * z0;

	x0, y0, z0 =
		x0 + obj.getvalue(group_layer, "グループ制御", "X"),
		y0 + obj.getvalue(group_layer, "グループ制御", "Y"),
		z0 + obj.getvalue(group_layer, "グループ制御", "Z");
end

x0, y0 = x0 + obj.screen_w / 2, y0 + obj.screen_h / 2;
local x, y, frac = x0 + dx, y0 + dy, cx % 1;
x, y =
	math.floor(0.5 + x - frac) + frac,
	math.floor(0.5 + y - frac) + frac;
dx, dy, dz = x - x0, y - y0, 0;
if group_layer > 0 then
    -- apply the inverse transform of the group control.
	dy, dz = c_x * dy + s_x * dz, -s_x * dy + c_x * dz;
	dz, dx = c_y * dz + s_y * dx, -s_y * dz + c_y * dx;
	dx, dy = c_z * dx + s_z * dy, -s_z * dx + c_z * dy;
	dx, dy, dz = dx / sx, dy / sx, dz / sx;
end
obj.ox, obj.oy, obj.oz = obj.ox + dx, obj.oy + dy, obj.oz + dz;
obj.cx, obj.cy = obj.cx + (cx - cx0), obj.cy + (cy - cy0);
