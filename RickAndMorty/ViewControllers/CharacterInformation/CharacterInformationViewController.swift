//  
//  CharacterInformationViewController.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit


class CharacterInformationViewController: UIViewController {
    @IBOutlet private(set) var backgroundView: UIView!
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet private(set) var idLabel: UILabel!
    @IBOutlet private(set) var statusTitleLabel: UILabel!
    @IBOutlet private(set) var statusLabel: UILabel!
    @IBOutlet private(set) var genderTitleLabel: UILabel!
    @IBOutlet private(set) var genderLabel: UILabel!
    @IBOutlet private(set) var speciesTitleLabel: UILabel!
    @IBOutlet private(set) var speciesLabel: UILabel!
    @IBOutlet private(set) var originTitleLabel: UILabel!
    @IBOutlet private(set) var originLabel: UILabel!
    @IBOutlet private(set) var lastLocationTitleLabel: UILabel!
    @IBOutlet private(set) var lastLocationLabel: UILabel!
    @IBOutlet private(set) var imageView: UIImageView!

    private let viewModel: CharacterInformationViewModel

    init(viewModel: CharacterInformationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: CharacterInformationViewController.identifier, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.backgroundColor
        setUpImageView()
        setUpLabels()
        setUpBackgroundView()
    }

    private func setUpImageView() {
        imageView.cacheImage(urlString: viewModel.imageURL)
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setUpBackgroundView() {
        backgroundView.backgroundColor = AppColors.gray
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    private func setUpLabels() {
        nameLabel.text = viewModel.name
        idLabel.text = viewModel.id

        setUpStatusLabels()
        setUpSpeciesLabels()
        setUpGenderLabels()
        setUpOriginLabels()
        setUpLocationLabels()
    }

    private func setUpStatusLabels() {
        statusTitleLabel.textColor = AppColors.fadedWhite
        statusLabel.text = viewModel.status
        statusLabel.textColor = AppColors.orange
    }

    private func setUpSpeciesLabels() {
        speciesTitleLabel.textColor = AppColors.fadedWhite
        speciesLabel.text = viewModel.species
        speciesLabel.textColor = AppColors.orange
    }

    private func setUpGenderLabels() {
        genderTitleLabel.textColor = AppColors.fadedWhite
        genderLabel.text = viewModel.gender
        genderLabel.textColor = AppColors.orange
    }

    private func setUpOriginLabels() {
        originTitleLabel.textColor = AppColors.fadedWhite
        originLabel.text = viewModel.origin
        originLabel.textColor = AppColors.orange
    }

    private func setUpLocationLabels() {
        lastLocationTitleLabel.textColor = AppColors.fadedWhite
        lastLocationLabel.text = viewModel.location
        lastLocationLabel.textColor = AppColors.orange
    }
}
