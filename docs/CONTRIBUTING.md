# Katkıda Bulunma Rehberi

YmY OS projesine katkıda bulunmak istediğiniz için teşekkür ederiz! Bu rehber, projeye nasıl katkıda bulunabileceğinizi açıklar.

## 🤝 Katkı Türleri

YmY OS'a birçok farklı şekilde katkıda bulunabilirsiniz:

### 1. Kod Katkıları
- Yeni özellikler ekleme
- Hata düzeltmeleri
- Performans iyileştirmeleri
- Dokümantasyon güncellemeleri

### 2. Tasarım Katkıları
- Logo ve görsel öğeler
- Duvar kağıdı tasarımları
- İkon setleri
- Tema tasarımları

### 3. Dokümantasyon
- Kullanıcı rehberleri
- Kurulum talimatları
- Video eğitimler
- Çeviri çalışmaları

### 4. Test ve Geri Bildirim
- Hata raporları
- Özellik önerileri
- Kullanılabilirlik testi
- Performans testi

## 🚀 Başlangıç

### Gereksinimler

- Git temel bilgisi
- GitHub hesabı
- Fedora tabanlı sistem (build için)
- Temel Linux bilgisi

### Depoyu Forklama ve Klonlama

```bash
# 1. GitHub'da depoyu fork edin
# 2. Fork'unuzu klonlayın
git clone https://github.com/KULLANICI_ADINIZ/ymy-os.git
cd ymy-os

# 3. Upstream remote ekleyin
git remote add upstream https://github.com/yusufbaran11/ymy-os.git
```

## 📝 Katkı Süreci

### 1. Issue Oluşturma veya Seçme

Değişiklik yapmadan önce:

- Yapacağınız değişiklik için bir issue olup olmadığını kontrol edin
- Yoksa yeni bir issue açın ve ne yapmak istediğinizi açıklayın
- Issue'nun atanmasını bekleyin veya isteyin

### 2. Branch Oluşturma

```bash
# Upstream'den güncellemeleri çekin
git fetch upstream
git checkout main
git merge upstream/main

# Yeni bir branch oluşturun
git checkout -b feature/yeni-ozellik
# veya
git checkout -b fix/hata-duzeltmesi
```

Branch isimlendirme kuralları:
- `feature/` - Yeni özellikler için
- `fix/` - Hata düzeltmeleri için
- `docs/` - Dokümantasyon güncellemeleri için
- `design/` - Tasarım değişiklikleri için

### 3. Değişikliklerinizi Yapın

```bash
# Dosyalarınızı düzenleyin
# Test edin
# Commit edin

git add .
git commit -m "feat: yeni özellik açıklaması"
```

Commit mesajı formatı:
```
<tip>: <kısa açıklama>

<detaylı açıklama (opsiyonel)>

<issue referansı (varsa)>
```

Commit tipleri:
- `feat:` - Yeni özellik
- `fix:` - Hata düzeltmesi
- `docs:` - Dokümantasyon
- `style:` - Kod formatı
- `refactor:` - Kod yeniden yapılandırma
- `test:` - Test ekleme/düzeltme
- `chore:` - Genel bakım işleri

### 4. Pull Request Oluşturma

```bash
# Branch'inizi push edin
git push origin feature/yeni-ozellik
```

GitHub'da:
1. Repository'nize gidin
2. "Pull Request" oluşturun
3. Şablonu doldurun:
   - Değişikliğin açıklaması
   - İlgili issue numarası
   - Test sonuçları
   - Ekran görüntüleri (varsa)

## 📋 Pull Request Kontrol Listesi

Pull Request göndermeden önce kontrol edin:

- [ ] Kod, mevcut stil rehberine uyuyor
- [ ] Commit mesajları kurallara uygun
- [ ] Değişiklikler test edildi
- [ ] Dokümantasyon güncellendi (gerekirse)
- [ ] Conflict yok
- [ ] Issue referansı eklendi

## 🎨 Duvar Kağıdı Yarışması Katılımı

Duvar kağıdı yarışmasına katılmak için:

1. Tasarımınızı oluşturun (min. 3840x2160)
2. GitHub'da yeni bir issue açın
3. Başlık: "Duvar Kağıdı Yarışması: [Tasarım Adı]"
4. Tasarımınızın önizlemesini ve indirme linkini ekleyin
5. Kısa bir açıklama ekleyin

## 🐛 Hata Raporlama

İyi bir hata raporu içermelidir:

### Gerekli Bilgiler
- YmY OS versiyonu
- Donanım bilgileri
- Hatanın açık açıklaması
- Hatayı yeniden üretme adımları
- Beklenen davranış
- Gerçek davranış
- Log dosyaları (varsa)

### Örnek Hata Raporu

```markdown
**YmY OS Versiyonu:** 43 Beta
**Donanım:** Intel i5-10400, 16GB RAM

**Sorun:**
Sistem güncellemesi sırasında uygulama çöküyor.

**Yeniden Üretme Adımları:**
1. Yazılım Merkezi'ni aç
2. "Güncelle" butonuna tıkla
3. 5. güncellemede çökme gerçekleşiyor

**Beklenen:** Güncellemeler sorunsuz tamamlanmalı
**Gerçek:** Uygulama yanıt vermiyor hale geliyor

**Log:**
[log dosyası ektedir]
```

## 💡 Özellik Önerisi

Yeni özellik önerirken:

1. Özelliğin amacını açıklayın
2. Kullanım senaryoları belirtin
3. Mümkünse mockup/örnek ekleyin
4. Benzer özelliklerin araştırmasını yapın

## 🔍 Code Review Süreci

Pull Request'iniz:

1. **Otomatik Kontroller**: CI/CD testleri çalışır
2. **Manuel İnceleme**: Maintainer'lar kodu inceler
3. **Tartışma**: Geri bildirim ve öneriler
4. **Düzeltmeler**: Gerekirse değişiklikler yapın
5. **Onay**: Merge edilir

## 🎯 Geliştirme Standartları

### Kod Stili
- Bash scriptler için: ShellCheck kurallarına uyun
- Python için: PEP 8 standardı
- 4 boşluk girinti (tab değil)
- Anlamlı değişken isimleri

### Kickstart Dosyaları
- Yorumlar ekleyin
- Paket gruplarını organize edin
- Test edilmiş paketler kullanın

### Dokümantasyon
- Markdown formatı
- Açık ve net dil
- Örnekler ekleyin
- Güncel tutun

## 🏗️ Build Test Etme

Değişikliklerinizi test etmek için:

```bash
# Manuel build
sudo ./build.sh

# ISO'yu sanal makinede test edin
# VirtualBox veya QEMU kullanabilirsiniz
```

## 📞 İletişim

Sorularınız için:

- **GitHub Issues**: Teknik sorular ve hatalar
- **GitHub Discussions**: Genel tartışmalar
- **Pull Request Yorumları**: Kod hakkında sorular

## 🙏 Teşekkürler

Her katkı değerlidir! Küçük bir yazım hatası düzeltmesinden büyük özellik eklemelerine kadar her şey YmY OS'u daha iyi yapar.

## 📜 Lisans

Katkıda bulunarak, katkılarınızın projenin MIT lisansı altında lisanslanmasını kabul edersiniz.

---

**YmY Studios** - Birlikte daha iyisini inşa ediyoruz 🚀
