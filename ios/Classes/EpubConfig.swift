import UIKit
import FolioReaderKit
import RealmSwift


class EpubConfig: NSObject {
    
    open var config: FolioReaderConfig!
    
    open var tintColor: UIColor = UIColor.init(rgba:"#fdd82c")
    open var allowSharing: Bool = false
    open var scrollDirection: FolioReaderScrollDirection = FolioReaderScrollDirection.vertical
    
    init(Identifier: String,tintColor: String, allowSharing: Bool,
            scrollDirection: String,setShowRemainingIndicator:Bool, enableTts: Bool, nightMode: Bool) {
        self.config = FolioReaderConfig()
        self.tintColor = UIColor.init(rgba: tintColor)
        self.allowSharing = allowSharing
        self.config.canChangeScrollDirection = false
        if scrollDirection == "vertical"{
            self.config.scrollDirection = FolioReaderScrollDirection.vertical
        }else if (scrollDirection == "horizontal"){
            self.config.scrollDirection = FolioReaderScrollDirection.horizontal
        }else{
            self.config.canChangeScrollDirection = true
        }
        self.config.enableTTS = enableTts
        self.config.hidePageIndicator = setShowRemainingIndicator
        super.init()
        self.readerConfiguration()
    }
    
    private func readerConfiguration() {
        self.config.shouldHideNavigationOnTap = false
        self.config.scrollDirection = self.scrollDirection
        self.config.enableTTS = false
        self.config.displayTitle = true
        self.config.allowSharing = self.allowSharing
        self.config.tintColor = self.tintColor
        self.config.hideBars = false
        self.config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            self.config.quoteCustomBackgrounds.append(customImageQuote)
              }
        self.config.canChangeFontStyle = true
        var realmConfig = Realm.Configuration.defaultConfiguration
        realmConfig.readOnly = false
        // realmConfig.migrationBlock = { migration, oldSchemaVersion in
        //     print("old version \(oldSchemaVersion)")
        //     print("new version \(migration)")
        // }
        realmConfig.deleteRealmIfMigrationNeeded = true
        realmConfig.schemaVersion = 0
        self.config.realmConfiguration = realmConfig
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        self.config.quoteCustomBackgrounds.append(customQuote)
    }
      
}


internal extension UIColor {
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex = String(rgba[index...])
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                    break
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                    break
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                    break
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                    break
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                    break
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
   
    func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha == true) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
      
    func highlightColor() -> UIColor {
        
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: 0.30, brightness: 1, alpha: alpha)
        } else {
            return self;
        }
        
    }
    
 
    func lighterColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 + percent));
    }
    
  
    func darkerColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 - percent));
    }
    
 
    func colorWithBrightnessFactor(_ factor: CGFloat) -> UIColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return self;
        }
    }
}
