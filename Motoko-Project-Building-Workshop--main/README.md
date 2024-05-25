# ICP-HUB Türkiye Project Building Workshop

Bu projede şunları öğreneceksiniz:

- Motoko API fonksiyonlarının kullanımı
- CRUD işlemleri (create, delete, update, read)
- Canister kullanarak HTTP isteği yollama
- Gelen sonuçları işleme
- Veri tiplerini ayarlama
- Trie yapısının kullanımı

## Kurulum
### Windows
- Windows için ilk önce powershell uygulamasını yönetici olarak çalıştırıyoruz
- Sonra terminala aşağıdaki kodları yapıştırıp çalıştırmamız gerekli
```
wsl --install
```
- Burada wsl yüklendikten sonra bilgisayarın yeniden başlatılması gerekebilir
```
 wsl --install -d Ubuntu-22.04
```
```
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
```
- Burada yilk seçeneği seçerek standart kurulum ile devam edebiliriz
<img width="293" alt="Ekran Resmi 2024-05-25 10 32 54" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/d688fd81-035e-47bf-b3f7-d339e815b2e0">

### MacOS - Linux
- MacOS ve  Linux için kurlum çok daha basit
```
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
```
- Bu komutu çalıştırmamız yeterli, ilk seçeneği seçerek standart kurlum yapabilirsiniz

## Proje oluşturma
- Öncelikle projemizi oluşturmak istediğimiz dosya dizinine girmemiz gerekli
- Bunun için terminale aşağıdaki kodu yapıştırıp masaüstüne girebilirsiniz
```
cd Desktop
```
- Sonrasında ise yeni proje oluşturmak için bir kod daha yazmamız yeterli
```
dfx new project_name
```
- Projemiz oluşturulurken bize 3 adet seçenek sunacaktır
- Burada ilk kısımda backand kısmını geliştireceğimiz programlama dilini seçmemiz gerekiyor (Bu proje için Motoko seçmemiz yeterli)
  
<img width="478" alt="Ekran Resmi 2024-05-25 10 37 46" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/da528e14-c594-44f0-9e1a-2224ba27ff54">


- İkinci seçenekte frontend kısmı için hangi framework ve programlama dilini kullanacağımızı seçmemiz gerekiyor
  
<img width="491" alt="Ekran Resmi 2024-05-25 10 37 58" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/5936504b-42c3-4e1d-aa5b-7edf8bb4715d">

- Üçücü seçenekte Internet Identity seçmemiz yeterli olacaktır

<img width="407" alt="Ekran Resmi 2024-05-25 10 38 08" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/498471bc-bd44-4fa7-bc07-2e4ea54a92fc">

- Sonrasında Vscode veya hangi derleyiciyi kullanıyorsanız main.mo dosyasına girip kodlarınızı yazmaya başlayabilirsiniz.

### Projeyi deploy etmek
- VScode da terminalimizi ikiye bölmemiz lazım, bir kısımdan projeyi başlatıp diğer kısımdan deploy edeceğiz.
  
  <img width="1396" alt="Ekran Resmi 2024-05-25 11 05 52" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/cd5c5598-2c96-4539-928d-74788bdc337a">
    - Resimde gördüğünüz gibi terminali ikiye böldüm ilk terminale `dfx start --clean komutunu` yazdım ilk olarak bunu çalıştıracağız
    <img width="1391" alt="Ekran Resmi 2024-05-25 11 06 36" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/ef7c8ce0-5f73-4bfd-8dee-8023151f8f97">

- İlk komutu çalıştırdıktan sonra diğer terminalden `dfx deploy` komutunu çalıştırdığımız zaman projemiz deploy edilecektir
  
  <img width="714" alt="Ekran Resmi 2024-05-25 11 07 16" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/682fe020-899d-4e5a-a7b9-a5b4a9a13f52">

