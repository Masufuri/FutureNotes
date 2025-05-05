//
//  ChangeLanguage.swift
//  FutureNote
//
//  Created by Other on 19/4/25.
//

import UIKit
import DateTimePicker

enum LanguageModel{
    case vi
    case en
    case ja
    
    var key:String{
        switch self{
        case .vi:
            return "vi"
        case .en:
            return "en"
        case .ja:
            return "ja"
        }
    }
    
    var title:String{
        switch self {
        case .vi:
            return "Việt Nam"
        case .en:
            return "Unitied State"
        case .ja:
            return "Japan"
        }
    }
    var image:UIImage{
        switch self {
        case .vi:
            return UIImage(named: "VietNamFlag")!
        case .en:
            return UIImage(named: "UsFlag")!
        case .ja:
            return UIImage(named: "JapanFlag")!
        }
    }
    
}

class ChangeLanguage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells:[LanguageModel] = [.vi,.en,.ja]
    var selectedIndexPath:IndexPath?
    @IBOutlet var titles:UILabel!
    @IBOutlet var xButton:UIButton!
    
    @IBAction func back(){
        dismiss(animated: true)
    }
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLang = LocalizationManager.shared.currentLanguage
        if let index = cells.firstIndex(where: { model in model.key == currentLang }) {
            selectedIndexPath = IndexPath(row: index, section: 0)
        }
        
        // Đăng ký nib
        let nib = UINib(nibName: "LanguageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cellLanguage")
        
        xButton.tintColor = .white
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
//        print(cells[0].title)
        
        titles.text = LocalizationManager.shared.localizedString(forKey: "chooselanguage")

        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLanguage", for: indexPath) as! LanguageTableViewCell
        
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.view.layer.cornerRadius = 15
        cell.view.layer.masksToBounds = true
        
        cell.languageName.text = cells[indexPath.row].title
        cell.flag.image = cells[indexPath.row].image
        
        
        if indexPath == selectedIndexPath {
            cell.tick.image = UIImage(named: "choosed")
            cell.view.layer.borderColor = UIColor.yellow.cgColor
            cell.view.layer.borderWidth = 1
        } else {
            cell.tick.image = UIImage(named: "notchoose")
            cell.view.layer.borderColor = UIColor.clear.cgColor
            cell.view.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
//        let vc = OtherViewController(nibName: "OtherViewController", bundle: .main)
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func accept(){
        
    }
    
    func selectIndex(indexPath: IndexPath) {
        
    }
    
    @IBAction func switchLanguageTapped() {
        let currentLang = LocalizationManager.shared.currentLanguage
//        let newLang = currentLang == "en" ? "vi" : "en"
        
        guard let selectedIndexPath = selectedIndexPath else {
            return
        }
        let selectedLanguage = cells[selectedIndexPath.row].key
//        let newLang = currentLang == "en" ? "vi" : "en"
        LocalizationManager.shared.currentLanguage = selectedLanguage
        
//        titles.text = LocalizationManager.shared.localizedString(forKey: "chooselanguage")
        
        NotificationCenter.default.post(name: Notification.Name("languageDidChange"), object: nil)
        
        dismiss(animated: true)
        
        // Reload lại giao diện
        // Cách đơn giản: reload root view controller
//        let sceneDelegate = UIApplication.shared.connectedScenes
//            .first?.delegate as? SceneDelegate
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//        sceneDelegate?.window?.rootViewController = vc
    }
}

extension ChangeLanguage: DateTimePickerDelegate {
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        
    }
    
    
}
