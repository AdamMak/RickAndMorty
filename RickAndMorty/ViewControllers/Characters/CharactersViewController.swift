//  
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Combine

protocol CharactersViewControllerDelegate: class {
    func didSelect(character: Character)
}

class CharactersViewController: UIViewController {
    @IBOutlet private(set) weak var tableView: UITableView!

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: CharactersViewModel
    private lazy var dataSource = makeDataSource()

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: CharactersViewController.identifier, bundle: nil)
    }

    deinit {
        cancellables.removeAll()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.backgroundColor

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setUpTableView()

        fetchCharacters()
    }

    private func fetchCharacters() {
        viewModel.fetchCharacters()

        viewModel.$cellViewModels
            .sinkMain(receiveValue: { [weak self] cellViewModel in
                var snapshot = NSDiffableDataSourceSnapshot<CharactersTableViewCell, CharactersTableCellViewModel>()
                snapshot.appendSections([CharactersTableViewCell()])
                snapshot.appendItems(cellViewModel)
                self?.dataSource.apply(snapshot, animatingDifferences: false)
            }).store(in: &cancellables)

        
        viewModel.$errors
        .sinkMain(receiveValue: { [weak self] error in
            guard error != nil else {
                return
            }

            self?.showErrorAlert()
        }).store(in: &cancellables)
    }

    private func showErrorAlert() {
        showAlertController(title: "Error", message: "Error fetching characters", actionText: "Try Again", action: { [weak self] in
            self?.viewModel.fetchCharacters()
        })
    }

    private func makeDataSource() -> UITableViewDiffableDataSource<CharactersTableViewCell, CharactersTableCellViewModel> {
        return UITableViewDiffableDataSource<CharactersTableViewCell, CharactersTableCellViewModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, cellViewModel -> CharactersTableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier) as? CharactersTableViewCell
                cell?.configure(with: cellViewModel)
                cell?.selectionStyle = .none
                cell?.accessoryType = .disclosureIndicator
                return cell
        })
    }

    private func setUpTableView() {
        tableView.registerCustomCell(cell: CharactersTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.cellViewModels.count-1
    }
}

// MARK: UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.getCharacter(for: indexPath.row)
        viewModel.didSelect(character: character)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

// MARK: UITableViewDataSourcePrefetching

extension CharactersViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell(for:)) {
            viewModel.fetchCharacters()
        }
    }
}
