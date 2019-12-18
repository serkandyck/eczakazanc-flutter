class Teklif {
  int id;
  int urunId;
  String baslangicTarihi;
  String bitisTarihi;
  int maxAlim;
  int minAlim;
  int hedefAlim;
  String sktarihi;
  String aciklama;
  int hedefAlimId;
  String etiketFiyati;
  String depoFiyati;
  int teklifTipId;
  int teklifTurId;
  int teklifYayinTipId;
  int grupId;
  int userId;
  int ozelEczId;
  int alimMiktar;
  int malFazlasi;
  int teklifDurum;
  String iskontoYuzde;
  String iskontoTl;
  String createdAt;
  String updatedAt;
  String netFiyat;
  int kalan;
  String teklifTurAd;
  int kalanGun;
  String eczaneAd;
  int eczaneGln;
  String urunAd;
  String mf;
  String yuzde;
  int satilan;
  Urun urun;
  List<Alimlar> alimlar;
  Il teklifTur;
  Kullanici user;

  Teklif(
      {this.id,
      this.urunId,
      this.baslangicTarihi,
      this.bitisTarihi,
      this.maxAlim,
      this.minAlim,
      this.hedefAlim,
      this.sktarihi,
      this.aciklama,
      this.hedefAlimId,
      this.etiketFiyati,
      this.depoFiyati,
      this.teklifTipId,
      this.teklifTurId,
      this.teklifYayinTipId,
      this.grupId,
      this.userId,
      this.ozelEczId,
      this.alimMiktar,
      this.malFazlasi,
      this.teklifDurum,
      this.iskontoYuzde,
      this.iskontoTl,
      this.createdAt,
      this.updatedAt,
      this.netFiyat,
      this.kalan,
      this.teklifTurAd,
      this.kalanGun,
      this.eczaneAd,
      this.eczaneGln,
      this.urunAd,
      this.mf,
      this.yuzde,
      this.satilan,
      this.urun,
      this.alimlar,
      this.teklifTur,
      this.user});

  Teklif.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    urunId = json['urun_id'] ?? '';
    baslangicTarihi = json['baslangic_tarihi'] ?? '';
    bitisTarihi = json['bitis_tarihi'] ?? '';
    maxAlim = json['max_alim'] ?? '';
    minAlim = json['min_alim'] ?? '';
    hedefAlim = json['hedef_alim'] ?? '';
    sktarihi = json['sktarihi'] ?? '';
    aciklama = json['aciklama'] ?? '';
    hedefAlimId = json['hedef_alim_id'] ?? '';
    etiketFiyati = json['etiket_fiyati'] ?? '';
    depoFiyati = json['depo_fiyati'] ?? '';
    teklifTipId = json['teklif_tip_id'] ?? '';
    teklifTurId = json['teklif_tur_id'] ?? '';
    teklifYayinTipId = json['teklif_yayin_tip_id'] ?? '';
    grupId = json['grup_id'] ?? '';
    userId = json['user_id'] ?? '';
    ozelEczId = json['ozel_ecz_id'] ?? '';
    alimMiktar = json['alim_miktar'] ?? '';
    malFazlasi = json['mal_fazlasi'] ?? '';
    teklifDurum = json['teklif_durum'] ?? '';
    iskontoYuzde = json['iskonto_yuzde'] ?? '';
    iskontoTl = json['iskonto_tl'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    netFiyat = json['net_fiyat'] ?? '';
    kalan = json['kalan'] ?? '';
    teklifTurAd = json['teklif_tur_ad'] ?? '';
    kalanGun = json['kalan_gun'] ?? '';
    eczaneAd = json['eczane_ad'] ?? '';
    eczaneGln = json['eczane_gln'] ?? '';
    urunAd = json['urun_ad'] ?? '';
    mf = json['mf'] ?? '';
    yuzde = json['yuzde'] ?? '';
    satilan = json['satilan'] ?? '';
    urun = json['urun'] != null ? new Urun.fromJson(json['urun']) : null;
    if (json['alimlar'] != null) {
      alimlar = new List<Alimlar>();
      json['alimlar'].forEach((v) {
        alimlar.add(new Alimlar.fromJson(v));
      });
    }
    teklifTur =
        json['teklif_tur'] != null ? new Il.fromJson(json['teklif_tur']) : null;
    user = json['user'] != null ? new Kullanici.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urun_id'] = this.urunId;
    data['baslangic_tarihi'] = this.baslangicTarihi;
    data['bitis_tarihi'] = this.bitisTarihi;
    data['max_alim'] = this.maxAlim;
    data['min_alim'] = this.minAlim;
    data['hedef_alim'] = this.hedefAlim;
    data['sktarihi'] = this.sktarihi;
    data['aciklama'] = this.aciklama;
    data['hedef_alim_id'] = this.hedefAlimId;
    data['etiket_fiyati'] = this.etiketFiyati;
    data['depo_fiyati'] = this.depoFiyati;
    data['teklif_tip_id'] = this.teklifTipId;
    data['teklif_tur_id'] = this.teklifTurId;
    data['teklif_yayin_tip_id'] = this.teklifYayinTipId;
    data['grup_id'] = this.grupId;
    data['user_id'] = this.userId;
    data['ozel_ecz_id'] = this.ozelEczId;
    data['alim_miktar'] = this.alimMiktar;
    data['mal_fazlasi'] = this.malFazlasi;
    data['teklif_durum'] = this.teklifDurum;
    data['iskonto_yuzde'] = this.iskontoYuzde;
    data['iskonto_tl'] = this.iskontoTl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['net_fiyat'] = this.netFiyat;
    data['kalan'] = this.kalan;
    data['teklif_tur_ad'] = this.teklifTurAd;
    data['kalan_gun'] = this.kalanGun;
    data['eczane_ad'] = this.eczaneAd;
    data['eczane_gln'] = this.eczaneGln;
    data['urun_ad'] = this.urunAd;
    data['mf'] = this.mf;
    data['yuzde'] = this.yuzde;
    data['satilan'] = this.satilan;
    if (this.urun != null) {
      data['urun'] = this.urun.toJson();
    }
    if (this.alimlar != null) {
      data['alimlar'] = this.alimlar.map((v) => v.toJson()).toList();
    }
    if (this.teklifTur != null) {
      data['teklif_tur'] = this.teklifTur.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Urun {
  int id;
  String ad;
  String barkod;
  String karekod;
  String firma;
  var kategori;
  String resim;
  String createdAt;
  String updatedAt;

  Urun(
      {this.id,
      this.ad,
      this.barkod,
      this.karekod,
      this.firma,
      this.kategori,
      this.resim,
      this.createdAt,
      this.updatedAt});

  Urun.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    ad = json['ad'] ?? '';
    barkod = json['barkod'] ?? '';
    karekod = json['karekod'] ?? '';
    firma = json['firma'] ?? '';
    kategori = json['kategori'] ?? '';
    resim = json['resim'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad'] = this.ad;
    data['barkod'] = this.barkod;
    data['karekod'] = this.karekod;
    data['firma'] = this.firma;
    data['kategori'] = this.kategori;
    data['resim'] = this.resim;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Alimlar {
  int id;
  int urunId;
  int userId;
  int grupId;
  int durum;
  int teklifId;
  int adet;
  int alimTip;
  int itsDurum;
  int kargoId;
  int sevkiyatDurumId;
  String createdAt;
  String updatedAt;
  String eczaneAd;
  int eczaneGln;
  Kullanici kullanici;
  Il sevkiyatDurum;

  Alimlar(
      {this.id,
      this.urunId,
      this.userId,
      this.grupId,
      this.durum,
      this.teklifId,
      this.adet,
      this.alimTip,
      this.itsDurum,
      this.kargoId,
      this.sevkiyatDurumId,
      this.createdAt,
      this.updatedAt,
      this.eczaneAd,
      this.eczaneGln,
      this.kullanici,
      this.sevkiyatDurum});

  Alimlar.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    urunId = json['urun_id'] ?? '';
    userId = json['user_id'] ?? '';
    grupId = json['grup_id'] ?? '';
    durum = json['durum'] ?? '';
    teklifId = json['teklif_id'] ?? '';
    adet = json['adet'] ?? '';
    alimTip = json['alim_tip'] ?? '';
    itsDurum = json['its_durum'] ?? '';
    kargoId = json['kargo_id'] ?? '';
    sevkiyatDurumId = json['sevkiyat_durum_id'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    eczaneAd = json['eczane_ad'] ?? '';
    eczaneGln = json['eczane_gln'] ?? '';
    kullanici = json['kullanici'] != null
        ? new Kullanici.fromJson(json['kullanici'])
        : null;
    sevkiyatDurum = json['sevkiyat_durum'] != null
        ? new Il.fromJson(json['sevkiyat_durum'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urun_id'] = this.urunId;
    data['user_id'] = this.userId;
    data['grup_id'] = this.grupId;
    data['durum'] = this.durum;
    data['teklif_id'] = this.teklifId;
    data['adet'] = this.adet;
    data['alim_tip'] = this.alimTip;
    data['its_durum'] = this.itsDurum;
    data['kargo_id'] = this.kargoId;
    data['sevkiyat_durum_id'] = this.sevkiyatDurumId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['eczane_ad'] = this.eczaneAd;
    data['eczane_gln'] = this.eczaneGln;
    if (this.kullanici != null) {
      data['kullanici'] = this.kullanici.toJson();
    }
    if (this.sevkiyatDurum != null) {
      data['sevkiyat_durum'] = this.sevkiyatDurum.toJson();
    }
    return data;
  }
}

class Kullanici {
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

  Kullanici(
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

  Kullanici.fromJson(Map<String, dynamic> json) {
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
    ad = json['ad']?? '' ;
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
