//
//  MyRecipesViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 05/05/25.
//

import UIKit

final class MyRecipesViewController: UIViewController {
    let contentView: MyRecipesView
    weak var delegate: (any MyRecipesFlowDelegate)?
    let viewModel = MyRecipesViewModel()
    
    private var medicines: [Medicine] = []
    
    init(contentView: MyRecipesView,
         delegate: any MyRecipesFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        medicines = viewModel.fetchData()
    }
    
    private func setup() {
        view.addSubview(contentView)
        view.backgroundColor = ColorsConstants.gray800
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(RemedyTableViewCell.self, forCellReuseIdentifier: RemedyTableViewCell.identifier)
        contentView.tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - UITableViewDelegate
extension MyRecipesViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        medicines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
}

// MARK: - UITableViewDataSource
extension MyRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RemedyTableViewCell.identifier,
                                                       for: indexPath) as? RemedyTableViewCell
        else { return UITableViewCell() }
        let recipe = medicines[indexPath.section]
        cell.configure(title: recipe.title, time: recipe.time, recurrence: recipe.recurrence)
        cell.selectionStyle = .none
        cell.onDelete = { [weak self] in
            if let self {
                self.viewModel.deleteRecipeById(recipe.id)
                self.medicines.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section),
                                         with: .fade)
            }
        }
        
        return cell
    }
}
