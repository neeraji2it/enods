/*
 Highcharts JS v2.0.0 (2010-07-13)
 
 (c) 2009-2010 Torstein H�nsi
 
 License: www.highcharts.com/license
 */
(function() {
    function O(a, b) {
        a || (a = {});
        for (var c in b)
            a[c] = b[c];
        return a
    }
    function S(a) {
        return a !== Ya && a !== null
    }
    function oa(a, b, c) {
        var d, e = "setAttribute", f;
        if (typeof b == "string")
            if (S(c))
                a[e](b, c);
            else {
                if (a && a.getAttribute)
                    f = a.getAttribute(b)
            }
        else if (S(b) && typeof b == "object")
            for (d in b)
                a[e](d, b[d]);
        return f
    }
    function oc(a) {
        if (!a || a.constructor != Array)
            a = [a];
        return a
    }
    function A() {
        var a = arguments, b, c;
        for (b = 0; b < a.length; b++) {
            c = a[b];
            if (S(c))
                return c
        }
    }
    function pc(a) {
        var b = "", c;
        for (c in a)
            b += qc(c) + ":" + a[c] +
                    ";";
        return b
    }
    function Sa(a, b) {
        if (Lc)
            if (b && b.opacity !== Ya)
                b.filter = "alpha(opacity=" + b.opacity * 100 + ")";
        O(a.style, b)
    }
    function Da(a, b, c, d, e) {
        a = la.createElement(a);
        b && O(a, b);
        e && Sa(a, {padding: 0, border: fb, margin: 0});
        c && Sa(a, c);
        d && d.appendChild(a);
        return a
    }
    function Mc() {
        var a = sa.global.useUTC;
        $b = a ? Date.UTC : function(b, c, d, e, f, g) {
            return(new Date(b, c, A(d, 1), A(e, 0), A(f, 0), A(g, 0))).getTime()
        };
        rc = a ? "getUTCMinutes" : "getMinutes";
        sc = a ? "getUTCHours" : "getHours";
        tc = a ? "getUTCDay" : "getDay";
        Rb = a ? "getUTCDate" : "getDate";
        ac = a ? "getUTCMonth" : "getMonth";
        bc = a ? "getUTCFullYear" : "getFullYear";
        Nc = a ? "setUTCMinutes" : "setMinutes";
        Oc = a ? "setUTCHours" : "setHours";
        uc = a ? "setUTCDate" : "setDate";
        Pc = a ? "setUTCMonth" : "setMonth";
        Qc = a ? "setUTCFullYear" : "setFullYear"
    }
    function dd(a) {
        sa = ia(sa, a);
        Mc();
        return sa
    }
    function cc(a) {
        dc || (dc = Da(yb));
        a && dc.appendChild(a);
        dc.innerHTML = ""
    }
    function gb(a, b) {
        var c = function() {
        };
        c.prototype = new a;
        O(c.prototype, b);
        return c
    }
    function ed(a, b, c, d) {
        var e = sa.lang;
        a = a;
        var f = isNaN(b = Za(b)) ? 2 : b;
        b = c === undefined ? e.decimalPoint :
                c;
        d = d === undefined ? e.thousandsSep : d;
        e = a < 0 ? "-" : "";
        c = parseInt(a = Za(+a || 0).toFixed(f), 10) + "";
        var g = (g = c.length) > 3 ? g % 3 : 0;
        return e + (g ? c.substr(0, g) + d : "") + c.substr(g).replace(/(\d{3})(?=\d)/g, "$1" + d) + (f ? b + Za(a - c).toFixed(f).slice(2) : "")
    }
    function fd(a) {
        for (var b = {x: a.offsetLeft, y: a.offsetTop}; a.offsetParent; ) {
            a = a.offsetParent;
            b.x += a.offsetLeft;
            b.y += a.offsetTop;
            if (a != la.body && a != la.documentElement) {
                b.x -= a.scrollLeft;
                b.y -= a.scrollTop
            }
        }
        return b
    }
    function ec() {
    }
    function gd(a) {
        function b(l, h) {
            function t() {
                var k =
                        [], p;
                F = K = null;
                P = [];
                q(ta, function(s) {
                    p = false;
                    q(["xAxis", "yAxis"], function(G) {
                        if (s.isCartesian && (G == "xAxis" && Q || G == "yAxis" && !Q) && (s.options[G] == h.index || s.options[G] === Ya && h.index === 0)) {
                            s[G] = aa;
                            P.push(s);
                            p = true
                        }
                    });
                    if (!s.visible && H.ignoreHiddenSeries)
                        p = false;
                    if (p) {
                        var y, B;
                        if (!Q) {
                            y = s.options.stacking;
                            fc = y == "percent";
                            if (y) {
                                B = k[s.type] || [];
                                k[s.type] = B
                            }
                            if (fc) {
                                F = 0;
                                K = 99
                            }
                        }
                        if (s.isCartesian) {
                            q(s.data, function(G) {
                                var I = G.x, ca = G.y;
                                if (F === null)
                                    F = K = G[nb];
                                if (Q)
                                    if (I > K)
                                        K = I;
                                    else {
                                        if (I < F)
                                            F = I
                                    }
                                else if (S(ca)) {
                                    if (y)
                                        B[I] = B[I] ?
                                                B[I] + ca : ca;
                                    G = B ? B[I] : ca;
                                    if (!fc)
                                        if (G > K)
                                            K = G;
                                        else if (G < F)
                                            F = G;
                                    if (y)
                                        $a[s.type][I] = {total: G, cum: G}
                                }
                            });
                            if (/(area|column|bar)/.test(s.type) && !Q)
                                if (F >= 0) {
                                    F = 0;
                                    Rc = true
                                } else if (K < 0) {
                                    K = 0;
                                    Sc = true
                                }
                        }
                    }
                })
            }
            function v(k, p, s) {
                var y = 1, B = 0;
                if (s) {
                    y *= -1;
                    B = La
                }
                if (zb) {
                    y *= -1;
                    B -= y * La
                }
                if (p) {
                    if (zb)
                        k = La - k;
                    k = k / hb + N
                } else
                    k = y * (k - N) * hb + B;
                return k
            }
            function D(k, p, s) {
                if (s) {
                    var y, B, G;
                    y = v(k);
                    var I;
                    k = B = y + Ab;
                    y = G = Aa - y - Ab;
                    if (T) {
                        y = ja;
                        G = Aa - Bb;
                        if (k < Y || k > Y + wa)
                            I = true
                    } else {
                        k = Y;
                        B = Ma - vc;
                        if (y < ja || y > ja + pa)
                            I = true
                    }
                    I || L.path(L.crispLine([ib, k, y, Na, B, G], s)).attr({stroke: p,
                        "stroke-width": s}).add(M)
                }
            }
            function J(k, p, s) {
                k = sb(k, N);
                p = Lb(p, U);
                var y = (p - k) * hb;
                D(k + (p - k) / 2, s, y)
            }
            function E(k, p, s, y, B, G, I) {
                var ca, pb, Z, Ta = h.labels;
                if (p == "inside")
                    B = -B;
                if (da)
                    B = -B;
                p = pb = v(k + Cb) + Ab;
                ca = Z = Aa - v(k + Cb) - Ab;
                if (T) {
                    ca = Aa - Bb - (da ? pa : 0) + Ua;
                    Z = ca + B
                } else {
                    p = Y + (da ? wa : 0) + Ua;
                    pb = p - B
                }
                y && L.path(L.crispLine([ib, p, ca, Na, pb, Z], y)).attr({stroke: s, "stroke-width": y}).add(r);
                if (G && Ta.enabled)
                    if ((k = gc.call({index: I, isFirst: k == ba[0], isLast: k == ba[ba.length - 1], value: Oa && Oa[k] ? Oa[k] : k})) || k === 0) {
                        p = p + Ta.x - (Cb && T ? Cb * hb *
                                (zb ? -1 : 1) : 0);
                        ca = ca + Ta.y - (Cb && !T ? Cb * hb * (zb ? 1 : -1) : 0);
                        L.text(k, p, ca, Ta.style, Ta.rotation, Ta.align).add(r)
                    }
            }
            function ka(k, p) {
                var s;
                tb = p ? 1 : Fa.pow(10, jb(Fa.log(k) / Fa.LN10));
                s = k / tb;
                if (!p) {
                    p = [1, 2, 2.5, 5, 10];
                    if (h.allowDecimals === false)
                        if (tb == 1)
                            p = [1, 2, 5, 10];
                        else if (tb <= 0.1)
                            p = [1 / tb]
                }
                for (var y = 0; y < p.length; y++) {
                    k = p[y];
                    if (s <= (p[y] + (p[y + 1] || p[y])) / 2)
                        break
                }
                k *= tb;
                return k
            }
            function ua() {
                ba = [];
                var k, p = sa.global.useUTC, s = 1E3 / ab, y = 6E4 / ab, B = 36E5 / ab, G = 864E5 / ab, I = 6048E5 / ab, ca = 2592E6 / ab, pb = 31556952E3 / ab, Z = [["second", s, [1,
                            2, 5, 10, 15, 30]], ["minute", y, [1, 2, 5, 10, 15, 30]], ["hour", B, [1, 2, 3, 4, 6, 8, 12]], ["day", G, [1, 2]], ["week", I, [1, 2]], ["month", ca, [1, 2, 3, 4, 6]], ["year", pb, null]], Ta = Z[6], ea = Ta[1], V = Ta[2];
                for (k = 0; k < Z.length; k++) {
                    Ta = Z[k];
                    ea = Ta[1];
                    V = Ta[2];
                    if (Z[k + 1]) {
                        var hd = (ea * V[V.length - 1] + Z[k + 1][1]) / 2;
                        if (Pa <= hd)
                            break
                    }
                }
                if (ea == pb && Pa < 5 * ea)
                    V = [1, 2, 5];
                Z = ka(Pa / ea, V);
                var ub;
                V = new Date(N * ab);
                V.setMilliseconds(0);
                if (ea >= s)
                    V.setSeconds(ea >= y ? 0 : Z * jb(V.getSeconds() / Z));
                if (ea >= y)
                    V[Nc](ea >= B ? 0 : Z * jb(V[rc]() / Z));
                if (ea >= B)
                    V[Oc](ea >= G ? 0 : Z * jb(V[sc]() /
                            Z));
                if (ea >= G)
                    V[uc](ea >= ca ? 1 : Z * jb(V[Rb]() / Z));
                if (ea >= ca) {
                    V[Pc](ea >= pb ? 0 : Z * jb(V[ac]() / Z));
                    ub = V[bc]()
                }
                if (ea >= pb) {
                    ub -= ub % Z;
                    V[Qc](ub)
                }
                ea == I && V[uc](V[Rb]() - V[tc]() + h.startOfWeek);
                k = 1;
                ub = V[bc]();
                s = V.getTime() / ab;
                y = V[ac]();
                for (B = V[Rb](); s < U && k < wa; ) {
                    ba.push(s);
                    if (ea == pb)
                        s = $b(ub + k * Z, 0) / ab;
                    else if (ea == ca)
                        s = $b(ub, y + k * Z) / ab;
                    else if (!p && (ea == G || ea == I))
                        s = $b(ub, y, B + k * Z * (ea == G ? 1 : 7));
                    else
                        s += ea * Z;
                    k++
                }
                ba.push(s);
                h.labels.formatter || (gc = function() {
                    return hc(h.dateTimeLabelFormats[Ta[0]], this.value, 1)
                })
            }
            function fa(k) {
                var p =
                        (tb < 1 ? W(1 / tb) : 1) * 10;
                return W(k * p) / p
            }
            function Ea() {
                var k;
                k = jb(N / Pa) * Pa;
                var p = Fa.ceil(U / Pa) * Pa;
                ba = [];
                for (k = fa(k); k <= p; ) {
                    ba.push(k);
                    k = fa(k + Pa)
                }
                if (Oa) {
                    N -= 0.5;
                    U += 0.5
                }
                gc || (gc = function() {
                    return this.value
                })
            }
            function xa() {
                kb ? ua() : Ea();
                var k = ba[0], p = ba[ba.length - 1];
                if (h.startOnTick)
                    N = k;
                else
                    N > k && ba.shift();
                if (h.endOnTick)
                    U = p;
                else
                    U < p && ba.pop()
            }
            function ya() {
                if (!kb && !Oa) {
                    var k = Mb, p = ba.length;
                    Mb = Nb[nb];
                    if (p < Mb) {
                        for (; ba.length < Mb; )
                            ba.push(fa(ba[ba.length - 1] + Pa));
                        hb *= (p - 1) / (Mb - 1)
                    }
                    if (S(k) && Mb != k)
                        aa.isDirty = true
                }
            }
            function bb() {
                var k, p, s, y = N, B = U;
                k = h.maxZoom;
                var G;
                t();
                N = A(Ba, h.min, F);
                U = A(Sb, h.max, K);
                if (U - N < k) {
                    G = (k - U + N) / 2;
                    N = sb(N - G, A(h.min, N - G));
                    U = Lb(N + k, A(h.max, N + k))
                }
                if (!Oa && !fc && S(N) && S(U)) {
                    k = U - N || 1;
                    if (!S(h.min) && !S(Ba) && Tc && (F < 0 || !Rc))
                        N -= k * Tc;
                    if (!S(h.max) && !S(Sb) && Uc && (K > 0 || !Sc))
                        U += k * Uc
                }
                Pa = Oa || N == U ? 1 : A(h.tickInterval, (U - N) * h.tickPixelInterval / La);
                if (!kb && !S(h.tickInterval))
                    Pa = ka(Pa);
                wc = h.minorTickInterval === "auto" && Pa ? Pa / 5 : h.minorTickInterval;
                xa();
                hb = La / (U - N || 1);
                Nb || (Nb = {x: 0, y: 0});
                if (!kb && ba.length > Nb[nb])
                    Nb[nb] =
                            ba.length;
                if (!Q)
                    for (p in $a)
                        for (s in $a[p])
                            $a[p][s].cum = $a[p][s].total;
                if (!aa.isDirty)
                    aa.isDirty = N != y || U != B
            }
            function Ga(k, p, s) {
                s = A(s, true);
                za(aa, "setExtremes", {min: k, max: p}, function() {
                    if (Oa) {
                        if (k < 0)
                            k = 0;
                        if (p > Oa.length - 1)
                            p = Oa.length - 1
                    }
                    Ba = k;
                    Sb = p;
                    s && l.redraw()
                })
            }
            function Va() {
                return{min: N, max: U, dataMin: F, dataMax: K}
            }
            function qb(k) {
                if (N > 0)
                    k = N;
                else if (U < 0)
                    k = U;
                return v(k, 0, 1)
            }
            function X(k) {
                var p = k.width, s = p ? xc : yc;
                s.push(k);
                p ? D(k.value, k.color, k.width) : J(k.from, k.to, k.color)
            }
            function x() {
                var k = h.title, p = h.alternateGridColor,
                        s = h.minorTickWidth, y = h.lineWidth, B, G;
                B = P.length && S(N) && S(U);
                if (r) {
                    r.empty();
                    M.empty()
                } else {
                    r = L.g("axis").attr({zIndex: 7}).add();
                    M = L.g("grid").attr({zIndex: 1}).add()
                }
                if (B) {
                    p && q(ba, function(I, ca) {
                        if (ca % 2 === 0 && I < U)
                            J(I, ba[ca + 1] !== Ya ? ba[ca + 1] : U, p)
                    });
                    q(yc, function(I) {
                        J(I.from, I.to, I.color)
                    });
                    if (wc && !Oa)
                        for (B = N; B <= U; B += wc) {
                            D(B, h.minorGridLineColor, h.minorGridLineWidth);
                            s && E(B, h.minorTickPosition, h.minorTickColor, s, h.minorTickLength)
                        }
                    q(ba, function(I, ca) {
                        G = I + Cb;
                        D(G, h.gridLineColor, h.gridLineWidth);
                        E(I, h.tickPosition,
                                h.tickColor, h.tickWidth, h.tickLength, !(I == N && !h.showFirstLabel || I == U && !h.showLastLabel), ca)
                    });
                    q(xc, function(I) {
                        D(I.value, I.color, I.width)
                    })
                }
                if (!l.hasRendered) {
                    if (y) {
                        s = Y + (da ? wa : 0) + Ua;
                        B = Aa - Bb - (da ? pa : 0) + Ua;
                        L.path(L.crispLine([ib, T ? Y : s, T ? B : ja, Na, T ? Ma - vc : s, T ? B : Aa - Bb], y)).attr({stroke: h.lineColor, "stroke-width": y, zIndex: 7}).add()
                    }
                    if (!aa.axisTitle && k && k.text) {
                        y = T ? Y : ja;
                        y = {low: y + (T ? 0 : La), middle: y + La / 2, high: y + (T ? La : 0)}[k.align];
                        s = (T ? ja + pa : Y) + (T ? 1 : -1) * (da ? -1 : 1) * k.margin - (Lc ? parseInt(k.style.fontSize || 12, 10) /
                                3 : 0);
                        aa.axisTitle = L.text(k.text, T ? y : s + (da ? wa : 0) + Ua, T ? s - (da ? pa : 0) + Ua : y, k.style, k.rotation || 0, {low: "left", middle: "center", high: "right"}[k.align]).attr({zIndex: 7}).add()
                    }
                }
                aa.isDirty = false
            }
            function u(k) {
                q([yc, xc], function(p) {
                    for (var s = 0; s < p.length; s++)
                        if (p[s].id == k) {
                            p.splice(s, 1);
                            break
                        }
                });
                x()
            }
            function C() {
                Ob.resetTracker && Ob.resetTracker();
                x();
                q(P, function(k) {
                    k.isDirty = true
                })
            }
            function R(k, p) {
                aa.categories = Oa = k;
                q(P, function(s) {
                    s.translate();
                    s.setTooltipPoints(true)
                });
                aa.isDirty = true;
                A(p, true) && C()
            }
            var Q =
                    h.isX, da = h.opposite, T = ma ? !Q : Q, $a = {bar: {}, column: {}, area: {}, areaspline: {}, line: {}};
            h = ia(Q ? ic : zc, T ? da ? id : Vc : da ? jd : kd, h);
            var aa = this, kb = h.type == "datetime", Ua = h.offset || 0, nb = Q ? "x" : "y", La = T ? wa : pa, hb, Ab = T ? Y : Bb, r, M, F, K, P, Ba, Sb, U = null, N = null, Tc = h.minPadding, Uc = h.maxPadding, Rc, Sc, fc, Wc = h.events, Ac, yc = h.plotBands || [], xc = h.plotLines || [], Pa, wc, tb, ba, Mb, gc = h.labels.formatter, Oa = h.categories || Q && l.columnCount, zb = h.reversed, Cb = Oa && h.tickmarkPlacement == "between" ? 0.5 : 0;
            if (ma && Q && zb === Ya)
                zb = true;
            da || (Ua *= -1);
            if (T)
                Ua *=
                        -1;
            O(aa, {addPlotBand: X, addPlotLine: X, adjustTickAmount: ya, categories: Oa, getExtremes: Va, getZeroPlane: qb, isXAxis: Q, options: h, render: x, setExtremes: Ga, setScale: bb, setCategories: R, translate: v, redraw: C, removePlotBand: u, removePlotLine: u, reversed: zb, stacks: $a});
            for (Ac in Wc)
                cb(aa, Ac, Wc[Ac]);
            bb()
        }
        function c() {
            function l(v, D, J, E) {
                if (!t[v]) {
                    D = L.text(D, Y + wa - 20, ja + 30, a.toolbar.itemStyle, 0, "right").on("click", E).attr({zIndex: 20}).add();
                    t[v] = D
                }
            }
            function h(v) {
                cc(t[v].element);
                t[v] = null
            }
            var t = {};
            return{add: l, remove: h}
        }
        function d(l) {
            function h(X, x) {
                ya = fa ? X : (2 * ya + X) / 3;
                bb = fa ? x : (bb + x) / 2;
                Ga.translate(ya, bb);
                Bc = Za(X - ya) > 1 || Za(x - bb) > 1 ? function() {
                    h(X, x)
                } : null
            }
            function t() {
                fa = true;
                Ga.hide()
            }
            function v(X) {
                var x = X.series, u = l.borderColor || X.color || x.color || "#606060", C, R;
                R = X.tooltipText;
                C = X.tooltipPos;
                D = x;
                x = C ? C[0] : ma ? wa - X.plotY : X.plotX;
                X = C ? C[1] : ma ? pa - X.plotX : X.plotY;
                C = Tb(x, X);
                if (R === false || !C)
                    t();
                else {
                    if (fa) {
                        Ga.show();
                        fa = false
                    }
                    qb.attr({text: R});
                    R = qb.getBBox();
                    Ea = R.width;
                    xa = R.height;
                    Va.attr({width: Ea + 2 * ka, height: xa + 2 * ka, stroke: u});
                    u = x - Ea + Y - 25;
                    x = X - xa + ja + 10;
                    if (u < 7) {
                        u = 7;
                        x -= 20
                    }
                    if (x < 5)
                        x = 5;
                    else if (x + xa > Aa)
                        x = Aa - xa - 5;
                    h(W(u - ua), W(x - ua))
                }
            }
            var D, J = l.borderWidth, E = l.style, ka = parseInt(E.padding, 10), ua = J + ka, fa = true, Ea, xa, ya = 0, bb = 0;
            E.padding = 0;
            var Ga = L.g("tooltip").attr({zIndex: 8}).add(), Va = L.rect(ua, ua, 0, 0, l.borderRadius, J).attr({fill: l.backgroundColor, "stroke-width": J}).add(Ga).shadow(l.shadow), qb = L.text("", ka + ua, parseInt(E.fontSize, 10) + ka + ua).attr({zIndex: 1}).css(E).add(Ga);
            return{refresh: v, hide: t}
        }
        function e(l, h) {
            function t(x) {
                x = x || db.event;
                if (!x.target)
                    x.target = x.srcElement;
                if (!x.pageX)
                    x.pageX = x.clientX + (la.documentElement.scrollLeft || la.body.scrollLeft);
                if (!x.pageY)
                    x.pageY = x.clientY + (la.documentElement.scrollTop || la.body.scrollTop);
                return x
            }
            function v(x) {
                var u = {xAxis: [], yAxis: []};
                q(Qa, function(C) {
                    var R = C.translate, Q = C.isXAxis, da = ma ? !Q : Q;
                    u[Q ? "xAxis" : "yAxis"].push({axis: C, value: R(da ? x.pageX - lb.x - Y : pa - x.pageY + lb.y + ja, true)})
                });
                return u
            }
            function D(x) {
                var u = l.hoverPoint, C = l.hoverSeries;
                if (C && C.tracker)
                    (x = C.tooltipPoints[ma ? x.pageY - lb.y :
                            x.pageX - lb.x - Y]) && x != u && x.onMouseOver()
            }
            function J() {
                var x = l.hoverSeries, u = l.hoverPoint;
                u && u.onMouseOut();
                x && x.onMouseOut();
                Cc && Cc.hide()
            }
            function E() {
                if (ya) {
                    var x = {xAxis: [], yAxis: []}, u = ya.getBBox(), C = u.x - Y, R = u.y - ja;
                    if (xa) {
                        q(Qa, function(Q) {
                            var da = Q.translate, T = Q.isXAxis, $a = ma ? !T : T, aa = da($a ? C : pa - R - u.height, true);
                            da = da($a ? C + u.width : pa - R, true);
                            x[T ? "xAxis" : "yAxis"].push({axis: Q, min: Lb(aa, da), max: sb(aa, da)})
                        });
                        za(l, "selection", x, Dc)
                    }
                    ya = ya.destroy()
                }
                l.mouseIsDown = Ec = xa = false
            }
            function ka() {
                var x = true;
                Ha.onmousedown =
                        function(u) {
                            u = t(u);
                            u.preventDefault && u.preventDefault();
                            l.mouseIsDown = Ec = true;
                            fa = u.pageX;
                            Ea = u.pageY;
                            if (jc && (Ga || Va))
                                ya || (ya = L.rect(Y, ja, qb ? 1 : wa, X ? 1 : pa, 0).attr({fill: "rgba(69,114,167,0.25)", zIndex: 7}).add())
                        };
                Ha.onmousemove = function(u) {
                    u = t(u);
                    u.returnValue = false;
                    var C = u.pageX, R = u.pageY;
                    C = !Tb(C, R, "page");
                    if (Ec) {
                        xa = Math.sqrt(Math.pow(fa - u.pageX, 2) + Math.pow(Ea - u.pageY, 2)) > 10;
                        if (qb) {
                            R = u.pageX - fa;
                            ya.attr({width: Za(R), x: (R > 0 ? 0 : R) + fa - lb.x})
                        }
                        if (X) {
                            u = u.pageY - Ea;
                            ya.attr({height: Za(u), y: (u > 0 ? 0 : u) + Ea - lb.y})
                        }
                    } else
                        C ||
                                D(u);
                    if (C && !x) {
                        J();
                        E()
                    }
                    x = C;
                    return false
                };
                Ha.onmouseup = function() {
                    E()
                };
                Ha.onclick = function(u) {
                    var C = l.hoverPoint;
                    u = t(u);
                    u.cancelBubble = true;
                    if (!xa)
                        if (C && oa(u.target, "isTracker")) {
                            var R = C.plotX, Q = C.plotY;
                            O(C, {pageX: lb.x + Y + (ma ? wa - Q : R), pageY: lb.y + ja + (ma ? pa - R : Q)});
                            za(l.hoverSeries, "click", O(u, {point: C}));
                            C.firePointEvent("click", u)
                        } else {
                            O(u, v(u));
                            Tb(u.pageX, u.pageY, "page") && za(l, "click", u)
                        }
                    xa = false
                }
            }
            function ua() {
                l.trackerGroup = Fc = L.g("tracker");
                ma && Fc.attr({width: l.plotWidth, height: l.plotHeight}).invert();
                Fc.attr({zIndex: 9}).translate(Y, ja).add()
            }
            var fa, Ea, xa, ya, bb = H.zoomType, Ga = /x/.test(bb), Va = /y/.test(bb), qb = Ga && !ma || Va && ma, X = Va && !ma || Ga && ma;
            ua();
            if (h.enabled)
                l.tooltip = Cc = d(h);
            ka();
            Xc = setInterval(function() {
                Bc && Bc()
            }, 32);
            O(this, {zoomX: Ga, zoomY: Va, resetTracker: J})
        }
        function f(l) {
            var h = l.type || H.defaultSeriesType, t = eb[h], v = w.hasRendered;
            if (v)
                if (ma && h == "column")
                    t = eb.bar;
                else if (!ma && h == "bar")
                    t = eb.column;
            h = new t;
            h.init(w, l);
            if (!v && h.inverted)
                ma = true;
            if (h.isCartesian)
                jc = h.isCartesian;
            ta.push(h);
            return h
        }
        function g(l, h) {
            var t;
            h = A(h, true);
            za(w, "addSeries", {options: l}, function() {
                t = f(l);
                t.isDirty = true;
                w.isDirty = true;
                h && w.redraw()
            });
            return t
        }
        function j() {
            H.alignTicks !== false && q(Qa, function(l) {
                l.adjustTickAmount()
            })
        }
        function i() {
            for (var l = w.isDirty, h, t = ta.length, v = t, D; v--; ) {
                D = ta[v];
                if (D.isDirty && D.options.stacking) {
                    h = true;
                    break
                }
            }
            if (h)
                for (v = t; v--; ) {
                    D = ta[v];
                    if (D.options.stacking)
                        D.isDirty = true
                }
            q(ta, function(J) {
                if (J.isDirty) {
                    J.cleanData();
                    J.getSegments();
                    if (J.options.legendType == "point")
                        l = true
                }
            });
            Nb = null;
            if (jc) {
                q(Qa, function(J) {
                    J.setScale()
                });
                j();
                q(Qa, function(J) {
                    J.isDirty && J.redraw()
                })
            }
            q(ta, function(J) {
                J.isDirty && J.visible && J.redraw()
            });
            if (l && Gc.renderLegend) {
                Gc.renderLegend();
                w.isDirty = false
            }
            Ob && Ob.resetTracker && Ob.resetTracker();
            za(w, "redraw")
        }
        function m() {
            var l = a.loading;
            if (!Db) {
                Db = Da(yb, {className: "highcharts-loading"}, O(l.style, {left: Y + Ia, top: ja + Ia, width: wa + Ia, height: pa + Ia, zIndex: 10, display: fb}), Ha);
                Da("span", {innerHTML: a.lang.loading}, l.labelStyle, Db)
            }
            Sa(Db, {opacity: 0, display: ""});
            Ub(Db, {opacity: l.style.opacity},
            {duration: l.showDuration})
        }
        function o() {
            Ub(Db, {opacity: 0}, {duration: a.loading.hideDuration, complete: function() {
                    Sa(Db, {display: fb})
                }})
        }
        function n(l) {
            var h, t, v;
            for (h = 0; h < Qa.length; h++)
                if (Qa[h].options.id == l)
                    return Qa[h];
            for (h = 0; h < ta.length; h++)
                if (ta[h].options.id == l)
                    return ta[h];
            for (h = 0; h < ta.length; h++) {
                v = ta[h].data;
                for (t = 0; t < v.length; t++)
                    if (v[t].id == l)
                        return v[t]
            }
            return null
        }
        function z() {
            var l = la.getElementById(Hc);
            if (l)
                lb = fd(l)
        }
        function na() {
            var l = a.xAxis || {}, h = a.yAxis || {}, t;
            l = oc(l);
            q(l, function(v,
                    D) {
                v.index = D;
                v.isX = true
            });
            h = oc(h);
            q(h, function(v, D) {
                v.index = D
            });
            Qa = l.concat(h);
            w.xAxis = [];
            w.yAxis = [];
            Qa = Eb(Qa, function(v) {
                t = new b(w, v);
                w[t.isXAxis ? "xAxis" : "yAxis"].push(t);
                return t
            });
            j()
        }
        function ga() {
            var l = [];
            q(ta, function(h) {
                l = l.concat(kc(h.data, function(t) {
                    return t.selected
                }))
            });
            return l
        }
        function va() {
            return kc(ta, function(l) {
                return l.selected
            })
        }
        function ha() {
            var l = a.title, h = l.align, t = a.subtitle, v = t.align, D = {left: 0, center: Ma / 2, right: Ma};
            if (!w.titleLayer) {
                l && l.text && L.text(l.text, D[h] + l.x, l.y, l.style,
                        0, h).attr({"class": "highcharts-title"}).add();
                t && t.text && L.text(t.text, D[v] + t.x, t.y, t.style, 0, v).attr({"class": "highcharts-subtitle"}).add()
            }
        }
        function Wa() {
            mb = H.renderTo;
            Hc = Fb + Ic++;
            if (typeof mb == "string")
                mb = la.getElementById(mb);
            mb.innerHTML = "";
            if (!mb.offsetWidth) {
                vb = mb.cloneNode(0);
                Sa(vb, {position: Vb, top: "-9999px", display: ""});
                la.body.appendChild(vb)
            }
            var l = (vb || mb).offsetHeight;
            Ma = H.width || (vb || mb).offsetWidth || 600;
            Aa = H.height || (l > ja + Bb ? l : 0) || 400;
            Ha = Da(yb, {className: "highcharts-container" + (H.className ?
                        " " + H.className : ""), id: Hc}, O({position: Yc, overflow: Gb, width: Ma + Ia, height: Aa + Ia, textAlign: "left"}, H.style), vb || mb);
            w.renderer = L = H.renderer == "SVG" ? new Wb(Ha, Ma, Aa) : new Zc(Ha, Ma, Aa)
        }
        function Hb() {
            var l, h = a.labels, t = a.credits, v = H.borderWidth || 0, D = H.backgroundColor, J = H.plotBackgroundColor, E = H.plotBackgroundImage;
            l = 2 * v + (H.shadow ? 8 : 0);
            if (v || D)
                L.rect(l / 2, l / 2, Ma - l, Aa - l, H.borderRadius, v).attr({stroke: H.borderColor, "stroke-width": v, fill: D || fb}).add().shadow(H.shadow);
            J && L.rect(Y, ja, wa, pa, 0).attr({fill: J}).add().shadow(H.plotShadow);
            E && L.image(E, Y, ja, wa, pa).add();
            H.plotBorderWidth && L.rect(Y, ja, wa, pa, 0, H.plotBorderWidth).attr({"class": "plot-border", stroke: H.plotBorderColor, "stroke-width": H.plotBorderWidth, zIndex: 4}).add();
            jc && q(Qa, function(ka) {
                ka.render()
            });
            ha();
            h.items && q(h.items, function() {
                var ka = O(h.style, this.style), ua = parseInt(ka.left, 10) + Y, fa = parseInt(ka.top, 10) + ja + 12;
                delete ka.left;
                delete ka.top;
                L.text(this.html, ua, fa, ka).attr({zIndex: 2}).add()
            });
            q(ta, function(ka) {
                ka.render()
            });
            Gc = w.legend = new ld(w);
            if (!w.toolbar)
                w.toolbar =
                        c(w);
            t.enabled && !w.credits && L.text(t.text, Ma - 10, Aa - 5, t.style, 0, "right").on("click", function() {
                location.href = t.href
            }).attr({zIndex: 8}).add();
            w.hasRendered = true;
            if (vb) {
                mb.appendChild(Ha);
                cc(vb);
                z(Ha)
            }
        }
        function Pb() {
            var l = ta.length;
            wb(db, "resize", z);
            wb(db, "unload", Pb);
            wb(w);
            for (q(Qa, function(h) {
                wb(h)
            }); l--; )
                ta[l].destroy();
            Ha.innerHTML = "";
            Ha = null;
            clearInterval(Xc);
            for (l in w)
                delete w[l]
        }
        function Qb() {
            na();
            q(ta, function(l) {
                l.translate();
                l.setTooltipPoints()
            });
            w.render = Hb;
            Hb();
            za(w, "load")
        }
        ic = ia(ic, sa.xAxis);
        zc = ia(zc, sa.yAxis);
        sa.xAxis = sa.yAxis = null;
        a = ia(sa, a);
        var H = a.chart, Ja = H.margin;
        Ja = typeof Ja == "number" ? [Ja, Ja, Ja, Ja] : Ja;
        var ja = A(H.marginTop, Ja[0]), vc = A(H.marginRight, Ja[1]), Bb = A(H.marginBottom, Ja[2]), Y = A(H.marginLeft, Ja[3]), mb, vb, Ha, Hc, Ma, Aa, w = this;
        Ja = H.events;
        var Xb, Jc, Tb, Cc, Ec, Db, pa, wa, Ob, Fc, Gc, lb, jc = H.showAxes, Qa = [], Nb, ta = [], ma, L, Bc, Xc, Dc, $c, ld = function(l) {
            function h(r, M) {
                var F = r.legendItem, K = r.legendLine, P = r.legendSymbol, Ba = Ga.color, Sb = M ? E.itemStyle.color : Ba;
                r = M ? r.color : Ba;
                F && F.attr({fill: Sb});
                K && K.attr({stroke: r});
                P && P.attr({stroke: r, fill: r})
            }
            function t(r, M, F) {
                var K = r.legendItem, P = r.legendLine, Ba = r.legendSymbol;
                r = r.checkbox;
                K && K.attr({x: M, y: F});
                P && P.translate(M, F - 4);
                Ba && Ba.translate(M, F);
                if (r) {
                    r.x = M;
                    r.y = F
                }
            }
            function v(r) {
                for (var M = Ea.length, F = r.checkbox; M--; )
                    if (Ea[M] == r) {
                        Ea.splice(M, 1);
                        break
                    }
                q(["legendItem", "legendLine", "legendSymbol"], function(K) {
                    r[K] && r[K].destroy()
                });
                F && cc(r.checkbox)
            }
            function D(r) {
                var M, F, K = r.legendItem;
                F = r.series || r;
                if (!K) {
                    F = /^(bar|pie|area|column)$/.test(F.type);
                    r.legendItem = K = L.text(E.labelFormatter.call(r), 0, 0, ya).on("mouseover", function() {
                        r.setState(ob);
                        K.css(bb)
                    }).on("mouseout", function() {
                        K.css(r.visible ? ya : Ga);
                        r.setState()
                    }).on("click", function() {
                        var P = "legendItemClick", Ba = function() {
                            r.setVisible()
                        };
                        r.firePointEvent ? r.firePointEvent(P, null, Ba) : za(r, P, null, Ba)
                    }).attr({zIndex: 2}).add(aa);
                    if (!F && r.options && r.options.lineWidth)
                        r.legendLine = L.path([ib, -ua - fa, 0, Na, -fa, 0]).attr({"stroke-width": r.options.lineWidth, zIndex: 2}).add(aa);
                    if (F)
                        M = L.rect(-ua - fa, -11,
                                ua, 12, 2).attr({"stroke-width": 0, zIndex: 3}).add(aa);
                    else if (r.options && r.options.marker && r.options.marker.enabled)
                        M = L.symbol(r.symbol, -ua / 2 - fa, -4, r.options.marker.radius).attr(r.pointAttr[Ka]).attr({zIndex: 3}).add(aa);
                    r.legendSymbol = M;
                    h(r, r.visible);
                    if (r.options && r.options.showCheckbox) {
                        r.checkbox = Da("input", {type: "checkbox", checked: r.selected, defaultChecked: r.selected}, E.itemCheckboxStyle, Ha);
                        cb(r.checkbox, "click", function(P) {
                            P = P.target;
                            za(r, "checkboxClick", {checked: P.checked}, function() {
                                r.select()
                            })
                        })
                    }
                }
                t(r,
                        C, R);
                M = K.getBBox();
                Q = R;
                r.legendItemWidth = M = E.itemWidth || ua + fa + M.width + qb;
                if (ka) {
                    C += M;
                    kb = Ua || sb(C - u, kb);
                    if (C - u + M > (Ua || Ma - 2 * Va - u)) {
                        C = u;
                        R += X
                    }
                } else {
                    R += X;
                    kb = Ua || sb(M, kb)
                }
                Ea.push(r)
            }
            function J() {
                C = u;
                R = x;
                Q = kb = 0;
                aa || (aa = L.g("legend").attr({zIndex: 7}).add());
                Ab && hb.reverse();
                q(hb, function(P) {
                    if (P.options.showInLegend) {
                        P = P.options.legendType == "point" ? P.data : [P];
                        q(P, D)
                    }
                });
                Ab && hb.reverse();
                nb = Ua || kb;
                La = Q - x + X;
                if (T || $a) {
                    nb += 2 * Va;
                    La += 2 * Va;
                    if (da)
                        da.attr({height: La, width: nb});
                    else
                        da = L.rect(0, 0, nb, La, E.borderRadius,
                                T || 0).attr({stroke: E.borderColor, "stroke-width": T || 0, fill: $a || fb}).add(aa).shadow(E.shadow)
                }
                for (var r = ["left", "right", "top", "bottom"], M, F = 4; F--; ) {
                    M = r[F];
                    if (xa[M] && xa[M] != "auto") {
                        E[F < 2 ? "align" : "verticalAlign"] = M;
                        E[F < 2 ? "x" : "y"] = parseInt(xa[M], 10) * (F % 2 ? -1 : 1)
                    }
                }
                var K = Jc(O({width: nb, height: La}, E));
                aa.translate(K.x, K.y);
                q(Ea, function(P) {
                    var Ba = P.checkbox;
                    Ba && Sa(Ba, {left: K.x + P.legendItemWidth + Ba.x - 40 + Ia, top: K.y + Ba.y - 11 + Ia})
                })
            }
            var E = l.options.legend;
            if (E.enabled) {
                var ka = E.layout == "horizontal", ua = E.symbolWidth,
                        fa = E.symbolPadding, Ea = [], xa = E.style, ya = E.itemStyle, bb = E.itemHoverStyle, Ga = E.itemHiddenStyle, Va = parseInt(xa.padding, 10), qb = 20, X = E.lineHeight || 16, x = 18, u = 4 + Va + ua + fa, C, R, Q, da, T = E.borderWidth, $a = E.backgroundColor, aa, kb, Ua = E.width, nb, La, hb = l.series, Ab = E.reversed;
                J();
                return{colorizeItem: h, destroyItem: v, renderLegend: J}
            }
        };
        Tb = function(l, h, t) {
            var v = 0, D = 0;
            if (t == "page") {
                v += lb.x + Y;
                D += lb.y + ja
            }
            return l >= v && l <= v + wa && h >= D && h <= D + pa
        };
        $c = function() {
            za(w, "selection", {resetSelection: true}, Dc);
            w.toolbar.remove("zoom")
        };
        Dc = function(l) {
            var h = sa.lang;
            w.toolbar.add("zoom", h.resetZoom, h.resetZoomTitle, $c);
            !l || l.resetSelection ? q(Qa, function(t) {
                t.setExtremes(null, null, false)
            }) : q(l.xAxis.concat(l.yAxis), function(t) {
                var v = t.axis;
                if (w.tracker[v.isXAxis ? "zoomX" : "zoomY"])
                    v.setExtremes(t.min, t.max, false)
            });
            i()
        };
        Jc = function(l) {
            var h = l.align, t = l.verticalAlign, v = l.x || 0, D = l.y || 0, J = {x: v || 0, y: D || 0};
            if (/^(right|center)$/.test(h))
                J.x = (Ma - l.width) / {right: 1, center: 2}[h] + v;
            if (/^(bottom|middle)$/.test(t))
                J.y = (Aa - l.height) / {bottom: 1, middle: 2}[t] +
                        D;
            return J
        };
        Wa();
        z(Ha);
        lc = rb = 0;
        cb(db, "resize", z);
        cb(db, "unload", Pb);
        if (Ja)
            for (Xb in Ja)
                cb(w, Xb, Ja[Xb]);
        w.options = a;
        w.series = ta;
        w.container = Ha;
        w.chartWidth = Ma;
        w.chartHeight = Aa;
        w.plotWidth = wa = Ma - Y - vc;
        w.plotHeight = pa = Aa - ja - Bb;
        w.plotLeft = Y;
        w.plotTop = ja;
        w.addSeries = g;
        w.destroy = Pb;
        w.get = n;
        w.getAlignment = Jc;
        w.getSelectedPoints = ga;
        w.getSelectedSeries = va;
        w.hideLoading = o;
        w.isInsidePlot = Tb;
        w.redraw = i;
        w.showLoading = m;
        w.updatePosition = z;
        q(a.series || [], function(l) {
            f(l)
        });
        w.inverted = ma = A(ma, a.chart.inverted);
        w.plotSizeX =
                Xb = ma ? pa : wa;
        w.plotSizeY = Xb = ma ? wa : pa;
        w.tracker = Ob = new e(w, a.tooltip);
        Qb()
    }
    function ad(a) {
        var b = [], c = [], d;
        for (d = 0; d < a.length; d++) {
            b[d] = a[d].plotX;
            c[d] = a[d].plotY
        }
        this.xdata = b;
        this.ydata = c;
        a = [];
        this.y2 = [];
        var e = c.length;
        this.n = e;
        this.y2[0] = 0;
        this.y2[e - 1] = 0;
        a[0] = 0;
        for (d = 1; d < e - 1; d++) {
            var f = b[d + 1] - b[d - 1];
            f = (b[d] - b[d - 1]) / f;
            var g = f * this.y2[d - 1] + 2;
            this.y2[d] = (f - 1) / g;
            a[d] = (c[d + 1] - c[d]) / (b[d + 1] - b[d]) - (c[d] - c[d - 1]) / (b[d] - b[d - 1]);
            a[d] = (6 * a[d] / (b[d + 1] - b[d - 1]) - f * a[d - 1]) / g
        }
        for (b = e - 2; b >= 0; b--)
            this.y2[b] = this.y2[b] *
                    this.y2[b + 1] + a[b]
    }
    var la = document, db = window, Fa = Math, W = Fa.round, jb = Fa.floor, sb = Fa.max, Lb = Fa.min, Za = Fa.abs, Ib = Fa.cos, Jb = Fa.sin, qa = navigator.userAgent, Lc = /msie/i.test(qa) && !db.opera, md = /AppleWebKit/.test(qa), bd = db.SVGAngle || la.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#BasicStructure", "1.1"), rb, lc, nd = {}, Ic = 0, ab = 1, dc, sa, hc, Ya, yb = "div", Vb = "absolute", Yc = "relative", Gb = "hidden", Fb = "highcharts-", Yb = "visible", Ia = "px", fb = "none", ib = "M", Na = "L", cd = "rgba(192,192,192,0.005)", Ka = "", ob = "hover", xb =
            "select", $b, rc, sc, tc, Rb, ac, bc, Nc, Oc, uc, Pc, Qc, Ca = db.HighchartsAdapter, ra = Ca || {}, q = ra.each, kc = ra.grep, Eb = ra.map, ia = ra.merge, qc = ra.hyphenate, cb = ra.addEvent, wb = ra.removeEvent, za = ra.fireEvent, Ub = ra.animate, mc = ra.stop;
    ra = ra.getAjax;
    var eb = {};
    if (!Ca && db.jQuery) {
        var Xa = jQuery;
        q = function(a, b) {
            for (var c = 0, d = a.length; c < d; c++)
                if (b.call(a[c], a[c], c, a) === false)
                    return c
        };
        kc = Xa.grep;
        Eb = function(a, b) {
            for (var c = [], d = 0, e = a.length; d < e; d++)
                c[d] = b.call(a[d], a[d], d, a);
            return c
        };
        ia = function() {
            var a = arguments;
            return Xa.extend(true,
                    null, a[0], a[1], a[2], a[3])
        };
        qc = function(a) {
            return a.replace(/([A-Z])/g, function(b, c) {
                return"-" + c.toLowerCase()
            })
        };
        cb = function(a, b, c) {
            Xa(a).bind(b, c)
        };
        wb = function(a, b, c) {
            try {
                Xa(a).unbind(b, c)
            } catch (d) {
            }
        };
        za = function(a, b, c, d) {
            var e = Xa.Event(b), f = "detached" + b;
            O(e, c);
            if (a[b]) {
                a[f] = a[b];
                a[b] = null
            }
            Xa(a).trigger(e);
            if (a[f]) {
                a[b] = a[f];
                a[f] = null
            }
            d && !e.isDefaultPrevented() && d(e)
        };
        Ub = function(a, b, c) {
            a = Xa(a);
            a.stop();
            a.animate(b, c)
        };
        mc = function(a) {
            Xa(a).stop()
        };
        ra = function(a, b) {
            Xa.get(a, null, b)
        };
        Xa.extend(Xa.easing,
                {easeOutQuad: function(a, b, c, d, e) {
                        return-d * (b /= e) * (b - 2) + c
                    }});
        var od = jQuery.fx.step._default, pd = jQuery.fx.prototype.cur;
        Xa.fx.step._default = function(a) {
            var b = a.elem;
            b.attr ? b.attr(a.prop, a.now) : od.apply(this, arguments)
        };
        Xa.fx.prototype.cur = function() {
            var a = this.elem;
            return a = a.attr ? a.attr(this.prop) : pd.apply(this, arguments)
        }
    } else if (!Ca && db.MooTools) {
        q = $each;
        Eb = function(a, b) {
            return a.map(b)
        };
        kc = function(a, b) {
            return a.filter(b)
        };
        ia = $merge;
        qc = function(a) {
            return a.hyphenate()
        };
        cb = function(a, b, c) {
            if (typeof b ==
                    "string") {
                if (b == "unload")
                    b = "beforeunload";
                if (!a.addEvent)
                    if (a.nodeName)
                        a = $(a);
                    else
                        O(a, new Events);
                a.addEvent(b, c)
            }
        };
        wb = function(a, b, c) {
            if (b) {
                if (b == "unload")
                    b = "beforeunload";
                a.removeEvent(b, c)
            }
        };
        za = function(a, b, c, d) {
            b = new Event({type: b, target: a});
            b = O(b, c);
            b.preventDefault = function() {
                d = null
            };
            a.fireEvent && a.fireEvent(b.type, b);
            d && d(b)
        };
        Ub = function(a, b, c) {
            var d = a.attr;
            if (d && !a.setStyle) {
                a.setStyle = a.getStyle = a.attr;
                a.$family = a.uid = true
            }
            mc(a);
            c = new Fx.Morph(d ? a : $(a), O(c, {transition: Fx.Transitions.Quad.easeInOut}));
            c.start(b);
            a.fx = c
        };
        mc = function(a) {
            a.fx && a.fx.cancel()
        };
        ra = function(a, b) {
            (new Request({url: a, method: "get", onSuccess: b})).send()
        }
    }
    Ca = {enabled: true, align: "center", x: 0, y: 15, style: {color: "#666", fontSize: "11px"}};
    sa = {colors: ["#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"], symbols: ["circle", "diamond", "square", "triangle", "triangle-down"], lang: {loading: "Loading...", months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November",
                "December"], weekdays: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], decimalPoint: ".", resetZoom: "Reset zoom", resetZoomTitle: "Reset zoom level 1:1", thousandsSep: ","}, global: {useUTC: true}, chart: {margin: [50, 50, 90, 80], borderColor: "#4572A7", borderRadius: 5, defaultSeriesType: "line", ignoreHiddenSeries: true, style: {fontFamily: '"Lucida Grande", "Lucida Sans Unicode", Verdana, Arial, Helvetica, sans-serif', fontSize: "12px"}, backgroundColor: "#FFFFFF", plotBorderColor: "#C0C0C0"}, title: {text: "Chart title",
            x: 0, y: 20, align: "center", style: {color: "#3E576F", fontSize: "16px"}}, subtitle: {text: "", x: 0, y: 40, align: "center", style: {color: "#6D869F"}}, plotOptions: {line: {allowPointSelect: false, showCheckbox: false, animation: true, events: {}, lineWidth: 2, shadow: true, marker: {enabled: true, lineWidth: 0, radius: 4, lineColor: "#FFFFFF", states: {hover: {}, select: {fillColor: "#FFFFFF", lineColor: "#000000", lineWidth: 2}}}, point: {events: {}}, dataLabels: ia(Ca, {enabled: false, y: -6, formatter: function() {
                        return this.y
                    }}), showInLegend: true, states: {hover: {lineWidth: 3,
                        marker: {}}, select: {marker: {}}}, stickyTracking: true}}, labels: {style: {position: Vb, color: "#3E576F"}}, legend: {enabled: true, align: "center", layout: "horizontal", labelFormatter: function() {
                return this.name
            }, borderWidth: 1, borderColor: "#909090", borderRadius: 5, shadow: false, style: {padding: "5px"}, itemStyle: {cursor: "pointer", color: "#3E576F"}, itemHoverStyle: {color: "#000000"}, itemHiddenStyle: {color: "#C0C0C0"}, itemCheckboxStyle: {position: Vb, width: "13px", height: "13px"}, symbolWidth: 16, symbolPadding: 5, verticalAlign: "bottom",
            x: 15, y: -15}, loading: {hideDuration: 100, labelStyle: {fontWeight: "bold", position: Yc, top: "1em"}, showDuration: 100, style: {position: Vb, backgroundColor: "white", opacity: 0.5, textAlign: "center"}}, tooltip: {enabled: true, formatter: function() {
                var a = this, b = a.series, c = b.xAxis, d = a.x;
                return"<b>" + (a.point.name || b.name) + "</b><br/>" + (S(d) ? "X value: " + (c && c.options.type == "datetime" ? hc(null, d) : d) + "<br/>" : "") + "Y value: " + a.y
            }, backgroundColor: "rgba(255, 255, 255, .85)", borderWidth: 2, borderRadius: 5, shadow: true, snap: 10, style: {color: "#333333",
                fontSize: "12px", padding: "5px", whiteSpace: "nowrap"}}, toolbar: {itemStyle: {color: "#4572A7", cursor: "pointer"}}, credits: {enabled: true, text: "Highcharts.com", href: "http://www.highcharts.com", style: {cursor: "pointer", color: "#909090", fontSize: "10px"}}};
    var ic = {dateTimeLabelFormats: {second: "%H:%M:%S", minute: "%H:%M", hour: "%H:%M", day: "%e. %b", week: "%e. %b", month: "%b '%y", year: "%Y"}, endOnTick: false, gridLineColor: "#C0C0C0", labels: Ca, lineColor: "#C0D0E0", lineWidth: 1, max: null, min: null, minPadding: 0.01, maxPadding: 0.01,
        maxZoom: null, minorGridLineColor: "#E0E0E0", minorGridLineWidth: 1, minorTickColor: "#A0A0A0", minorTickLength: 2, minorTickPosition: "outside", minorTickWidth: 1, showFirstLabel: true, showLastLabel: false, startOfWeek: 1, startOnTick: false, tickColor: "#C0D0E0", tickLength: 5, tickmarkPlacement: "between", tickPixelInterval: 100, tickPosition: "outside", tickWidth: 1, title: {align: "middle", margin: 35, style: {color: "#6D869F", fontWeight: "bold"}}, type: "linear"}, zc = ia(ic, {endOnTick: true, gridLineWidth: 1, tickPixelInterval: 72, showLastLabel: true,
        labels: {align: "right", x: -8, y: 3}, lineWidth: 0, maxPadding: 0.05, minPadding: 0.05, startOnTick: true, tickWidth: 0, title: {margin: 40, rotation: 270, text: "Y-values"}}), kd = {labels: {align: "right", x: -8, y: 3}, title: {rotation: 270}}, jd = {labels: {align: "left", x: 8, y: 3}, title: {rotation: 90}}, Vc = {labels: {align: "center", x: 0, y: 14}, title: {rotation: 0}}, id = ia(Vc, {labels: {y: -5}});
    Ca = sa.plotOptions;
    ra = Ca.line;
    Ca.spline = ia(ra);
    Ca.scatter = ia(ra, {lineWidth: 0, states: {hover: {lineWidth: 0}}});
    Ca.area = ia(ra, {});
    Ca.areaspline = ia(Ca.area);
    Ca.column = ia(ra, {borderColor: "#FFFFFF", borderWidth: 1, borderRadius: 0, groupPadding: 0.2, marker: null, pointPadding: 0.1, minPointLength: 0, states: {hover: {brightness: 0.1, shadow: false}, select: {color: "#C0C0C0", borderColor: "#000000", shadow: false}}});
    Ca.bar = ia(Ca.column, {dataLabels: {align: "left", x: 5, y: 0}});
    Ca.pie = ia(ra, {borderColor: "#FFFFFF", borderWidth: 1, center: ["50%", "50%"], colorByPoint: true, legendType: "point", marker: null, size: "90%", slicedOffset: 10, states: {hover: {brightness: 0.1, shadow: false}}});
    Mc();
    var Kb =
            function(a) {
                function b(j) {
                    if (g = /rgba\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]?(?:\.[0-9]+)?)\s*\)/.exec(j))
                        f = [parseInt(g[1], 10), parseInt(g[2], 10), parseInt(g[3], 10), parseFloat(g[4], 10)];
                    else if (g = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(j))
                        f = [parseInt(g[1], 16), parseInt(g[2], 16), parseInt(g[3], 16), 1]
                }
                function c(j) {
                    return j = f && !isNaN(f[0]) ? j == "rgb" ? "rgb(" + f[0] + "," + f[1] + "," + f[2] + ")" : j == "a" ? f[3] : "rgba(" + f.join(",") + ")" : a
                }
                function d(j) {
                    if (typeof j == "number" && j !==
                            0)
                        for (var i = 0; i < 3; i++) {
                            f[i] += parseInt(j * 255, 10);
                            if (f[i] < 0)
                                f[i] = 0;
                            if (f[i] > 255)
                                f[i] = 255
                        }
                    return this
                }
                function e(j) {
                    f[3] = j;
                    return this
                }
                var f = [], g;
                b(a);
                return{get: c, brighten: d, setOpacity: e}
            };
    hc = function(a, b, c) {
        function d(z) {
            return z.toString().replace(/^([0-9])$/, "0$1")
        }
        if (!S(b) || isNaN(b))
            return"Invalid date";
        a = A(a, "%Y-%m-%d %H:%M:%S");
        b = new Date(b * ab);
        var e = b[sc](), f = b[tc](), g = b[Rb](), j = b[ac](), i = b[bc](), m = sa.lang, o = m.weekdays;
        m = m.months;
        b = {a: o[f].substr(0, 3), A: o[f], d: d(g), e: g, b: m[j].substr(0, 3), B: m[j],
            m: d(j + 1), y: i.toString().substr(2, 2), Y: i, H: d(e), I: d(e % 12 || 12), l: e % 12 || 12, M: d(b[rc]()), p: e < 12 ? "AM" : "PM", P: e < 12 ? "am" : "pm", S: d(b.getSeconds())};
        for (var n in b)
            a = a.replace("%" + n, b[n]);
        return c ? a.substr(0, 1).toUpperCase() + a.substr(1) : a
    };
    ec.prototype = {init: function(a, b) {
            this.element = la.createElementNS("http://www.w3.org/2000/svg", b);
            this.renderer = a
        }, animate: function(a, b) {
            Ub(this, a, b)
        }, attr: function(a, b) {
            var c, d, e, f = this.element, g = f.nodeName, j = this.renderer, i, m = this.shadows, o, n = this;
            if (typeof a == "string" &&
                    S(b)) {
                c = a;
                a = {};
                a[c] = b
            }
            if (typeof a == "string") {
                c = a;
                if (g == "circle")
                    c = {x: "cx", y: "cy"}[c] || c;
                else if (c == "strokeWidth")
                    c = "stroke-width";
                n = parseFloat(oa(f, c) || this[c] || 0)
            } else
                for (c in a) {
                    b = a[c];
                    if (c == "d") {
                        if (typeof b != "string")
                            b = b.join(" ")
                    } else if (c == "x" && g == "text")
                        for (d = 0; d < f.childNodes.length; d++) {
                            e = f.childNodes[d];
                            oa(e, "x") == oa(f, "x") && oa(e, "x", b)
                        }
                    else if (c == "fill")
                        b = j.color(b, f, c);
                    else if (g == "circle")
                        c = {x: "cx", y: "cy"}[c] || c;
                    else if (c == "translateX" || c == "translateY") {
                        this[c] = b;
                        this.updateTransform();
                        i = true
                    } else if (c == "stroke")
                        b = j.color(b, f, c);
                    else if (c == "isTracker")
                        this[c] = b;
                    if (c == "strokeWidth")
                        c = "stroke-width";
                    if (md && c == "stroke-width" && b === 0)
                        b = 1.0E-6;
                    if (this.symbolName && /^(x|y|r|start|end|innerR)/.test(c)) {
                        if (!o) {
                            this.symbolAttr(a);
                            o = true
                        }
                        i = true
                    }
                    if (m && /^(width|height|visibility|x|y|d)$/.test(c))
                        for (d = m.length; d--; )
                            oa(m[d], c, b);
                    if (c == "text")
                        j.buildText(f, b);
                    else
                        i || oa(f, c, b)
                }
            return n
        }, symbolAttr: function(a) {
            var b = this;
            b.x = A(a.x, b.x);
            b.y = A(a.y, b.y);
            b.r = A(a.r, b.r);
            b.start = A(a.start, b.start);
            b.end =
                    A(a.end, b.end);
            b.width = A(a.width, b.width);
            b.height = A(a.height, b.height);
            b.innerR = A(a.innerR, b.innerR);
            b.attr({d: b.renderer.symbols[b.symbolName](b.x, b.y, b.r, {start: b.start, end: b.end, width: b.width, height: b.height, innerR: b.innerR})})
        }, clip: function(a) {
            return this.attr("clip-path", "url(#" + a.id + ")")
        }, css: function(a) {
            var b = this;
            if (a && a.color)
                a.fill = a.color;
            a = O(b.styles, a);
            b.attr({style: pc(a)});
            b.styles = a;
            return b
        }, on: function(a, b) {
            this.element["on" + a] = b;
            return this
        }, translate: function(a, b) {
            var c = this;
            c.translateX = a;
            c.translateY = b;
            c.updateTransform();
            return c
        }, invert: function() {
            var a = this;
            a.inverted = true;
            a.updateTransform();
            return a
        }, updateTransform: function() {
            var a = this, b = a.translateX || 0, c = a.translateY || 0, d = a.inverted, e = [];
            if (d) {
                b += a.attr("width");
                c += a.attr("height")
            }
            if (b || c)
                e.push("translate(" + b + "," + c + ")");
            d && e.push("rotate(90) scale(-1,1)");
            e.length && oa(a.element, "transform", e.join(" "))
        }, toFront: function() {
            var a = this.element;
            a.parentNode.appendChild(a);
            return this
        }, getBBox: function() {
            return this.element.getBBox()
        },
        show: function() {
            return this.attr({visibility: Yb})
        }, hide: function() {
            return this.attr({visibility: Gb})
        }, add: function(a) {
            var b = a ? a.element : this.renderer.box, c = b.childNodes, d = this.element, e = oa(d, "zIndex"), f, g;
            this.parentInverted = a && a.inverted;
            for (g = 0; g < c.length; g++) {
                a = c[g];
                f = oa(a, "zIndex");
                if (a != d && (f > e || !S(e) && S(f))) {
                    b.insertBefore(d, a);
                    return this
                }
            }
            b.appendChild(d);
            return this
        }, destroy: function() {
            var a = this, b = a.element, c = a.shadows, d = b.parentNode, e;
            b.onclick = b.onmouseout = b.onmouseover = b.onmousemove =
                    null;
            mc(a);
            d && d.removeChild(b);
            c && q(c, function(f) {
                (d = f.parentNode) && d.removeChild(f)
            });
            for (e in a)
                delete a[e];
            return null
        }, empty: function() {
            for (var a = this.element, b = a.childNodes, c = b.length; c--; )
                a.removeChild(b[c])
        }, shadow: function(a) {
            var b = [], c, d = this.element, e = this.parentInverted ? "(-1,-1)" : "(1,1)";
            if (a) {
                for (a = 1; a <= 3; a++) {
                    c = d.cloneNode(0);
                    oa(c, {isShadow: "true", stroke: "rgb(0, 0, 0)", "stroke-opacity": 0.05 * a, "stroke-width": 7 - 2 * a, transform: "translate" + e, fill: fb});
                    d.parentNode.insertBefore(c, d);
                    b.push(c)
                }
                this.shadows =
                        b
            }
            return this
        }};
    var Wb = function() {
        this.init.apply(this, arguments)
    };
    Wb.prototype = {init: function(a, b, c) {
            var d = la.createElementNS("http://www.w3.org/2000/svg", "svg");
            oa(d, {width: b, height: c, xmlns: "http://www.w3.org/2000/svg", version: "1.1"});
            a.appendChild(d);
            this.Element = ec;
            this.box = d;
            this.defs = this.createElement("defs").add()
        }, createElement: function(a) {
            var b = new this.Element;
            b.init(this, a);
            return b
        }, buildText: function(a, b) {
            b = b.toString().replace(/<(b|strong)>/g, '<span style="font-weight:bold">').replace(/<(i|em)>/g,
                    '<span style="font-style:italic">').replace(/<a/g, "<span").replace(/<\/(b|strong|i|em|a)>/g, "</span>").split("<br/>");
            var c = a.childNodes, d = /style="([ 0-9a-z:;\-]+)"/, e = /href="([^"]+)"/, f = oa(a, "x"), g;
            for (g = c.length - 1; g >= 0; g--)
                a.removeChild(c[g]);
            q(b, function(j, i) {
                var m = 0;
                j = j.replace(/<span/g, "|||<span").replace(/<\/span>/g, "</span>|||");
                j = j.split("|||");
                q(j, function(o) {
                    if (o !== "") {
                        var n = {}, z = la.createElementNS("http://www.w3.org/2000/svg", "tspan");
                        d.test(o) && oa(z, "style", o.match(d)[1].replace(/(;| |^)color([ :])/,
                                "$1fill$2"));
                        if (e.test(o)) {
                            oa(z, "onclick", 'location.href="' + o.match(e)[1] + '"');
                            Sa(z, {cursor: "pointer"})
                        }
                        o = o.replace(/<(.|\n)*?>/g, "");
                        z.appendChild(la.createTextNode(o));
                        if (m)
                            n.dx = 3;
                        else
                            n.x = f;
                        if (i)
                            n.dy = 16;
                        oa(z, n);
                        a.appendChild(z);
                        m++
                    }
                })
            })
        }, crispLine: function(a, b) {
            if (a[1] == a[4])
                a[1] = a[4] = W(a[1]) + b % 2 / 2;
            if (a[2] == a[5])
                a[2] = a[5] = W(a[2]) + b % 2 / 2;
            return a
        }, path: function(a) {
            return this.createElement("path").attr({d: a, fill: fb})
        }, circle: function(a, b, c) {
            a = typeof a == "object" ? a : {x: a, y: b, r: c};
            return this.createElement("circle").attr(a)
        },
        arc: function(a, b, c, d, e, f) {
            if (typeof a == "object") {
                b = a.y;
                c = a.r;
                d = a.innerR;
                e = a.start;
                f = a.end;
                a = a.x
            }
            return this.symbol("arc", a || 0, b || 0, c || 0, {innerR: d || 0, start: e || 0, end: f || 0})
        }, rect: function(a, b, c, d, e, f) {
            if (arguments.length > 1) {
                var g = (f || 0) % 2 / 2;
                a = W(a || 0) + g;
                b = W(b || 0) + g;
                c = W((c || 0) - 2 * g);
                d = W((d || 0) - 2 * g)
            }
            g = typeof a == "object" ? a : {x: a, y: b, width: sb(c, 0), height: sb(d, 0)};
            return this.createElement("rect").attr(O(g, {rx: e || g.r, ry: e || g.r, fill: fb}))
        }, g: function(a) {
            return this.createElement("g").attr(S(a) && {"class": Fb +
                        a})
        }, image: function(a, b, c, d, e) {
            b = this.createElement("image").attr({x: b, y: c, width: d, height: e, preserveAspectRatio: fb});
            b.element.setAttributeNS("http://www.w3.org/1999/xlink", "href", a);
            return b
        }, symbol: function(a, b, c, d, e) {
            var f, g = this.symbols[a];
            g = g && g(b, c, d, e);
            var j = /^url\((.*?)\)$/;
            if (g) {
                f = this.path(g);
                O(f, {symbolName: a, x: b, y: c, r: d});
                e && O(f, e)
            } else if (j.test(a)) {
                a = a.match(j)[1];
                f = this.image(a).attr({visibility: Gb});
                Da("img", {onload: function() {
                        var i = this;
                        i = nd[i.src] || [i.width, i.height];
                        f.attr({x: W(b -
                                    i[0] / 2) + Ia, y: W(c - i[1] / 2) + Ia, width: i[0], height: i[1], visibility: "inherit"})
                    }, src: a})
            } else
                f = this.circle(b, c, d);
            return f
        }, symbols: {square: function(a, b, c) {
                c = 0.707 * c;
                return[ib, a - c, b - c, Na, a + c, b - c, a + c, b + c, a - c, b + c, "Z"]
            }, triangle: function(a, b, c) {
                return[ib, a, b - 1.33 * c, Na, a + c, b + 0.67 * c, a - c, b + 0.67 * c, "Z"]
            }, "triangle-down": function(a, b, c) {
                return[ib, a, b + 1.33 * c, Na, a - c, b - 0.67 * c, a + c, b - 0.67 * c, "Z"]
            }, diamond: function(a, b, c) {
                return[ib, a, b - c, Na, a + c, b, a, b + c, a - c, b, "Z"]
            }, arc: function(a, b, c, d) {
                var e = d.start, f = d.end;
                d = d.innerR;
                var g = Ib(e), j = Jb(e), i = Ib(f), m = Jb(f);
                e = f - e < Math.PI ? 0 : 1;
                return[ib, a + c * g, b + c * j, "A", c, c, 0, e, 1, a + c * i, b + c * m, Na, a + d * i, b + d * m, "A", d, d, 0, e, 0, a + d * g, b + d * j, "Z"]
            }}, clipRect: function(a, b, c, d) {
            var e = Fb + Ic++, f = this.createElement("clipPath").attr({id: e}).add(this.defs);
            a = this.rect(a, b, c, d, 0).add(f);
            a.id = e;
            return a
        }, color: function(a, b, c) {
            var d, e = /^rgba/;
            if (a && a.linearGradient) {
                var f = this;
                b = "linearGradient";
                c = a[b];
                var g = Fb + Ic++, j, i, m;
                j = f.createElement(b).attr({id: g, gradientUnits: "userSpaceOnUse", x1: c[0], y1: c[1], x2: c[2],
                    y2: c[3]}).add(f.defs);
                q(a.stops, function(o) {
                    if (e.test(o[1])) {
                        d = Kb(o[1]);
                        i = d.get("rgb");
                        m = d.get("a")
                    } else {
                        i = o[1];
                        m = 1
                    }
                    f.createElement("stop").attr({offset: o[0], "stop-color": i, "stop-opacity": m}).add(j)
                });
                return"url(#" + g + ")"
            } else if (e.test(a)) {
                d = Kb(a);
                oa(b, c + "-opacity", d.get("a"));
                return d.get("rgb")
            } else
                return a
        }, text: function(a, b, c, d, e, f) {
            d = d || {};
            f = f || "left";
            e = e || 0;
            var g = d.color || "#000000", j = sa.chart.style;
            b = W(A(b, 0));
            c = W(A(c, 0));
            O(d, {fontFamily: d.fontFamily || j.fontFamily, fontSize: d.fontSize || j.fontSize});
            d = pc(d);
            a = {x: b, y: c, text: a, fill: g, style: d.replace(/"/g, "'")};
            if (e || f != "left")
                a = O(a, {"text-anchor": {left: "start", center: "middle", right: "end"}[f], transform: "rotate(" + e + " " + b + " " + c + ")"});
            return this.createElement("text").attr(a)
        }};
    var Kc;
    if (!bd) {
        var qd = gb(ec, {init: function(a, b) {
                var c = ["<", b, ' filled="f" stroked="f"'], d = ["position: ", Vb, ";"];
                if (b == "shape" || b == yb)
                    d.push("left:0;top:0;width:10px;height:10px;");
                c.push(' style="', d.join(""), '"/>');
                if (b) {
                    c = b == yb || b == "span" || b == "img" ? c.join("") : a.prepVML(c);
                    this.element = Da(c)
                }
                this.renderer = a
            }, add: function(a) {
                var b = this, c = b.renderer, d = b.element, e = c.box;
                c = a && a.inverted;
                a = a ? a.element || a : e;
                if (c) {
                    c = a.style;
                    Sa(d, {flip: "x", left: parseInt(c.width, 10) - 10, top: parseInt(c.height, 10) - 10, rotation: -90})
                }
                a.appendChild(d);
                return b
            }, attr: function(a, b) {
                var c, d, e, f = this.element, g = f.style, j = f.nodeName, i = this.renderer, m = this.symbolName, o, n = this.shadows, z, na = this;
                if (typeof a == "string" && S(b)) {
                    c = a;
                    a = {};
                    a[c] = b
                }
                if (typeof a == "string") {
                    c = a;
                    na = c == "strokeWidth" ? f.strokeweight : A(this[c],
                            parseInt(g[{x: "left", y: "top"}[c] || c], 10))
                } else
                    for (c in a) {
                        d = a[c];
                        z = false;
                        if (m && /^(x|y|r|start|end|width|height|innerR)/.test(c)) {
                            if (!o) {
                                this.symbolAttr(a);
                                o = true
                            }
                            z = true
                        } else if (c == "d") {
                            e = d.length;
                            for (z = []; e--; )
                                z[e] = typeof d[e] == "number" ? W(d[e] * 10) - 5 : d[e] == "Z" ? "x" : d[e];
                            d = z.join(" ");
                            f.path = d;
                            if (n)
                                for (e = n.length; e--; )
                                    n[e].path = d;
                            z = true
                        } else if (c == "zIndex" || c == "visibility") {
                            g[c] = d;
                            z = true
                        } else if (/^(width|height)$/.test(c)) {
                            g[c] = d;
                            this.updateClipping && this.updateClipping();
                            z = true
                        } else if (/^(x|y)$/.test(c)) {
                            if (c ==
                                    "y" && f.tagName == "SPAN" && f.lineHeight)
                                d -= f.lineHeight;
                            g[{x: "left", y: "top"}[c]] = d
                        } else if (c == "class")
                            f.className = d;
                        else if (c == "stroke") {
                            d = i.color(d, f, c);
                            c = "strokecolor"
                        } else if (c == "stroke-width" || c == "strokeWidth") {
                            f.stroked = d ? true : false;
                            c = "strokeweight";
                            if (typeof d == "number")
                                d += Ia
                        } else if (c == "fill")
                            if (j == "SPAN")
                                g.color = d;
                            else {
                                f.filled = d != fb ? true : false;
                                d = i.color(d, f, c);
                                c = "fillcolor"
                            }
                        else if (c == "translateX" || c == "translateY") {
                            this[c] = b;
                            this.updateTransform();
                            z = true
                        }
                        if (n && c == "visibility")
                            for (e = n.length; e--; )
                                n[e].style[c] =
                                        d;
                        if (c == "text")
                            f.innerHTML = d;
                        else if (!z)
                            if (la.documentMode == 8)
                                f[c] = d;
                            else
                                oa(f, c, d)
                    }
                return na
            }, clip: function(a) {
                var b = this, c = a.members, d = c.length;
                c.push(b);
                b.destroyClip = function() {
                    c.splice(d, 1)
                };
                return b.css({clip: a.getCSS(b.inverted)})
            }, css: function(a) {
                var b = this;
                Sa(b.element, a);
                return b
            }, destroy: function() {
                var a = this;
                a.destroyClip && a.destroyClip();
                ec.prototype.destroy.apply(this)
            }, empty: function() {
                var a = this.element;
                a = a.childNodes;
                for (var b = a.length, c; b--; ) {
                    c = a[b];
                    c.parentNode.removeChild(c)
                }
            },
            getBBox: function() {
                var a = this.element, b, c = a.offsetWidth, d = a.parentNode;
                c || la.body.appendChild(a);
                b = {x: a.offsetLeft, y: a.offsetTop, width: a.offsetWidth, height: a.offsetHeight};
                c || (d ? d.appendChild(a) : la.body.removeChild(a));
                return b
            }, on: function(a, b) {
                this.element["on" + a] = function() {
                    var c = db.event;
                    c.target = c.srcElement;
                    b(c)
                };
                return this
            }, updateTransform: function() {
                var a = this, b = a.translateX || 0, c = a.translateY || 0;
                if (b || c)
                    a.css({left: b, top: c})
            }, shadow: function(a) {
                var b = [], c = this.element, d = this.renderer, e, f =
                        c.style, g;
                if (a) {
                    for (a = 1; a <= 3; a++) {
                        g = ['<shape isShadow="true" strokeweight="', 7 - 2 * a, '" filled="false" path="', c.path, '" coordsize="100,100" style="', c.style.cssText, '" />'];
                        e = Da(d.prepVML(g), null, {left: parseInt(f.left, 10) + 1, top: parseInt(f.top, 10) + 1});
                        g = ['<stroke color="black" opacity="', 0.05 * a, '"/>'];
                        Da(d.prepVML(g), null, null, e);
                        c.parentNode.insertBefore(e, c);
                        b.push(e)
                    }
                    this.shadows = b
                }
                return this
            }});
        Kc = function() {
            this.init.apply(this, arguments)
        };
        Kc.prototype = ia(Wb.prototype, {isIE8: qa.indexOf("MSIE 8.0") >
                    -1, init: function(a, b, c) {
                this.box = Da(yb, null, {width: b + Ia, height: c + Ia}, a);
                this.Element = qd;
                if (!la.namespaces.hcv) {
                    la.namespaces.add("hcv", "urn:schemas-microsoft-com:vml");
                    la.createStyleSheet().cssText = "hcv\\:fill, hcv\\:path, hcv\\:textpath, hcv\\:shape, hcv\\:stroke, hcv\\:line { behavior:url(#default#VML); display: inline-block; } "
                }
            }, clipRect: function(a, b, c, d) {
                var e = this.createElement();
                return O(e, {members: [], element: {style: {left: a, top: b, width: c, height: d}}, getCSS: function(f) {
                        var g = e.element.style,
                                j = g.top, i = g.left, m = i + g.width;
                        g = j + g.height;
                        return"rect(" + (f ? i : j) + "px," + (f ? g : m) + "px," + (f ? m : g) + "px," + (f ? j : i) + "px)"
                    }, updateClipping: function() {
                        q(e.members, function(f) {
                            f.css({clip: e.getCSS(f.inverted)})
                        })
                    }})
            }, color: function(a, b, c) {
                var d, e = /^rgba/;
                if (a && a.linearGradient) {
                    var f, g;
                    c = a.linearGradient;
                    var j, i, m, o;
                    q(a.stops, function(n, z) {
                        if (e.test(n[1])) {
                            d = Kb(n[1]);
                            f = d.get("rgb");
                            g = d.get("a")
                        } else {
                            f = n[1];
                            g = 1
                        }
                        if (z) {
                            m = f;
                            o = g
                        } else {
                            j = f;
                            i = g
                        }
                    });
                    a = 90 - Fa.atan((c[3] - c[1]) / (c[2] - c[0])) * 180 / Fa.PI;
                    a = ['<fill colors="0% ',
                        j, ",100% ", m, '" angle="', a, '" opacity="', o, '" o:opacity2="', i, '" type="gradient" focus="100%" />'];
                    Da(this.prepVML(a), null, null, b)
                } else if (e.test(a)) {
                    d = Kb(a);
                    a = ["<", c, ' opacity="', d.get("a"), '"/>'];
                    Da(this.prepVML(a), null, null, b);
                    return d.get("rgb")
                } else
                    return a
            }, prepVML: function(a) {
                var b = "display:inline-block;behavior:url(#default#VML);", c = this.isIE8;
                a = a.join("");
                if (c) {
                    a = a.replace("/>", ' xmlns="urn:schemas-microsoft-com:vml" />');
                    a = a.indexOf('style="') == -1 ? a.replace("/>", ' style="' + b + '" />') : a.replace('style="',
                            'style="' + b)
                } else
                    a = a.replace("<", "<hcv:");
                return a
            }, text: function(a, b, c, d, e, f) {
                d = d || {};
                f = f || "left";
                e = e || 0;
                var g = W(parseInt(d.fontSize || 12, 10) * 1.2), j = sa.chart.style;
                b = W(b);
                c = W(c);
                O(d, {color: d.color || "#000000", whiteSpace: "nowrap", fontFamily: d.fontFamily || j.fontFamily, fontSize: d.fontSize || j.fontSize});
                if (e) {
                    j = (e || 0) * Fa.PI * 2 / 360;
                    e = Ib(j);
                    j = Jb(j);
                    var i = 10;
                    g = g * 0.3;
                    var m = f == "left", o = f == "right", n = m ? b : b - i * e;
                    b = o ? b : b + i * e;
                    m = m ? c : c - i * j;
                    c = o ? c : c + i * j;
                    n += g * j;
                    b += g * j;
                    m -= g * e;
                    c -= g * e;
                    if (Za(n - b) < 0.1)
                        n += 0.1;
                    if (Za(m - c) < 0.1)
                        m +=
                                0.1;
                    c = this.createElement("line").attr({from: n + ", " + m, to: b + ", " + c});
                    e = c.element;
                    Da("hcv:fill", {on: true, color: d.color}, null, e);
                    Da("hcv:path", {textpathok: true}, null, e);
                    Da('<hcv:textpath style="v-text-align:' + f + ";" + pc(d).replace(/"/g, "'") + '" on="true" string="' + a + '">', null, null, e)
                } else {
                    c = this.createElement("span").attr({x: b, y: c - g, text: a});
                    e = c.element;
                    e.lineHeight = g;
                    Sa(e, d);
                    if (f != "left") {
                        a = c.getBBox().width;
                        Sa(e, {left: b - a / {right: 1, center: 2}[f] + Ia})
                    }
                }
                return c
            }, path: function(a) {
                return this.createElement("shape").attr({coordsize: "100 100",
                    d: a})
            }, circle: function(a, b, c) {
                return this.path(this.symbols.circle(a, b, c))
            }, g: function(a) {
                var b;
                if (a)
                    b = {className: Fb + a, "class": Fb + a};
                return a = this.createElement(yb).attr(b)
            }, image: function(a, b, c, d, e) {
                return this.createElement("img").attr({src: a}).css({left: b, top: c, width: d, height: e})
            }, rect: function(a, b, c, d, e, f) {
                if (arguments.length > 1) {
                    var g = (f || 0) % 2 / 2;
                    a = W(a || 0) + g;
                    b = W(b || 0) + g;
                    c = W((c || 0) - 2 * g);
                    d = W((d || 0) - 2 * g)
                }
                if (typeof a == "object") {
                    b = a.y;
                    c = a.width;
                    d = a.height;
                    e = a.r;
                    a = a.x
                }
                return this.symbol("rect", a || 0,
                        b || 0, e || 0, {width: c || 0, height: d || 0})
            }, symbol: function(a, b, c) {
                var d;
                d = /^url\((.*?)\)$/;
                return d = d.test(a) ? this.createElement("img").attr({onload: function() {
                        var e = this, f = [e.width, e.height];
                        Sa(e, {left: W(b - f[0] / 2), top: W(c - f[1] / 2)})
                    }, src: a.match(d)[1]}) : Wb.prototype.symbol.apply(this, arguments)
            }, symbols: {arc: function(a, b, c, d) {
                    var e = d.start, f = d.end, g = Ib(e);
                    e = Jb(e);
                    var j = Ib(f);
                    f = Jb(f);
                    d = d.innerR;
                    return["wa", a - c, b - c, a + c, b + c, a + c * g, b + c * e, a + c * j, b + c * f, "at", a - d, b - d, a + d, b + d, a + d * j, b + d * f, a + d * g, b + d * e, "x", "e"]
                }, circle: function(a,
                        b, c) {
                    return["wa", a - c, b - c, a + c, b + c, a + c * 1, b + c * 0, a + c * 1, b + c * 0, "e"]
                }, rect: function(a, b, c, d) {
                    var e = d.width;
                    d = d.height;
                    var f = a + e, g = b + d;
                    c = Lb(c, e, d);
                    return[ib, a + c, b, Na, f - c, b, "wa", f - 2 * c, b, f, b + 2 * c, f - c, b, f, b + c, Na, f, g - c, "wa", f - 2 * c, g - 2 * c, f, g, f, g - c, f - c, g, Na, a + c, g, "wa", a, g - 2 * c, a + 2 * c, g, a + c, g, a, g - c, Na, a, b + c, "wa", a, b, a + 2 * c, b + 2 * c, a, b + c, a + c, b, "x", "e"]
                }}})
    }
    var Zc = bd ? Wb : Kc, Zb = function() {
    };
    Zb.prototype = {init: function(a, b) {
            var c = this;
            c.series = a;
            c.applyOptions(b);
            c.pointAttr = {};
            if (a.options.colorByPoint) {
                a = sa.colors;
                if (!c.options)
                    c.options =
                            {};
                c.color = c.options.color = c.color || a[rb++];
                if (rb >= a.length)
                    rb = 0
            }
            return c
        }, applyOptions: function(a) {
            var b = this, c = b.series;
            if (typeof a == "number" || a === null)
                b.y = a;
            else if (typeof a == "object" && typeof a.length != "number") {
                O(b, a);
                b.options = a
            } else if (typeof a[0] == "string") {
                b.name = a[0];
                b.y = a[1]
            } else if (typeof a[0] == "number") {
                b.x = a[0];
                b.y = a[1]
            }
            if (b.x === Ya)
                b.x = c.autoIncrement()
        }, destroy: function() {
            var a = this, b;
            a == a.series.chart.hoverPoint && a.onMouseOut();
            wb(a);
            q(["graphic", "tracker", "group"], function(c) {
                a[c] &&
                        a[c].destroy()
            });
            a.legendItem && a.series.chart.legend.destroyItem(a);
            for (b in a)
                a[b] = null
        }, select: function(a, b) {
            var c = this, d = c.series;
            d = d.chart;
            c.selected = a = A(a, !c.selected);
            c.firePointEvent(a ? "select" : "unselect");
            c.setState(xb);
            b || q(d.getSelectedPoints(), function(e) {
                if (e.selected && e != c) {
                    e.selected = false;
                    e.setState(Ka);
                    e.firePointEvent("unselect")
                }
            })
        }, onMouseOver: function() {
            var a = this, b = a.series.chart, c = b.tooltip, d = b.hoverPoint;
            d && d != a && d.onMouseOut();
            a.firePointEvent("mouseOver");
            c && c.refresh(a);
            a.setState(ob);
            b.hoverPoint = a
        }, onMouseOut: function() {
            var a = this;
            a.firePointEvent("mouseOut");
            a.setState(Ka);
            a.series.chart.hoverPoint = null
        }, update: function(a, b) {
            var c = this, d = c.series;
            b = A(b, true);
            c.firePointEvent("update", {options: a}, function() {
                c.applyOptions(a);
                d.isDirty = true;
                b && d.chart.redraw()
            })
        }, remove: function(a) {
            var b = this, c = b.series, d = c.chart, e = c.data, f = e.length;
            a = A(a, true);
            b.firePointEvent("remove", null, function() {
                for (; f--; )
                    if (e[f] == b) {
                        e.splice(f, 1);
                        break
                    }
                b.destroy();
                c.isDirty = true;
                a && d.redraw()
            })
        },
        firePointEvent: function(a, b, c) {
            var d = this, e = this.series;
            e = e.options;
            if (e.point.events[a] || d.options && d.options.events && d.options.events[a])
                this.importEvents();
            if (a == "click" && e.allowPointSelect)
                c = function(f) {
                    d.select(null, f.ctrlKey || f.metaKey || f.shiftKey)
                };
            za(this, a, b, c)
        }, importEvents: function() {
            if (!this.hasImportedEvents) {
                var a = this, b = ia(a.series.options.point, a.options);
                b = b.events;
                var c;
                a.events = b;
                for (c in b)
                    cb(a, c, b[c]);
                this.hasImportedEvents = true
            }
        }, setState: function(a) {
            var b = this, c = b.series, d =
                    c.options.states, e = c.options.marker, f = e && !e.enabled, g = (e = e && e.states[a]) && e.enabled === false, j = c.chart, i = b.pointAttr;
            a || (a = Ka);
            if (!(b.selected && a != xb || d[a] && d[a].enabled === false || a && (g || f && !e.enabled)))
                if (a && !b.graphic) {
                    if (!c.stateMarkerGraphic)
                        c.stateMarkerGraphic = j.renderer.circle(0, 0, i[a].r).attr(i[a]).add(c.group);
                    c.stateMarkerGraphic.translate(b.plotX, b.plotY)
                } else
                    b.graphic && b.graphic.attr(i[a])
        }, setTooltipText: function() {
            var a = this;
            a.tooltipText = a.series.chart.options.tooltip.formatter.call({series: a.series,
                point: a, x: a.category, y: a.y, percentage: a.percentage, total: a.total || a.stackTotal})
        }};
    var Ra = function() {
    };
    Ra.prototype = {isCartesian: true, type: "line", pointClass: Zb, pointAttrToOptions: {stroke: "lineColor", "stroke-width": "lineWidth", fill: "fillColor", r: "radius"}, init: function(a, b) {
            var c = this, d, e = a.series.length;
            c.chart = a;
            b = c.setOptions(b);
            O(c, {index: e, options: b, name: b.name || "Series " + (e + 1), state: Ka, pointAttr: {}, visible: b.visible !== false, selected: b.selected === true});
            a = b.events;
            for (d in a)
                cb(c, d, a[d]);
            c.getColor();
            c.getSymbol();
            c.setData(b.data, false)
        }, autoIncrement: function() {
            var a = this, b = a.options, c = a.xIncrement;
            c = A(c, b.pointStart, 0);
            a.pointInterval = A(a.pointInterval, b.pointInterval, 1);
            a.xIncrement = c + a.pointInterval;
            return c
        }, cleanData: function() {
            var a = this;
            a = a.data;
            var b;
            a.sort(function(c, d) {
                return c.x - d.x
            });
            for (b = a.length - 1; b >= 0; b--)
                a[b - 1] && a[b - 1].x == a[b].x && a.splice(b - 1, 1)
        }, getSegments: function() {
            var a = -1, b = [], c = this.data;
            q(c, function(d, e) {
                if (d.y === null) {
                    e > a + 1 && b.push(c.slice(a + 1, e));
                    a = e
                } else
                    e == c.length -
                            1 && b.push(c.slice(a + 1, e + 1))
            });
            this.segments = b
        }, setOptions: function(a) {
            var b = this.chart.options.plotOptions;
            return a = ia(b[this.type], b.series, a)
        }, getColor: function() {
            var a = this.chart.options.colors;
            this.color = this.options.color || a[rb++] || "#0000ff";
            if (rb >= a.length)
                rb = 0
        }, getSymbol: function() {
            var a = this.chart.options.symbols, b = this.options.marker.symbol || a[lc++];
            this.symbol = b;
            if (lc >= a.length)
                lc = 0
        }, addPoint: function(a, b, c) {
            var d = this, e = d.data;
            a = (new d.pointClass).init(d, a);
            b = A(b, true);
            e.push(a);
            c && e[0].remove(false);
            d.isDirty = true;
            b && d.chart.redraw()
        }, setData: function(a, b) {
            var c = this, d = c.data, e = c.initialColor, f = d && d.length || 0;
            c.xIncrement = null;
            if (S(e))
                rb = e;
            for (a = Eb(oc(a), function(g) {
                return(new c.pointClass).init(c, g)
            }); f--; )
                d[f].destroy();
            c.data = a;
            c.cleanData();
            c.getSegments();
            c.isDirty = true;
            A(b, true) && c.chart.redraw()
        }, remove: function(a) {
            var b = this, c = b.chart;
            a = A(a, true);
            if (!b.isRemoving) {
                b.isRemoving = true;
                za(b, "remove", null, function() {
                    b.destroy();
                    c.isDirty = true;
                    a && c.redraw()
                })
            }
            b.isRemoving = false
        }, translate: function() {
            for (var a =
                    this, b = a.chart, c = a.options.stacking, d = a.xAxis.categories, e = a.yAxis, f = e.stacks[a.type], g = a.data, j = g.length; j--; ) {
                var i = g[j], m = i.x, o = i.y, n;
                i.plotX = a.xAxis.translate(m);
                if (c && a.visible && f[m]) {
                    n = f[m];
                    m = n.total;
                    n.cum = n = n.cum - o;
                    o = n + o;
                    if (c == "percent") {
                        n = m ? n * 100 / m : 0;
                        o = m ? o * 100 / m : 0
                    }
                    i.percentage = m ? i.y * 100 / m : 0;
                    i.stackTotal = m;
                    i.yBottom = e.translate(n, 0, 1)
                }
                if (o !== null)
                    i.plotY = e.translate(o, 0, 1);
                i.clientX = b.inverted ? b.plotHeight - i.plotX : i.plotX;
                i.category = d && d[i.x] !== Ya ? d[i.x] : i.x
            }
        }, setTooltipPoints: function(a) {
            var b =
                    this, c = b.chart, d = c.inverted, e = [], f = (d ? c.plotTop : c.plotLeft) + c.plotSizeX, g, j, i = [];
            if (a)
                b.tooltipPoints = null;
            q(b.segments, function(m) {
                e = e.concat(m)
            });
            if (b.xAxis && b.xAxis.reversed)
                e = e.reverse();
            q(e, function(m, o) {
                b.tooltipPoints || m.setTooltipText();
                g = e[o - 1] ? e[o - 1].high + 1 : 0;
                for (j = m.high = e[o + 1]?jb((m.plotX + (e[o + 1]?e[o + 1].plotX:f)) / 2):f; g <= j; )
                    i[d ? f - g++ : g++] = m
            });
            b.tooltipPoints = i
        }, onMouseOver: function() {
            var a = this, b = a.chart, c = b.hoverSeries, d = a.stateMarkerGraphic;
            if (!b.mouseIsDown) {
                d && d.show();
                c && c != a && c.onMouseOut();
                a.options.events.mouseOver && za(a, "mouseOver");
                a.tracker && a.tracker.toFront();
                a.setState(ob);
                b.hoverSeries = a
            }
        }, onMouseOut: function() {
            var a = this, b = a.options, c = a.chart, d = c.tooltip, e = c.hoverPoint;
            e && e.onMouseOut();
            a && b.events.mouseOut && za(a, "mouseOut");
            d && !b.stickyTracking && d.hide();
            a.setState();
            c.hoverSeries = null
        }, animate: function(a) {
            var b = this, c = b.chart, d = b.clipRect;
            if (a) {
                if (!d.isAnimating) {
                    d.attr("width", 0);
                    d.isAnimating = true
                }
            } else {
                d.animate({width: c.plotSizeX}, {complete: function() {
                        d.isAnimating = false
                    },
                    duration: 1E3});
                this.animate = null
            }
        }, drawPoints: function() {
            var a = this, b, c = a.data, d = a.chart, e, f, g, j, i, m;
            if (a.options.marker.enabled)
                for (g = c.length; g--; ) {
                    j = c[g];
                    e = j.plotX;
                    f = j.plotY;
                    m = j.graphic;
                    if (j.plotY !== Ya) {
                        b = j.pointAttr[j.selected ? xb : Ka];
                        i = b.r;
                        if (m)
                            m.attr({x: e, y: f, r: i});
                        else
                            j.graphic = d.renderer.symbol(A(j.marker && j.marker.symbol, a.symbol), e, f, i).attr(b).add(a.group)
                    }
                }
        }, convertAttribs: function(a, b, c, d) {
            var e = this.pointAttrToOptions, f, g, j = {};
            a = a || {};
            b = b || {};
            c = c || {};
            d = d || {};
            for (f in e) {
                g = e[f];
                j[f] =
                        A(a[g], b[f], c[f], d[f])
            }
            return j
        }, getAttribs: function() {
            var a = this, b = a.options.marker || a.options, c = b.states, d = c[ob], e, f = {}, g = a.color, j = a.data, i = [], m, o = a.pointAttrToOptions;
            if (a.options.marker) {
                f = {stroke: g, fill: g};
                d.radius = d.radius || b.radius + 2;
                d.lineWidth = d.lineWidth || b.lineWidth + 1
            } else {
                f = {fill: g};
                d.color = d.color || Kb(d.color || g).brighten(d.brightness).get()
            }
            i[Ka] = a.convertAttribs(b, f);
            q([ob, xb], function(z) {
                i[z] = a.convertAttribs(c[z], i[Ka])
            });
            a.pointAttr = i;
            for (f = j.length; f--; ) {
                g = j[f];
                b = g.options && g.options.marker ||
                        g.options;
                e = false;
                if (g.options)
                    for (var n in o)
                        if (b[o[n]])
                            e = true;
                if (e) {
                    m = [];
                    c = b.states || {};
                    e = c[ob] = c[ob] || {};
                    if (!a.options.marker)
                        e.color = Kb(e.color || g.options.color).brighten(e.brightness || d.brightness).get();
                    m[Ka] = a.convertAttribs(b, i[Ka]);
                    m[ob] = a.convertAttribs(c[ob], i[ob], m[Ka]);
                    m[xb] = a.convertAttribs(c[xb], i[xb], m[Ka])
                } else
                    m = i;
                g.pointAttr = m
            }
        }, destroy: function() {
            var a = this, b = a.chart.series, c = a.clipRect, d;
            wb(a);
            a.legendItem && a.chart.legend.destroyItem(a);
            q(a.data, function(e) {
                e.destroy()
            });
            q(["area",
                "graph", "dataLabelsGroup", "group", "tracker"], function(e) {
                a[e] && a[e].destroy()
            });
            c && c != a.chart.clipRect && c.destroy();
            q(b, function(e, f) {
                e == a && b.splice(f, 1)
            });
            for (d in a)
                delete a[d]
        }, drawDataLabels: function() {
            if (this.options.dataLabels.enabled) {
                var a = this, b, c, d = a.data, e = a.options.dataLabels, f, g = a.dataLabelsGroup, j = a.chart, i = j.inverted, m = a.type, o;
                if (g)
                    g.empty();
                else
                    g = a.dataLabelsGroup = j.renderer.g(Fb + "data-labels").attr({visibility: a.visible ? Yb : Gb, zIndex: 4}).translate(j.plotLeft, j.plotTop).add();
                e.style.color =
                        A(e.color, a.color);
                q(d, function(n) {
                    var z = A(n.barX, n.plotX), na = n.plotY, ga = n.tooltipPos;
                    f = e.formatter.call({x: n.x, y: n.y, series: a, point: n, percentage: n.percentage, total: n.total || n.stackTotal});
                    b = (i ? j.plotWidth - na : z) + e.x;
                    c = (i ? j.plotHeight - z : na) + e.y;
                    if (ga) {
                        b = ga[0] + e.x;
                        c = ga[1] + e.y
                    }
                    o = e.align;
                    if (m == "column")
                        b += {center: n.barW / 2, right: n.barW}[o] || 0;
                    if (f)
                        n.dataLabel = j.renderer.text(f, b, c, e.style, e.rotation, o).attr({zIndex: 1}).add(n.group || g);
                    a.drawConnector && a.drawConnector(n)
                })
            }
        }, drawGraph: function() {
            var a =
                    this, b = a.options, c = a.chart, d = a.graph, e = [], f = a.area, g = a.group, j = b.lineColor || a.color, i = b.lineWidth, m;
            c = c.renderer;
            var o = a.yAxis.getZeroPlane(b.threshold || 0), n = [];
            q(a.segments, function(z) {
                m = [];
                q(z, function(ha, Wa) {
                    Wa < 2 && m.push([ib, Na][Wa]);
                    if (Wa && b.step) {
                        Wa = z[Wa - 1];
                        m.push(ha.plotX, Wa.plotY)
                    }
                    m.push(ha.plotX, ha.plotY)
                });
                e = e.concat(m);
                if (/^area/.test(a.type)) {
                    var na = [], ga, va = m.length;
                    for (ga = 0; ga < va; ga++)
                        na.push(m[ga]);
                    if (b.stacking && a.type != "areaspline")
                        for (ga = z.length - 1; ga >= 0; ga--)
                            na.push(z[ga].plotX,
                                    z[ga].yBottom);
                    else
                        na.push(z[z.length - 1].plotX, o, z[0].plotX, o, "z");
                    n = n.concat(na)
                }
            });
            if (n.length)
                a.areaPath = n;
            a.graphPath = e;
            if (d)
                d.attr({d: e});
            else if (i)
                a.graph = c.path(e).attr({stroke: j, "stroke-width": i + Ia}).add(g).shadow(b.shadow);
            if (n.length) {
                d = A(b.fillColor, Kb(a.color).setOpacity(b.fillOpacity || 0.75).get());
                if (f)
                    f.attr({d: n});
                else
                    a.area = a.chart.renderer.path(n).attr({fill: d}).add(a.group)
            }
        }, render: function() {
            var a = this, b = a.chart, c, d = a.options.animation && a.animate;
            c = b.renderer;
            if (!a.clipRect) {
                a.clipRect =
                        !b.hasRendered && b.clipRect ? b.clipRect : c.clipRect(0, 0, b.plotSizeX, b.plotSizeY);
                if (!b.clipRect)
                    b.clipRect = a.clipRect
            }
            if (!a.group) {
                c = a.group = c.g("series");
                b.inverted && c.attr({width: b.plotWidth, height: b.plotHeight}).invert();
                c.clip(a.clipRect).attr({visibility: a.visible ? Yb : Gb, zIndex: 3}).translate(b.plotLeft, b.plotTop).add()
            }
            a.drawDataLabels();
            d && a.animate(true);
            a.getAttribs();
            a.drawGraph && a.drawGraph();
            a.drawPoints();
            a.options.enableMouseTracking !== false && a.drawTracker();
            d && a.animate();
            a.isDirty = false
        },
        redraw: function() {
            var a = this;
            a.translate();
            a.setTooltipPoints(true);
            a.render()
        }, setState: function(a) {
            var b = this, c = b.options, d = b.graph, e = c.states, f = b.stateMarkerGraphic;
            c = c.lineWidth;
            a = a || Ka;
            if (b.state != a) {
                b.state = a;
                if (!(e[a] && e[a].enabled === false)) {
                    if (a)
                        c = e[a].lineWidth || c;
                    else
                        f && f.hide();
                    if (d)
                        d.animate({"stroke-width": c}, a ? 0 : 500)
                }
            }
        }, setVisible: function(a, b) {
            var c = this, d = c.chart, e = c.legendItem, f = c.group, g = c.tracker, j = c.dataLabelsGroup, i, m = c.data, o = d.options.chart.ignoreHiddenSeries;
            i = c.visible;
            i =
                    (c.visible = a = a === Ya ? !i : a) ? "show" : "hide";
            if (a)
                c.isDirty = o;
            f && f[i]();
            if (g)
                g[i]();
            else
                for (f = m.length; f--; ) {
                    g = m[f];
                    g.tracker && g.tracker[i]()
                }
            j && j[i]();
            e && d.legend.colorizeItem(c, a);
            o && c.options.stacking && q(d.series, function(n) {
                if (n.options.stacking && n.visible)
                    n.isDirty = true
            });
            b !== false && d.redraw();
            za(c, i)
        }, show: function() {
            this.setVisible(true)
        }, hide: function() {
            this.setVisible(false)
        }, select: function(a) {
            var b = this;
            b.selected = a = a === Ya ? !b.selected : a;
            if (b.checkbox)
                b.checkbox.checked = a;
            za(b, a ? "select" : "unselect")
        },
        drawTracker: function() {
            var a = this, b = a.options, c = a.graphPath, d = a.chart, e = a.tracker, f = b.cursor;
            f = f && {cursor: f};
            if (e)
                e.attr({d: c});
            else
                a.tracker = d.renderer.path(c).attr({isTracker: true, stroke: cd, fill: fb, "stroke-width": b.lineWidth + 2 * d.options.tooltip.snap, "stroke-linecap": "round", visibility: a.visible ? Yb : Gb, zIndex: 1}).on("mouseover", function() {
                    d.hoverSeries != a && a.onMouseOver()
                }).on("mouseout", function() {
                    b.stickyTracking || a.onMouseOut()
                }).css(f).add(d.trackerGroup)
        }};
    qa = gb(Ra);
    eb.line = qa;
    qa = gb(Ra, {type: "area"});
    eb.area = qa;
    ad.prototype = {get: function(a) {
            a || (a = 50);
            var b = this.n;
            b = (this.xdata[b - 1] - this.xdata[0]) / (a - 1);
            var c = [], d = [];
            c[0] = this.xdata[0];
            d[0] = this.ydata[0];
            for (var e = [{plotX: c[0], plotY: d[0]}], f = 1; f < a; f++) {
                c[f] = c[0] + f * b;
                d[f] = this.interpolate(c[f]);
                e[f] = {plotX: c[f], plotY: d[f]}
            }
            return e
        }, interpolate: function(a) {
            for (var b = this.n - 1, c = 0; b - c > 1; ) {
                var d = (b + c) / 2;
                if (this.xdata[jb(d)] > a)
                    b = d;
                else
                    c = d
            }
            b = jb(b);
            c = jb(c);
            d = this.xdata[b] - this.xdata[c];
            var e = (this.xdata[b] - a) / d;
            a = (a - this.xdata[c]) / d;
            return e * this.ydata[c] +
                    a * this.ydata[b] + ((e * e * e - e) * this.y2[c] + (a * a * a - a) * this.y2[b]) * d * d / 6
        }};
    qa = gb(Ra, {type: "spline", drawGraph: function() {
            var a = this, b = a.segments;
            a.splinedata = a.getSplineData();
            a.segments = a.splinedata;
            Ra.prototype.drawGraph.apply(a, arguments);
            a.segments = b
        }, getSplineData: function() {
            var a = this, b = a.chart, c = [], d;
            q(a.segments, function(e) {
                if (a.xAxis.reversed)
                    e = e.reverse();
                var f = [], g, j;
                q(e, function(i, m) {
                    g = e[m + 2] || e[m + 1] || i;
                    j = e[m - 2] || e[m - 1] || i;
                    g.plotX >= 0 && j.plotX <= b.plotWidth && f.push(i)
                });
                if (f.length > 1)
                    d = W(sb(b.plotWidth,
                            f[f.length - 1].clientX - f[0].clientX) / 3);
                c.push(e.length > 1 ? d ? (new ad(f)).get(d) : [] : e)
            });
            return c
        }});
    eb.spline = qa;
    qa = gb(qa, {type: "areaspline"});
    eb.areaspline = qa;
    var nc = gb(Ra, {type: "column", pointAttrToOptions: {stroke: "borderColor", "stroke-width": "borderWidth", fill: "color", r: "borderRadius"}, init: function() {
            Ra.prototype.init.apply(this, arguments);
            var a = this, b = a.chart;
            b.hasRendered && q(b.series, function(c) {
                if (c.type == a.type)
                    c.isDirty = true
            })
        }, translate: function() {
            var a = this, b = a.chart, c = 0, d = a.xAxis.reversed,
                    e = a.xAxis.categories, f;
            Ra.prototype.translate.apply(a);
            q(b.series, function(va) {
                if (va.type == a.type)
                    if (va.options.stacking) {
                        S(f) || (f = c++);
                        va.columnIndex = f
                    } else
                        va.columnIndex = c++
            });
            var g = a.options, j = a.data, i = a.closestPoints;
            b = Za(j[1] ? j[i].plotX - j[i - 1].plotX : b.plotSizeX / e ? e.length : 1);
            e = b * g.groupPadding;
            i = b - 2 * e;
            i = i / c;
            var m = g.pointWidth, o = S(m) ? (i - m) / 2 : i * g.pointPadding, n = A(m, i - 2 * o);
            m = (d ? c - a.columnIndex : a.columnIndex) || 0;
            var z = o + (e + m * i - b / 2) * (d ? -1 : 1), na = a.yAxis.getZeroPlane(g.threshold || 0), ga = g.minPointLength;
            q(j, function(va) {
                var ha = va.plotY, Wa = va.plotX + z, Hb = Lb(ha, na), Pb = n, Qb = Za((va.yBottom || na) - ha), H;
                if (Za(Qb) < (ga || 5)) {
                    if (ga) {
                        Qb = ga;
                        Hb = na - (ha <= na ? ga : 0)
                    }
                    H = Hb - 3
                }
                O(va, {barX: Wa, barY: Hb, barW: Pb, barH: Qb});
                va.shapeType = "rect";
                va.shapeArgs = {x: Wa, y: Hb, width: Pb, height: Qb, r: g.borderRadius};
                if (S(H))
                    va.trackerArgs = ia(va.shapeArgs, {height: 6, y: H})
            })
        }, getSymbol: function() {
        }, drawGraph: function() {
        }, drawPoints: function() {
            var a = this, b = a.options, c = a.chart.renderer, d, e;
            q(a.data, function(f) {
                if (S(f.plotY)) {
                    d = f.graphic;
                    e = f.shapeArgs;
                    if (d)
                        d.attr(e);
                    else
                        f.graphic = c[f.shapeType](e).attr(f.pointAttr[f.selected ? xb : Ka]).add(a.group).shadow(b.shadow)
                }
            })
        }, drawTracker: function() {
            var a = this, b = a.chart, c = b.renderer, d, e, f = +new Date, g = a.options.cursor, j = g && {cursor: g}, i;
            q(a.data, function(m) {
                e = m.tracker;
                d = m.trackerArgs || m.shapeArgs;
                if (e)
                    e.attr(d);
                else
                    m.tracker = c[m.shapeType](d).attr({isTracker: f, fill: cd, visibility: a.visible ? Yb : Gb, zIndex: 1}).on("mouseover", function(o) {
                        i = o.relatedTarget || o.fromElement;
                        b.hoverSeries != a && oa(i, "isTracker") != f &&
                                a.onMouseOver();
                        m.onMouseOver()
                    }).on("mouseout", function(o) {
                        if (!a.options.stickyTracking) {
                            i = o.relatedTarget || o.toElement;
                            oa(i, "isTracker") != f && a.onMouseOut()
                        }
                    }).css(j).add(b.trackerGroup)
            })
        }, cleanData: function() {
            var a = this, b = a.data, c, d, e, f;
            Ra.prototype.cleanData.apply(a);
            for (f = b.length - 1; f >= 0; f--)
                if (b[f - 1]) {
                    c = b[f].x - b[f - 1].x;
                    if (d === Ya || c < d) {
                        d = c;
                        e = f
                    }
                }
            a.closestPoints = e
        }, animate: function(a) {
            var b = this, c = b.data;
            if (!a) {
                q(c, function(d) {
                    var e = d.graphic;
                    if (e) {
                        e.attr({height: 0, y: b.yAxis.translate(0, 0, 1)});
                        e.animate({height: d.barH, y: d.barY}, {duration: 1E3})
                    }
                });
                b.animate = null
            }
        }, remove: function() {
            var a = this, b = a.chart;
            b.hasRendered && q(b.series, function(c) {
                if (c.type == a.type)
                    c.isDirty = true
            });
            Ra.prototype.remove.apply(a, arguments)
        }});
    eb.column = nc;
    qa = gb(nc, {type: "bar", init: function(a) {
            a.inverted = this.inverted = true;
            nc.prototype.init.apply(this, arguments)
        }});
    eb.bar = qa;
    qa = gb(Ra, {type: "scatter", translate: function() {
            var a = this;
            Ra.prototype.translate.apply(a);
            q(a.data, function(b) {
                b.shapeType = "circle";
                b.shapeArgs =
                        {x: b.plotX, y: b.plotY, r: a.chart.options.tooltip.snap}
            })
        }, drawTracker: function() {
            var a = this, b = a.options.cursor, c = b && {cursor: b};
            q(a.data, function(d) {
                d.graphic.attr({isTracker: true}).on("mouseover", function() {
                    a.onMouseOver();
                    d.onMouseOver()
                }).on("mouseout", function() {
                    a.options.stickyTracking || a.onMouseOut()
                }).css(c)
            })
        }, cleanData: function() {
        }});
    eb.scatter = qa;
    qa = gb(Zb, {init: function() {
            Zb.prototype.init.apply(this, arguments);
            var a = this, b;
            O(a, {visible: a.visible !== false, name: A(a.name, "Slice")});
            b = function() {
                a.slice()
            };
            cb(a, "select", b);
            cb(a, "unselect", b);
            return a
        }, setVisible: function(a) {
            var b = this, c = b.series.chart;
            if (b.visible = a = a === Ya ? !b.visible : a) {
                b.group.show();
                b.tracker.show()
            } else {
                b.group.hide();
                b.tracker.hide()
            }
            b.legendItem && c.legend.colorizeItem(b, a)
        }, slice: function(a, b) {
            var c = this, d = c.series;
            d = d.chart;
            var e = c.slicedTranslation;
            A(b, true);
            a = c.sliced = S(a) ? a : !c.sliced;
            c.group.animate({translateX: a ? e[0] : d.plotLeft, translateY: a ? e[1] : d.plotTop}, 100)
        }});
    qa = gb(Ra, {type: "pie", isCartesian: false, pointClass: qa, pointAttrToOptions: {stroke: "borderColor",
            "stroke-width": "borderWidth", fill: "color"}, getColor: function() {
            this.initialColor = rb
        }, translate: function() {
            var a = 0, b = this, c = -0.25, d = b.options, e = d.slicedOffset, f = d.center, g = b.chart, j = g.plotWidth, i = g.plotHeight, m, o, n;
            b = b.data;
            var z = 2 * Fa.PI, na, ga = Lb(j, i), va;
            f.push(d.size, d.innerSize || 0);
            f = Eb(f, function(ha, Wa) {
                return(va = /%$/.test(ha)) ? [j, i, ga, ga][Wa] * parseInt(ha, 10) / 100 : ha
            });
            q(b, function(ha) {
                a += ha.y
            });
            q(b, function(ha) {
                na = a ? ha.y / a : 0;
                m = c * z;
                c += na;
                o = c * z;
                ha.shapeType = "arc";
                ha.shapeArgs = {x: f[0], y: f[1], r: f[2] /
                            2, innerR: f[3] / 2, start: m, end: o};
                n = (o + m) / 2;
                ha.slicedTranslation = Eb([Ib(n) * e + g.plotLeft, Jb(n) * e + g.plotTop], W);
                ha.tooltipPos = [f[0] + Ib(n) * f[2] * 0.35, f[1] + Jb(n) * f[2] * 0.35];
                ha.percentage = na * 100;
                ha.total = a
            });
            this.setTooltipPoints()
        }, render: function() {
            var a = this;
            a.getAttribs();
            this.drawPoints();
            a.options.enableMouseTracking !== false && a.drawTracker();
            this.drawDataLabels();
            a.isDirty = false
        }, drawPoints: function() {
            var a = this, b = a.chart, c = b.renderer, d, e, f;
            q(this.data, function(g) {
                e = g.graphic;
                f = g.shapeArgs;
                if (!g.group) {
                    d =
                            g.sliced ? g.slicedTranslation : [b.plotLeft, b.plotTop];
                    g.group = c.g("point").attr({zIndex: 3}).add().translate(d[0], d[1])
                }
                if (e)
                    e.attr(f);
                else
                    g.graphic = c.arc(f).attr(g.pointAttr[Ka]).add(g.group);
                g.visible === false && g.setVisible(false)
            })
        }, drawTracker: nc.prototype.drawTracker, getSymbol: function() {
        }});
    eb.pie = qa;
    db.Highcharts = {Chart: gd, dateFormat: hc, defaultOptions: sa, numberFormat: ed, Point: Zb, Renderer: Zc, seriesTypes: eb, setOptions: dd, Series: Ra, addEvent: cb, createElement: Da, discardElement: cc, css: Sa, each: q, extend: O,
        map: Eb, merge: ia, pick: A, extendClass: gb}
})();
