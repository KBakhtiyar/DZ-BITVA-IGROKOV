//  ViewController.swift
//  DZ IGRA BITVA
//  Created by BK on 17.03.2024.

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var characters = [Character]()
    var currentPlayerIndex = 0
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "NAME PLAYER "
        textField.textColor = .white
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()
    
    let namesLabel: UILabel = {
        let label = UILabel()
        label.text = "PLAYER:"
        label.backgroundColor = .systemYellow
        return label
    }()
    
    let eventLabel: UILabel = {
        let label = UILabel()
        label.text = "ACTION:"
        label.backgroundColor = .systemYellow
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("PLAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemMint
        view.addSubview(nameTextField)
        view.addSubview(addButton)
        view.addSubview(namesLabel)
        view.addSubview(eventLabel)
        view.addSubview(actionButton)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(300)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        namesLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.height.equalTo(80)
        }
        eventLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(namesLabel.snp.bottom).offset(50)
            make.height.equalTo(250)
        }
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        addButton.addTarget(self, action: #selector(addCharacter), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }
    
    @objc func addCharacter() {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        let health = Int.random(in: 100...300)
        let damage = Int.random(in: 20...40)
        let character = Character(name: name, health: health, damage: damage)
        characters.append(character)
        
        updateNamesLabel()
    }
    
    @objc func performAction() {
        guard characters.count >= 2 else {
            eventLabel.text = "Недостаточно персонажей."
            return
        }
        let attacker = characters[currentPlayerIndex]
        let targetIndex = (currentPlayerIndex + 1) % characters.count
        let target = characters[targetIndex]
        
        let eventDescription = attacker.attack(target: target)
        eventLabel.text = eventDescription
        
        if target.health <= 0 {
            eventLabel.text = "GAME OVER. \(target.name) died."
        }
        
        currentPlayerIndex = (currentPlayerIndex + 1) % characters.count
    }
    
    func updateNamesLabel() {
        var names = ""
        for character in characters {
            names += "\(character.name), "
        }
        namesLabel.text = "Name player: \(names)"
    }
}

