//
//  ViewController.swift
//  NextNewApp
//
//  Created by Пользователь on 15.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit

enum ColorViewMode {
    case Add, Edit
}

class ViewController: UIViewController {
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    @IBOutlet weak var sliderHue: UISlider!
    @IBOutlet weak var sliderSat: UISlider!
    @IBOutlet weak var sliderBrit: UISlider!
    
    var mode: ColorViewMode?
    var editedColor: NNColor?
    
    @IBOutlet weak var compliment3: ColorView!
    @IBOutlet weak var compliment2: ColorView!
    @IBOutlet weak var compliment1: ColorView!
    var distance : CGFloat = 0.4
    @IBOutlet weak var sliderComplimentDist: UISlider!
    
    
    weak var delegate: ColorTablePalette?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        switch (mode!){
        case .Edit:
            text1.text = editedColor?.name
            view.backgroundColor = editedColor?.color
        default:
            break
        }
        compliment1.orientation = .South
                compliment2.orientation = .East
                compliment3.orientation = .West
        setSliders()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSliders(){
        var hue:CGFloat = 0.0
        var sat:CGFloat = 0.0
        var brt:CGFloat = 0.0
        var alfa:CGFloat = 0.0
        view.backgroundColor!.getHue(&hue, saturation: &sat, brightness: &brt, alpha: &alfa)
        sliderHue.value = Float(hue)
        sliderSat.value = Float(sat)
        sliderBrit.value = Float(brt)
        sliderComplimentDist.value = Float(distance)
        updateColors(hue, saturation: sat, brightness: brt, alpha: alfa)
    }

    @IBAction func slidHue(sender: UISlider) {
        let val = sender.value
        let tag = sender.tag

        var hue = CGFloat(sliderHue.value)
        var sat = CGFloat(sliderSat.value)
        var brt = CGFloat(sliderBrit.value)
        
        view.backgroundColor = UIColor(hue: hue, saturation: sat, brightness: brt, alpha: 1.0)
        updateColors(hue, saturation: sat, brightness: brt, alpha: 1)
    }
    
    @IBAction func distanceValueChanged(sender: UISlider) {
        distance = CGFloat(sender.value)
        var hue = CGFloat(sliderHue.value)
        var sat = CGFloat(sliderSat.value)
        var brt = CGFloat(sliderBrit.value)
        updateColors(hue, saturation: sat, brightness: brt, alpha: 1)
    }
    
    func updateColors(hue: CGFloat, saturation: CGFloat, brightness:CGFloat, alpha: CGFloat) {
        
        let inverseColor = UIColor(hue: abs(1-hue), saturation: saturation, brightness: abs(1-brightness), alpha: alpha)
        
        confirm.setTitleColor( inverseColor, forState: .Normal)
        cancel.setTitleColor( inverseColor, forState: .Normal)
        
        sliderHue.tintColor = inverseColor
        sliderSat.tintColor = inverseColor
        sliderBrit.tintColor = inverseColor
        sliderComplimentDist.tintColor = inverseColor
        
        compliment1.fill = UIColor(hue: abs(0.5-hue), saturation: saturation, brightness: brightness, alpha: alpha)
        compliment2.fill = UIColor(hue: abs(hue-distance), saturation: saturation, brightness: brightness, alpha: alpha)
        compliment3.fill = UIColor(hue: (hue+distance > 1) ? hue+distance-1: hue+distance, saturation: saturation, brightness: brightness, alpha: alpha)
        
    }
    
    @IBAction func tapCompliment(sender: ColorView) {
        let backColor = view.backgroundColor!
        view.backgroundColor = sender.fill
        sender.fill = backColor
        setSliders()
    }
    
    @IBAction func tapTrash(sender: UIButton) {
        delegate!.cancel()
    }
    
    @IBAction func tapSave(sender: UIButton) {
        switch (mode!) {
        case .Add:
            if shouldAddColor() {
                delegate!.addColor(view.backgroundColor!, withName: text1.text)
            }
        case .Edit:
            delegate!.editColor(view.backgroundColor!, withName: text1.text)
        default:
            break
        }
    }
    
    func shouldAddColor() -> Bool {
    
            if text1.text.isEmpty {
                let alert = UIAlertView()
                alert.title = "Введите название цвета"
                //alert.message = ""
                alert.addButtonWithTitle("Ok")
                alert.show()
        
                return false
            }
            else {
               if (delegate!.existingColor(text1.text)) {
                    
                    let alert = UIAlertView()
                    alert.title = "Цвет уже существует"
                    alert.message = "Введите другое имя цвета"
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                    return false
                }
                return true
            }
    }
}

