class User {
  Userde userde;
  String oran;
  String kazanc;
  String kazancliAlim;
  String toplamAlim;
  String toplamDagitim;

  User(
      {this.userde,
      this.oran,
      this.kazanc,
      this.kazancliAlim,
      this.toplamAlim,
      this.toplamDagitim});

  User.fromJson(Map<String, dynamic> json) {
    userde =
        json['userde'] != null ? new Userde.fromJson(json['userde']) : null;
    oran = json['oran'] ?? '';
    kazanc = json['kazanc'] ?? '';
    kazancliAlim = json['kazancli_alim'] ?? '';
    toplamAlim = json['toplam_alim'] ?? '';
    toplamDagitim = json['toplam_dagitim'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userde != null) {
      data['userde'] = this.userde.toJson();
    }
    data['oran'] = this.oran;
    data['kazanc'] = this.kazanc;
    data['kazancli_alim'] = this.kazancliAlim;
    data['toplam_alim'] = this.toplamAlim;
    data['toplam_dagitim'] = this.toplamDagitim;
    return data;
  }
}

class Userde {
  int id;
  String email;
  int eczaneId;
  int grupId;
  String emailVerifiedAt;
  int bildirim;
  int geceBildirim;
  String createdAt;
  String updatedAt;
  String bakiye;
  Eczane eczane;

  Userde(
      {this.id,
      this.email,
      this.eczaneId,
      this.grupId,
      this.emailVerifiedAt,
      this.bildirim,
      this.geceBildirim,
      this.createdAt,
      this.updatedAt,
      this.bakiye,
      this.eczane});

  Userde.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    eczaneId = json['eczane_id'] ?? '';
    grupId = json['grup_id'] ?? '';
    emailVerifiedAt = json['email_verified_at'] ?? '';
    bildirim = json['bildirim'] ?? '';
    geceBildirim = json['gece_bildirim'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    bakiye = json['bakiye'] ?? '';
    eczane =
        json['eczane'] != null ? new Eczane.fromJson(json['eczane']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['eczane_id'] = this.eczaneId;
    data['grup_id'] = this.grupId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['bildirim'] = this.bildirim;
    data['gece_bildirim'] = this.geceBildirim;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bakiye'] = this.bakiye;
    if (this.eczane != null) {
      data['eczane'] = this.eczane.toJson();
    }
    return data;
  }
}

class Eczane {
  int id;
  int gln;
  String ad;
  int ilId;
  int ilceId;
  String telefon;
  String email;
  String sorumlu;
  String adres;
  int kayit;
  String createdAt;
  String updatedAt;
  Il il;
  Ilce ilce;

  Eczane(
      {this.id,
      this.gln,
      this.ad,
      this.ilId,
      this.ilceId,
      this.telefon,
      this.email,
      this.sorumlu,
      this.adres,
      this.kayit,
      this.createdAt,
      this.updatedAt,
      this.il,
      this.ilce});

  Eczane.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    gln = json['gln'] ?? '';
    ad = json['ad'] ?? '';
    ilId = json['il_id'] ?? '';
    ilceId = json['ilce_id'] ?? '';
    telefon = json['telefon'] ?? '';
    email = json['email'] ?? '';
    sorumlu = json['sorumlu'] ?? '';
    adres = json['adres'] ?? '';
    kayit = json['kayit'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    il = json['il'] != null ? new Il.fromJson(json['il']) : null;
    ilce = json['ilce'] != null ? new Ilce.fromJson(json['ilce']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gln'] = this.gln;
    data['ad'] = this.ad;
    data['il_id'] = this.ilId;
    data['ilce_id'] = this.ilceId;
    data['telefon'] = this.telefon;
    data['email'] = this.email;
    data['sorumlu'] = this.sorumlu;
    data['adres'] = this.adres;
    data['kayit'] = this.kayit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.il != null) {
      data['il'] = this.il.toJson();
    }
    if (this.ilce != null) {
      data['ilce'] = this.ilce.toJson();
    }
    return data;
  }
}

class Il {
  int id;
  String baslik;
  String createdAt;
  String updatedAt;

  Il({this.id, this.baslik, this.createdAt, this.updatedAt});

  Il.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    baslik = json['baslik'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['baslik'] = this.baslik;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Ilce {
  int id;
  int ilId;
  String baslik;
  String createdAt;
  String updatedAt;

  Ilce({this.id, this.ilId, this.baslik, this.createdAt, this.updatedAt});

  Ilce.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    ilId = json['il_id'] ?? '';
    baslik = json['baslik'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['il_id'] = this.ilId;
    data['baslik'] = this.baslik;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}