- Sonrasında size verdiği url ile CandidUI aracılığında projenizi test edebilirsiniz
## Fonksiyonlar
### get_coin_compare( )
Bu fonksiyon içine iki adet parametre alır, bunlar bizim coin listemizdeki verilerdir. Bu veri tipleri `Types.mo` dosyasında oluşturulmuştur
- Kullanıcıdan iki adet veri girişi alır
    - `Coin_1` Miktarı öğrenilmek istenen coin
    - `Coin_2'` Coin_1 in hangi coine göre ne kadar değeri olduğu
    - Coin_1 in Coin_2 tipinden değerini döndürür
- `http_request` http isteğimiz için gerekli parametreleri tutan değişken tipidir
- `http_response` http isteğinin geri dönüş değerini tutan değişkenimizdir
- Geriye sepete eklenen işlemin Id bilgisini döndürür
    - `Coin_1` Miktarı öğrenilmek istenen coin
    - `Coin_2'` Coin_1 in hangi coine göre ne kadar değeri olduğu
    - Coin_1 in Coin_2 tipinden değerini döndürür
      
    <img width="913" alt="Ekran Resmi 2024-05-24 15 28 58" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/ea032b6f-efbd-4a3b-93a5-5365f31440cc">

    - Bu örnekte http isteği yapılarak 1 ICP coin kaç TRY sorgusu yapılmıştır


### add_cart()
Bu fonksiyon kullanıcıdan alınan bilgilere göre istenilen miktarda coini istenilen coin tipinde sepete eklememizi sağlar
- Kullanıcıdan üç adet veri girişi ister
    - `addCoin` sepete eklenecek coin
    - `purchase_type` sepete eklenecek coinin satın alınacak coin tipi
    - `purchase_amount` ne kadrlık coin alınacağı
- Kullanıcıdan seçimleri alır sonrasında sepete ekler
- Geriye sepete eklenen işlemin Id bilgisini döndürür
  
  <img width="925" alt="Ekran Resmi 2024-05-24 14 09 25" src="https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/76e42462-ce4b-4c02-852f-5a1e0996ed3a">
 
  - Bu örnekte 120 dolarlık ICP coin sepete ekliyoruz, işlemin Id bilgisi 5 olarak geri döndrülüyor
### read()
Bu fonksiyon aldığı işlem Id'sine göre o işlemin bilgilerini geri döndürür

![Ekran Resmi 2024-05-24 16 49 17](https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/e0b5e36f-43e7-4c0a-822f-366a60b8fc40)

### deleteCart()
Bu fonksiyon aldığı Id bilgisine göre sepetten ürünü siler, geriye Bool veri döndürür
![Ekran Resmi 2024-05-24 16 58 14](https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/525387db-6244-4b95-961d-04783183db46)

### updateCart()
Bu fonksiyon kullanıcıdan alınan Id bilgisine göre sepetteki veriyi yeni girilen veriye göre günceller
- Kullanıcıdan 4 adet veri girişi ister bunlar, yine add_Cart fonksiyonundakilerle aynı olmak üzere ekstradan değiştirilecek Id bilgisini de kullanıcıdan ister
- Geriye Bool veri tipi döndürür
  
![Ekran Resmi 2024-05-24 17 15 01](https://github.com/yusufutkurak/Motoko-Project-Building-Workshop-/assets/107929430/cfe3d926-5787-42a1-982c-e182024d21ac)

### key()
Bu fonksiyon Trie yapımızdaki verileri şifrelemek için kullanılır, key değeri burada üretilir.


## Faydalı Bağlantılar
### `Trie` yapısı için bknz.
- https://internetcomputer.org/docs/current/motoko/main/base/Trie
### `Http` istekleri için bknz.
- https://internetcomputer.org/docs/current/developer-docs/smart-contracts/advanced-features/https-outcalls/https-outcalls-get
- https://internetcomputer.org/docs/current/developer-docs/smart-contracts/advanced-features/https-outcalls/making-http-requests
### Veri tipleri
- https://internetcomputer.org/docs/current/motoko/main/base/Blob
- https://internetcomputer.org/docs/current/motoko/main/base/Nat
- https://internetcomputer.org/docs/current/motoko/main/base/Text
### Cycles
-https://internetcomputer.org/docs/current/motoko/main/canister-maintenance/cycles






