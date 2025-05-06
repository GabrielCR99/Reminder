//
//  RemedyTableViewCell.swift
//  Reminder
//
//  Created by Gabriel Roveri on 05/05/25.
//

import UIKit

final class RemedyTableViewCell: UITableViewCell {
    static let identifier = "RemedyTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.subHeading
        label.textColor = ColorsConstants.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let timeBackgroudView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray500
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.tag
        label.textColor = ColorsConstants.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let recurrenceBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray500
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let recurrenceLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.tag
        label.textColor = ColorsConstants.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let watchIcon: UIImageView = {
        let imageView = UIImageView(image: .init(named: "Clock"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private let recurrenceIcon: UIImageView = {
        let imageView = UIImageView(image: .init(named: "Repeat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private let trashIconButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.init(named: "Trash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = ColorsConstants.gray700
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.addSubviews(titleLabel, timeBackgroudView, recurrenceBackgroundView, trashIconButton)
        timeBackgroudView.addSubviews(watchIcon, timeLabel)
        recurrenceBackgroundView.addSubviews(recurrenceIcon, recurrenceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MetricsConstants.medium),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MetricsConstants.medium),
            
            timeBackgroudView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MetricsConstants.small),
            timeBackgroudView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MetricsConstants.medium),
            timeBackgroudView.heightAnchor.constraint(equalToConstant: 28),
            
            watchIcon.leadingAnchor.constraint(equalTo: timeBackgroudView.leadingAnchor, constant: MetricsConstants.small),
            watchIcon.centerYAnchor.constraint(equalTo: timeBackgroudView.centerYAnchor),
            watchIcon.heightAnchor.constraint(equalToConstant: 16),
            watchIcon.widthAnchor.constraint(equalToConstant: 16),
            
            timeLabel.leadingAnchor.constraint(equalTo: watchIcon.trailingAnchor, constant: MetricsConstants.tiny),
            timeLabel.centerYAnchor.constraint(equalTo: timeBackgroudView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: timeBackgroudView.trailingAnchor, constant: -MetricsConstants.small),
            
            recurrenceBackgroundView.centerYAnchor.constraint(equalTo: timeBackgroudView.centerYAnchor),
            recurrenceBackgroundView.leadingAnchor.constraint(equalTo: timeBackgroudView.trailingAnchor, constant: MetricsConstants.tiny),
            recurrenceBackgroundView.heightAnchor.constraint(equalToConstant: 28),
            
            recurrenceIcon.leadingAnchor.constraint(equalTo: recurrenceBackgroundView.leadingAnchor, constant: MetricsConstants.small),
            recurrenceIcon.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
            recurrenceIcon.heightAnchor.constraint(equalToConstant: 16),
            recurrenceIcon.widthAnchor.constraint(equalToConstant: 16),
            
            recurrenceLabel.leadingAnchor.constraint(equalTo: recurrenceIcon.trailingAnchor, constant: MetricsConstants.tiny),
            recurrenceLabel.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
            recurrenceLabel.trailingAnchor.constraint(equalTo: recurrenceBackgroundView.trailingAnchor, constant: -MetricsConstants.small),
            
            trashIconButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MetricsConstants.medium),
            trashIconButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            trashIconButton.heightAnchor.constraint(equalToConstant: 16),
            trashIconButton.widthAnchor.constraint(equalToConstant: 16),
            
            contentView.bottomAnchor.constraint(equalTo: timeBackgroudView.bottomAnchor, constant: MetricsConstants.medium),
        ])
    }
    
    func configure(title: String, time: String, recurrence: String) {
        titleLabel.text = title
        timeLabel.text = time
        recurrenceLabel.text = recurrence
    }
}
