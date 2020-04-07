//
//  PlayerSelect.swift
//  Fist score card
//
//  Created by Jay Miller on 4/5/20.
//  Copyright © 2020 Jay Miller. All rights reserved.
//

import UIKit

class PlayerSelect: UIViewController {

    
    
    @IBOutlet weak var playerSelect4: UIButton!
    @IBOutlet weak var playerSelect6: UIButton!
    @IBOutlet weak var playerSelect8: UIButton!
    @IBOutlet weak var playerSelect10: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerSelect4.clipsToBounds = true
        playerSelect6.clipsToBounds = true
        playerSelect8.clipsToBounds = true
        playerSelect10.clipsToBounds = true
        
        playerSelect4.layer.cornerRadius = 5
        playerSelect6.layer.cornerRadius = 5
        playerSelect8.layer.cornerRadius = 5
        playerSelect10.layer.cornerRadius = 5
        
        self.navigationController?.navigationBar.isHidden = true

        
        // Do any additional setup after loading the view.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? bidPage{
            let button = sender as! UIButton
            destination.playerCount = button.tag
        }
        
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
