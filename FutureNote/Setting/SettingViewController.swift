//
//  SettingViewController.swift
//  FutureNote
//
//  Created by Other on 15/4/25.
//

import Alamofire
import SnapKit
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class SettingViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var settingTitle: UILabel!
    var cells: [SettingModel] = SettingModel.allCases
    
    private lazy var lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.font = R.font.poppinsMedium(size: 30)
        lbTitle.textColor = .white
        lbTitle.text = LocalizationManager.shared.localizedString(forKey: "setting_tab")
        return lbTitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: lbTitle)
        
        // Đăng ký nib
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell2")

        tableView.dataSource = self
        tableView.delegate = self

        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)

        
        setupNavigationBar()
    }

    override func languageChanged() {
        tabBarController?.tabBar.items?[0].title = LocalizationManager.shared.localizedString(forKey: "home_tab")
        tabBarController?.tabBar.items?[2].title = LocalizationManager.shared.localizedString(forKey: "setting_tab")
        lbTitle.text = LocalizationManager.shared.localizedString(forKey: "setting_tab")
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomTableViewCell

        cell.label?.text = cells[indexPath.row].name
        cell.backgroundColor = UIColor.clear
        cell.label?.textColor = .white
        cell.label.font = R.font.poppinsMedium(size: 16)

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "changeLanguage")
        if indexPath.row == 0 {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
//        callAPI()
    }

//    func callAPI() {
//        let response = AF.request(MyRequest())
//
//        response.response { response in
//            let model = try? JSONDecoder().decode(DataResponseModel.self, from: response.data!)
//            self.settingTitle.text = model?.message
//            print(model?.message)
//        }
//
//        response.resume()
//    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor(hex: "#393535")

        let spacer = UIView()
        spacer.backgroundColor = .clear

        header.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }

        header.addSubview(spacer)
        spacer.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.masksToBounds = true

        // Tính kích thước đúng
        header.layoutIfNeeded()

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 112
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
//        footer.backgroundColor = UIColor(hex: "#393535")
        footer.backgroundColor = UIColor.clear
        let spacer = UIView(frame: CGRect(x: footer.frame.origin.x, y: footer.frame.origin.y, width: tableView.frame.width, height: 18))
        let label = UILabel(frame: CGRect(x: footer.frame.origin.x, y: footer.frame.origin.y + spacer.frame.height, width: tableView.frame.width, height: 25))
        label.text = "Version: 1.0"
        label.textColor = UIColor(hex: "#BB8888")
        label.textAlignment = .center
        footer.addSubview(spacer)
        footer.addSubview(label)
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 43
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

// class MyRequest: URLRequestConvertible {
//    func asURLRequest() throws -> URLRequest {
//        var request = URLRequest(url: URL(string: "https://ip-api.com/json/")!)
//        request.method = .get
//        return request
//    }
//
// }
//
// struct DataResponseModel: Codable {
//    let status, message: String
// }
