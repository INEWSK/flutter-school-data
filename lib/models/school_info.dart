class SchoolInfo {
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? f;
  String? g;
  String? h;
  String? i;
  String? j;
  String? k;
  String? l;
  String? m;
  String? n;
  String? o;
  String? p;
  String? q;
  String? r;
  String? s;
  String? t;
  String? u;
  String? v;
  String? w;
  String? x;
  String? y;
  String? z;
  String? aA;
  String? aB;
  String? aC;
  String? aD;
  String? aE;
  String? aF;
  String? aG;

  SchoolInfo(
      {this.a,
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
      this.aA,
      this.aB,
      this.aC,
      this.aD,
      this.aE,
      this.aF,
      this.aG});

  SchoolInfo.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
    e = json['E'];
    f = json['F'];
    g = json['G'];
    h = json['H'];
    i = json['I'];
    j = json['J'];
    k = json['K'];
    l = json['L'];
    m = json['M'];
    n = json['N'];
    o = json['O'];
    p = json['P'];
    q = json['Q'];
    r = json['R'];
    s = json['S'];
    t = json['T'];
    u = json['U'];
    v = json['V'];
    w = json['W'];
    x = json['X'];
    y = json['Y'];
    z = json['Z'];
    aA = json['AA'];
    aB = json['AB'];
    aC = json['AC'];
    aD = json['AD'];
    aE = json['AE'];
    aF = json['AF'];
    aG = json['AG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['D'] = d;
    data['E'] = e;
    data['F'] = f;
    data['G'] = g;
    data['H'] = h;
    data['I'] = i;
    data['J'] = j;
    data['K'] = k;
    data['L'] = l;
    data['M'] = m;
    data['N'] = n;
    data['O'] = o;
    data['P'] = p;
    data['Q'] = q;
    data['R'] = r;
    data['S'] = s;
    data['T'] = t;
    data['U'] = u;
    data['V'] = v;
    data['W'] = w;
    data['X'] = x;
    data['Y'] = y;
    data['Z'] = z;
    data['AA'] = aA;
    data['AB'] = aB;
    data['AC'] = aC;
    data['AD'] = aD;
    data['AE'] = aE;
    data['AF'] = aF;
    data['AG'] = aG;
    return data;
  }
}
