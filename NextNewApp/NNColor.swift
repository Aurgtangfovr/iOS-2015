//
//  NNColor.swift
//  NextNewApp
//
//  Created by Пользователь on 17.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit
import CoreData

@objc(NNColor)
class NNColor: NSManagedObject {
    // соответствие с моделью
    @NSManaged var name : String?
    @NSManaged private var colorData : NSData?
    // перевод из BLOB (colorData) в нужный тип
    var color : UIColor? {
        get {
            return NSKeyedUnarchiver.unarchiveObjectWithData(colorData!) as? UIColor
        }
        set(newColor) {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(newColor!)
        }
    }
    
    // ссылка на описание в контексте
    class var entity: NSEntityDescription {
        return NSEntityDescription.entityForName("NNColor", inManagedObjectContext: CoreDataHelper.instance.context)!
    }
    
    // коструктор, с ссылкой на объект в контексте
    convenience init(name: String, color: UIColor) {
        self.init(entity: NNColor.entity,
            insertIntoManagedObjectContext: CoreDataHelper.instance.context)
        self.name = name
        self.color = color
    }
    
    // получение инверсного цвета
    var invertColor: UIColor {
        get{
            var hue:CGFloat = 0.0
            var sat:CGFloat = 0.0
            var brt:CGFloat = 0.0
            var alf:CGFloat = 0.0
            color?.getHue(&hue, saturation: &sat, brightness: &brt, alpha: &alf)
            return UIColor(hue: abs(1-hue), saturation: sat, brightness: abs(1-brt), alpha: alf)
        }
    }
    
    // словарь цветов
    class func fetchColors() -> [NNColor]{
        let fetchRequest = NSFetchRequest(entityName: "NNColor")
        let results = CoreDataHelper.instance.context.executeFetchRequest(fetchRequest, error: nil) as! [NNColor]

        return results
        //return results as! [NNColor]
    }
    
}
