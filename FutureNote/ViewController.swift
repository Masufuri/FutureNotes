//
//  ViewController.swift
//  FutureNote
//
//  Created by Other on 13/4/25.
//

import UIKit

class Model {
    var titleCell: String
    var createAt: String
    var content: String
    init(titleCell: String, createAt: String, content: String) {
        self.titleCell = titleCell
        self.createAt = createAt
        self.content = content
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,DataDelegate {
        
    var cells: [Model] = [
        Model(titleCell: "alo", createAt: "8/3/2025", content: "hello"),
        Model(titleCell: "cell 2", createAt: "23/3/2025", content: "this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content "),
    ]

    @IBOutlet var picCreateFirstNote: UIImageView!
    @IBOutlet var createFirstNote: UILabel!
    @IBOutlet var hometitle: UILabel!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // số ước lượng, không quan trọng lắm


        tabBarController?.tabBar.items?[0].title = LocalizationManager.shared.localizedString(forKey: "home_tab")
        tabBarController?.tabBar.items?[2].title = LocalizationManager.shared.localizedString(forKey: "setting_tab")
        createFirstNote.text = LocalizationManager.shared.localizedString(forKey: "create_first_note")
        hometitle.text = LocalizationManager.shared.localizedString(forKey: "home_title")

        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: Notification.Name("languageDidChange"), object: nil)

        // Dang ky nib
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "homecell")

        if cells.count != 0 {
            picCreateFirstNote.isHidden = true
            createFirstNote.isHidden = true
        } else {
            picCreateFirstNote.isHidden = false
            createFirstNote.isHidden = false
        }

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let addnote = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
//        addnote.delegate = self
        let tabbarVC = tabBarController?.viewControllers?[1] as? AddNoteViewController
        tabbarVC?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func getDataOfACell(at indexpath: IndexPath) -> Model {
        return cells[indexpath.row]
    }
    
    func receiveData(data: Model) {
        cells.append(data)
        tableView.reloadData()
    }
    
    func edit(at indexpath: IndexPath, model: Model) {
        cells[indexpath.row] = model
        tableView.reloadData()
    }

    @objc func languageChanged() {
        createFirstNote.text = LocalizationManager.shared.localizedString(forKey: "create_first_note")
        hometitle.text = LocalizationManager.shared.localizedString(forKey: "home_title")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell
        cell.labelTitle.text = cells[indexPath.row].titleCell
        cell.labelCreateAt.text = cells[indexPath.row].createAt
        cell.labelContent.text = cells[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editNote = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        editNote.indexpath = indexPath
        editNote.delegate = self
        present(editNote, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 141
//    }
}
