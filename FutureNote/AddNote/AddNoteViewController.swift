//
//  AddNoteViewController.swift
//  FutureNote
//
//  Created by Other on 24/4/25.
//

import Alamofire
import DateTimePicker
import UIKit

protocol DataDelegate: AnyObject {
    func receiveData(data: Model)
    func getDataOfACell(at indexpath: IndexPath) -> Model
    func edit(at indexpath: IndexPath, model: Model)
}

class AddNoteViewController: BaseViewController {
    @IBOutlet var textView: UITextView!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var buttonDateTime: UIButton!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tvDescription: UITextView!
    var indexpath: IndexPath?

    @IBAction func clickOnButtonDateTime() {
        dateTimePicker()
    }

    var delegate: DataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
//        var today:Date = Date()
//        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        var dateString = dateFormatter.string(from: today)
//        buttonDateTime.setTitle(dateString, for: .normal)
        buttonSave.layer.cornerRadius = 10
        buttonSave.layer.masksToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor

        setupTitle()

        buttonSave.titleLabel?.text = LocalizationManager.shared.localizedString(forKey: "buttonSaveNote")
        labelDate.text = LocalizationManager.shared.localizedString(forKey: "labelDateTime")
        labelTitle.text = LocalizationManager.shared.localizedString(forKey: "labelTitle")
        labelDescription.text = LocalizationManager.shared.localizedString(forKey: "labelDescription")

        showDateOnButton()

        let originalImage = UIImage(systemName: "plus.circle.fill")!
        let reSize = resizeImage(image: originalImage, targetSize: CGSize(width: 30, height: 30))
        tabBarItem.image = reSize.withRenderingMode(.alwaysOriginal)

        if let indexpath = indexpath, let model = delegate?.getDataOfACell(at: indexpath) {
            navigationItem.title = R.string(bundle: LocalizationManager.shared.bundle).localizable.edit_screen()
            buttonDateTime.setTitle(model.createAt, for: .normal)
            tfTitle.text = model.titleCell
            textView.text = model.content
        } else {
            navigationItem.title = R.string(bundle: LocalizationManager.shared.bundle).localizable.new_screen()
        }

        // Do any additional setup after loading the view.
    }

    func setupTitle() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = LocalizationManager.shared.localizedString(forKey: "new_screen")
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: R.font.poppinsMedium(size: 26),
        ]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func languageChanged() {
        navigationItem.title = LocalizationManager.shared.localizedString(forKey: "new_screen")
        buttonSave.titleLabel?.text = LocalizationManager.shared.localizedString(forKey: "buttonSaveNote")
        labelDate.text = LocalizationManager.shared.localizedString(forKey: "labelDateTime")
        labelTitle.text = LocalizationManager.shared.localizedString(forKey: "labelTitle")
        labelDescription.text = LocalizationManager.shared.localizedString(forKey: "labelDescription")
    }

    func showDateOnButton() {
        let today: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: today)
        buttonDateTime.setTitle(dateString, for: .normal)
    }

    @IBAction func addDate() {
        let today = buttonDateTime.titleLabel!.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var convertToDate = dateFormatter.date(from: today!)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: convertToDate!)
        let dateString = dateFormatter.string(from: tomorrow!)
        buttonDateTime.setTitle(dateString, for: .normal)
    }

    @IBAction func preDate() {
        let today = buttonDateTime.titleLabel!.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var convertToDate = dateFormatter.date(from: today!)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: convertToDate!)
        let dateString = dateFormatter.string(from: yesterday!)
        buttonDateTime.setTitle(dateString, for: .normal)
    }

    func dateTimePicker() {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        view.addSubview(picker)
    }

    @IBAction func save() {
        guard let title = tfTitle.text, let dateTime = buttonDateTime.titleLabel?.text, let description = tvDescription.text else {
            return
        }
        let model: Model = Model(titleCell: title, createAt: dateTime, content: description)
        if let indexpath = indexpath {
            delegate?.edit(at: indexpath, model: model)
        } else {
            NotificationCenter.default.post(name: .init(rawValue: "ADD_NOTE"), object: model)
        }
        navigationController?.popViewController(animated: true)
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

//    func callAPI() {
//        let response = AF.request(MyRequest())
//
//        response.response { response in
//            let model = try? JSONDecoder().decode(DataResponseModel.self, from: response.data!)
    ////            self.settingTitle.text = model?.message
//            print(model?.message)
//        }
//
//        response.resume()
//    }

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
