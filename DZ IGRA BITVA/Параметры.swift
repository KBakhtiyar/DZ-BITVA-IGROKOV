//  DZ IGRA BITVA
//  Created by BK on 23.03.2024.

class Character {
    let name: String
    var health: Int
    let damage: Int
    
    init(name: String, health: Int, damage: Int) {
        self.name = name
        self.health = health
        self.damage = damage
    }
    
    func attack(target: Character) -> String {
        target.health -= self.damage
        if target.health <= 0 {
            return "\(self.name) attacked \(target.name) and win!"
        } else {
            return "\(self.name) attacked \(target.name), a \(target.name) left \(target.health) health."
        }
    }
}
