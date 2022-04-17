import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'school.g.dart';

@HiveType(typeId: 1)
class School extends HiveObject {
  @HiveField(0)
  String? a;
  @HiveField(1)
  String? b;
  @HiveField(2)
  String? c;
  @HiveField(3)
  String? d;
  @HiveField(4)
  String? e;
  @HiveField(5)
  String? f;
  @HiveField(6)
  String? g;
  @HiveField(7)
  String? h;
  @HiveField(8)
  String? i;
  @HiveField(9)
  String? j;
  @HiveField(10)
  String? k;
  @HiveField(11)
  String? l;
  @HiveField(12)
  String? m;
  @HiveField(13)
  String? n;
  @HiveField(14)
  String? o;
  @HiveField(15)
  String? p;
  @HiveField(16)
  String? q;
  @HiveField(17)
  String? r;
  @HiveField(18)
  String? s;
  @HiveField(19)
  String? t;
  @HiveField(20)
  String? u;
  @HiveField(21)
  String? v;
  @HiveField(22)
  String? w;
  @HiveField(23)
  String? x;
  @HiveField(24)
  String? y;
  @HiveField(25)
  String? z;
  @HiveField(26)
  String? aa;
  @HiveField(27)
  String? ab;
  @HiveField(28)
  String? ac;
  @HiveField(29)
  String? ad;
  @HiveField(30)
  String? ae;
  @HiveField(31)
  String? af;
  @HiveField(32)
  String? ag;

  School({
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.f,
    this.g,
    this.h,
    this.i,
    this.j,
    this.k,
    this.l,
    this.m,
    this.n,
    this.o,
    this.p,
    this.q,
    this.r,
    this.s,
    this.t,
    this.u,
    this.v,
    this.w,
    this.x,
    this.y,
    this.z,
    this.aa,
    this.ab,
    this.ac,
    this.ad,
    this.ae,
    this.af,
    this.ag,
  });

  @override
  String toString() {
    return 'School(a: $a, b: $b, c: $c, d: $d, e: $e, f: $f, g: $g, h: $h, i: $i, j: $j, k: $k, l: $l, m: $m, n: $n, o: $o, p: $p, q: $q, r: $r, s: $s, t: $t, u: $u, v: $v, w: $w, x: $x, y: $y, z: $z, aa: $aa, ab: $ab, ac: $ac, ad: $ad, ae: $ae, af: $af, ag: $ag)';
  }

  factory School.fromMap(Map<String, dynamic> data) => School(
        a: data['A'] as String?,
        b: data['B'] as String?,
        c: data['C'] as String?,
        d: data['D'] as String?,
        e: data['E'] as String?,
        f: data['F'] as String?,
        g: data['G'] as String?,
        h: data['H'] as String?,
        i: data['I'] as String?,
        j: data['J'] as String?,
        k: data['K'] as String?,
        l: data['L'] as String?,
        m: data['M'] as String?,
        n: data['N'] as String?,
        o: data['O'] as String?,
        p: data['P'] as String?,
        q: data['Q'] as String?,
        r: data['R'] as String?,
        s: data['S'] as String?,
        t: data['T'] as String?,
        u: data['U'] as String?,
        v: data['V'] as String?,
        w: data['W'] as String?,
        x: data['X'] as String?,
        y: data['Y'] as String?,
        z: data['Z'] as String?,
        aa: data['AA'] as String?,
        ab: data['AB'] as String?,
        ac: data['AC'] as String?,
        ad: data['AD'] as String?,
        ae: data['AE'] as String?,
        af: data['AF'] as String?,
        ag: data['AG'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'A': a,
        'B': b,
        'C': c,
        'D': d,
        'E': e,
        'F': f,
        'G': g,
        'H': h,
        'I': i,
        'J': j,
        'K': k,
        'L': l,
        'M': m,
        'N': n,
        'O': o,
        'P': p,
        'Q': q,
        'R': r,
        'S': s,
        'T': t,
        'U': u,
        'V': v,
        'W': w,
        'X': x,
        'Y': y,
        'Z': z,
        'AA': aa,
        'AB': ab,
        'AC': ac,
        'AD': ad,
        'AE': ae,
        'AF': af,
        'AG': ag,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [School].
  factory School.fromJson(String data) {
    return School.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [School] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! School) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      a.hashCode ^
      b.hashCode ^
      c.hashCode ^
      d.hashCode ^
      e.hashCode ^
      f.hashCode ^
      g.hashCode ^
      h.hashCode ^
      i.hashCode ^
      j.hashCode ^
      k.hashCode ^
      l.hashCode ^
      m.hashCode ^
      n.hashCode ^
      o.hashCode ^
      p.hashCode ^
      q.hashCode ^
      r.hashCode ^
      s.hashCode ^
      t.hashCode ^
      u.hashCode ^
      v.hashCode ^
      w.hashCode ^
      x.hashCode ^
      y.hashCode ^
      z.hashCode ^
      aa.hashCode ^
      ab.hashCode ^
      ac.hashCode ^
      ad.hashCode ^
      ae.hashCode ^
      af.hashCode ^
      ag.hashCode;
}
