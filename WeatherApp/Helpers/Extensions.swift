//
//  Extensions.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/6/22.
//

import UIKit

extension WeatherViewController {
    
    func setupDisplay(weatherDesc: String, image: String, listColor: String){
        self.imageView.image = UIImage(named: image)
        self.svForecast.backgroundColor = UIColor.init(hexString: listColor)
        self.list.backgroundColor = UIColor.init(hexString: listColor)
        self.tempSubText.text = weatherDesc
    }
    
    func getWeatherIcon(desc: String) -> String{
        if(desc == "Rain"){
            return "rain"
        }
        
        if(desc == "Clouds"){
            return "partlysunny"
        }
        
        if(desc == "Mist"){
            return "partlysunny"
        }
        
        if(desc == "Clear"){
            return "clear"
        }
        return "clear"
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item at \(indexPath) has been selected")
    }
}

extension Date {
    
    static func getDate(timeStamp: Double) -> Date {
        let date = Date(timeIntervalSince1970: timeStamp)
        return date
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // OR "dd-MM-yyyy"

        let day: String = dateFormatter.string(from: self)
        return day
    }
}
