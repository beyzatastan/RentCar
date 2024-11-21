//
//  InfosViewController.swift
//  RentCar
//
//  Created by beyza nur on 20.11.2024.
//

import UIKit

class InfosViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    var currentIndex = 0
    var selectedCase: String?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upView.layer.cornerRadius = 20
        view.sendSubviewToBack(mainView)
        updateContent(for: selectedCase)
        navigationItem.hidesBackButton = false

    }
    @IBAction func backButtonClicked(_ sender: Any) {
        let vs = storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(vs, animated: false)
    }
    
    func updateContent(for selectedCase: String?) {
        mainView.subviews.forEach { $0.removeFromSuperview() } // Eski alt görünümleri kaldır
        
        guard let selectedCase = selectedCase else { return }
        
        // ScrollView Oluştur
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(scrollView)

        
        // ScrollView İçin Kısıtlamalar
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: mainView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        // İçerik View Oluştur (ScrollView'ın içine yerleştirilecek tüm öğeleri içerecek)
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // İçerik View İçin Kısıtlamalar
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Scroll yatay değil, dikey çalışacak
        ])
        
        var detailedText: String?
        switch selectedCase {
        case "0":
            labelText.text="Hakkımızda"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            detailedText = """
        EasyLease, araç kiralama deneyiminizi en üst düzeye çıkarmak ve işlemlerinizi kolayca gerçekleştirmenizi sağlamak için tasarlanmış yenilikçi bir mobil uygulamadır. Kullanıcılarımızın ihtiyaçlarını gözeterek, hem kiracıların hem de araç sahiplerinin güvenliğini ve memnuniyetini artırmayı hedefliyoruz.
        
        EasyLease’in en büyük farkı, kiralama sürecini tamamen dijitalleştirerek daha güvenilir ve anlaşmazlıkları önleyici bir altyapı sunmasıdır. Kiralama öncesi ve sonrası araç durumuna ilişkin görseller kaydedilir ve bu görseller kiracı ile araç sahibi arasında olası anlaşmazlıkları çözmek için kullanılır.
        
        Ayrıca uygulama içi puanlama sistemi sayesinde, kullanıcılar birbirini daha iyi değerlendirebilir ve güven dolu bir araç kiralama deneyimi yaşayabilir. EasyLease ile hem kiracılar hem de araç sahipleri için yenilikçi, güvenli ve pratik bir araç kiralama süreci sunuyoruz.
        
        Siz de hemen EasyLease dünyasına katılın, araç kiralamayı kolaylaştırın!
        """
        case "1":
            labelText.text="İletişim"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            detailedText="""
        
        EasyLease İletişim Bilgileri:

        Adres:
        Bandırma Onyedi Eylül Üniversitesi Mühendislik Fakültesi,
        Bandırma / Balıkesir, Türkiye

        Telefon:
        +90 507 143 19 34

        E-posta:
        bbeyzatastan@gmail.com

        
        
        Bizimle iletişime geçmek için yukarıdaki bilgileri kullanabilirsiniz.
        Sorularınızı ve geri bildirimlerinizi bekliyoruz! ☺
        """
        case "2":
            labelText.text="Kullanım Koşulları"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            detailedText="""
        
        Genel Bilgiler Nelerdir ?

        Bu uygulamanın tüm hakları gizlidir.Kullanım koşulları belirtilirken bahsi geçen "Biz" ve "Bizi" kelimeleri ile kast edilen EasyLease ailesi;"Siz" ve "Sizi" kelimeleri ile kast edilen ise uygulamamızı kullanan siz değerli müşterilerimizdir.Kullanım koşulları, uygulamamızı kullanmaya başlamadan önce ziyaret edilmelidir.
        
        EasyLease uygulamasını kullandığınızda aşağıdaki kullanım koşullarını kabul etmiş sayılmaktasınız.

        *******************************************
        
        """
        case "3":
            labelText.text="Uygulama Bilgileri"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            detailedText="""

        Bu uygulamanın tüm hakları gizlidir.Kullanım koşulları belirtilirken bahsi geçen "Biz" ve "Bizi" kelimeleri ile kast edilen EasyLease ailesi;"Siz" ve "Sizi" kelimeleri ile kast edilen ise uygulamamızı kullanan siz değerli müşterilerimizdir.Kullanım koşulları, uygulamamızı kullanmaya başlamadan önce ziyaret edilmelidir.
        
        
        *******************************************
        
        """
        case "4":
            labelText.text="Kullanıcı Bilgileri"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            
            detailedText="""
        
        Uygulamaya giriş yapmadan hesap bilgilerinizi göremezsiniz.
        
        
        """
        case "5":
            labelText.text="Geçmiş Kiralamalar"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            
            detailedText="""
        
        Uygulamaya giriş yapmadan geçmiş kiralamalarınızı göremezsiniz.
        
        
        """
        case "6":
            labelText.text="Ödeme Bilgileri"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            
            detailedText="""
        
        Uygulamaya giriş yapmadan ödeme bilgilerini göremezsiniz.
        
        
        """
           
        case "7":
            labelText.text="Kullanıcı İzinleri"
            labelText.textColor = .white
            labelText.font = UIFont(name: "Gill Sans", size: 26)
            
            
            detailedText="""
        
        KİŞİSEL VERİLERİN TİCARİ ELEKTRONİK İLETİ GÖNDERİMİ FAALİYETLERİNDE İŞLENMESİNE İLİŞKİN AÇIK RIZA FORMU
        
        
        """
        default:
            detailedText="bos"
        }
        let nametextField = UITextField()
        nametextField.placeholder="Adınız Soyadınız"
        nametextField.borderStyle = .none
        nametextField.font = UIFont.systemFont(ofSize: 16)
        nametextField.textColor = .darkGray
        nametextField.backgroundColor = .white
        nametextField.layer.borderColor = UIColor.lightGray.cgColor
        nametextField.layer.borderWidth = 1.0
        nametextField.layer.cornerRadius = 9
        nametextField.layer.shadowColor = UIColor.black.cgColor
        nametextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        nametextField.layer.shadowOpacity = 0.1
        nametextField.layer.shadowRadius = 4
        nametextField.translatesAutoresizingMaskIntoConstraints = false
        
        let detailedLabel = UILabel()
        detailedLabel.text = detailedText
        detailedLabel.numberOfLines = 0 // Çok satırlı yapar
        detailedLabel.lineBreakMode = .byWordWrapping
        detailedLabel.font = UIFont(name: "GillSans-Regular", size: 16)
        detailedLabel.textColor = .black
        detailedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailedLabel)
        
        NSLayoutConstraint.activate([
            detailedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            detailedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),// İçeriğin alt sınırı
            
        ])
    }
}
