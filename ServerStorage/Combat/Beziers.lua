local module = {}

function module.Bezier(t, p0, p1)
	return p0 + (p1 - p0) * t
end

function module.quadraticBezier(t, p0, p1, p2)
	return (1 - t)^2 * p0 + 2 * (1 - t) * t * p1 + t^2 * p2
end

function module.cubicBezier(t, p0, p1, p2, p3)
	return (1 - t)^3 * p0 + 3 * (1 - t)^2 * t * p1 + 3 * (1 - t) * t^2 * p2 + t^3 * p3
end


return module
