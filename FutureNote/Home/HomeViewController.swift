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

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    // empty view
    @IBOutlet var picCreateFirstNote: UIImageView!
    @IBOutlet var createFirstNote: UILabel!

    @IBOutlet var tableView: UITableView!

    var cells: [Model] = [
        Model(titleCell: "alo", createAt: "8/3/2025", content: "hello"),
        Model(titleCell: "cell 2", createAt: "23/3/2025", content: "this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content this is content "),
    ]

    private lazy var lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.font = R.font.poppinsMedium(size: 30)
        lbTitle.textColor = .white
        lbTitle.text = LocalizationManager.shared.localizedString(forKey: "home_title")
        return lbTitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: lbTitle)

        setupTableView()
        setupTabbar()
        setupEmptyView()
        setupNavigationBar()
        setupObserver()

        let tabbarVC = tabBarController?.viewControllers?[1] as? AddNoteViewController
        tabbarVC?.delegate = self
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(actionAdd(_:)), name: .init(rawValue: "ADD_NOTE"), object: nil)
    }
    
    @objc private func actionAdd(_ noti: Notification) {
        guard let object = noti.object as? Model else {
            return
        }
        cells.insert(object, at: 0)
        tableView.reloadData()
        tabBarController?.selectedIndex = 0
    }

    private func setupEmptyView() {
        createFirstNote.text = LocalizationManager.shared.localizedString(forKey: "create_first_note")

        if cells.count != 0 {
            picCreateFirstNote.isHidden = true
            createFirstNote.isHidden = true
        } else {
            picCreateFirstNote.isHidden = false
            createFirstNote.isHidden = false
        }
    }

    private func setupTabbar() {
        tabBarController?.tabBar.items?[0].title = LocalizationManager.shared.localizedString(forKey: "home_tab")
        tabBarController?.tabBar.items?[2].title = LocalizationManager.shared.localizedString(forKey: "setting_tab")
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // số ước lượng, không quan trọng lắm

        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)

        // Dang ky nib
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "homecell")

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func languageChanged() {
        createFirstNote.text = LocalizationManager.shared.localizedString(forKey: "create_first_note")
        lbTitle.text = LocalizationManager.shared.localizedString(forKey: "home_title")
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
        let editNote = UIStoryboard(name: "AddNote", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        editNote.indexpath = indexPath
        editNote.delegate = self
        tabBarController?.navigationItem.backButtonTitle = ""
        tabBarController?.navigationController?.pushViewController(editNote, animated: true)
    }
}

extension HomeViewController: DataDelegate {
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
}
