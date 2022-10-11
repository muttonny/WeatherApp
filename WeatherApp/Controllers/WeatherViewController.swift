//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/5/22.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate {
    
    var cellId = "cellId"
    var degree = "\u{00B0}"
    
    var items = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var weatherData: [WeatherData]?
    
    let locationManager = CLLocationManager()
    
    var latitude = 0.0
    var longitude = 0.0
    
    var apiResp: ApiResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .yellow
        view.addSubview(svMain)
        addConstraints()
        
        setupForecastCollcetionView()
        
        setupLocation()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    lazy var tempTodayStack: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .center
        sv.addArrangedSubview(tempText)
        sv.addArrangedSubview(tempSubText)
        return sv;
    }()
    
    lazy var contentView: UIView = {
        let cv = UIView();
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.addSubview(imageView)
        cv.addSubview(tempTodayStack)
        cv.backgroundColor = .white
        return cv
    }()
    
    let tempText: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "25"
        tv.textColor = .white
        //tv.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.font = UIFont.boldSystemFont(ofSize: 50)
        return tv
    }()
    
    let tempSubText: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "SUNNY"
        tv.textColor = .white
        //tv.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.font = UIFont.boldSystemFont(ofSize: 30)
        return tv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "forest_sunny")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var svMain: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.addSubview(contentView)
        sv.addSubview(svForecast)
        return sv
    }()
        
    lazy var svForecast: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.backgroundColor = UIColor(hexString: "#47AB2F")
        sv.addSubview(svHeader)
        sv.addSubview(seperatorView)
        sv.addSubview(list)
        return sv
    }()
    
    lazy var svHeader : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.addArrangedSubview(svMin)
        sv.addArrangedSubview(svCurrent)
        sv.addArrangedSubview(svMax)
        return sv
    }()
    
    lazy var svMin : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        sv.addArrangedSubview(tempMin)
        sv.addArrangedSubview(labelMin)
        return sv
    }()
    
    let tempMin: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "19"
        tv.textColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    let labelMin: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "Min"
        tv.textColor = UIColor.init(hexString: "#FFE8E6E6")
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let tempCurrent: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "25"
        tv.textColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        return tv
    }()
    
    let labelCurrent: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "Current"
        tv.textColor = UIColor.init(hexString: "#FFE8E6E6")
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    lazy var svCurrent : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .center
        sv.addArrangedSubview(tempCurrent)
        sv.addArrangedSubview(labelCurrent)
        return sv
    }()
    
    let tempMax: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "27"
        tv.textColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        return tv
    }()
    
    let labelMax: UILabel = {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "Max"
        tv.textColor = UIColor.init(hexString: "#FFE8E6E6")
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    lazy var svMax : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .trailing
        sv.addArrangedSubview(tempMax)
        sv.addArrangedSubview(labelMax)
        return sv
    }()
    
    let seperatorView : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var list: UICollectionView = {

        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 40)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = UIColor(hexString: "#47AB2F")
        return cv
    }()
    
    func setupForecastCollcetionView(){

        list.dataSource = self
        list.delegate = self
        list.alwaysBounceVertical = true
    }
    
    func setupLocation(){
                
        //Ask for authorization from user
        locationManager.requestAlwaysAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchWeather(latitude: String, longitude: String){
        
        ApiService().fetchCurrentWeather(latitude: latitude, longitude: longitude) {(apiResp) in
            
            print("ApiResp: \(String(describing: apiResp.cod))")
            
            DispatchQueue.main.async {
                            
                guard let cod = apiResp.cod else {
                    print("Current Weather: Error processing data")
                    return }
                
                if(cod == 200){
                    self.tempText.text = String(format: "%.f", apiResp.main?.temp ?? 0) + self.degree
                    self.tempCurrent.text = String(format: "%.f", apiResp.main?.temp ?? 0) + self.degree
                    self.tempMax.text = String(format: "%.f", apiResp.main?.temp_max ?? 0) + self.degree
                    self.tempMin.text = String(format: "%.f", apiResp.main?.temp_min ?? 0) + self.degree
                    
                    if let description = apiResp.weather?[0]{
                        
                        if(description.main == "Rain"){ //rainy
                            self.setupDisplay(weatherDesc: "RAINY", image: "forest_rainy", listColor: "#57575D")
                        }
                        
                        if(description.main == "Clouds"){ //cloudy
                            self.setupDisplay(weatherDesc: "CLOUDY", image: "forest_cloudy", listColor: "#54717A")
                        }
                        
                        if(description.main == "Mist"){ //mist
                            self.setupDisplay(weatherDesc: "CLOUDY", image: "forest_cloudy", listColor: "#54717A")
                        }
                        
                        if(description.main == "Clear"){ //sunny
                            self.setupDisplay(weatherDesc: "SUNNY", image: "forest_sunny", listColor: "#47AB2F")
                        }
                    }
                }
            }
        }
    }
    
    func fetchWeatherForecast(latitude: String, longitude: String) {
        
        ApiService().fetchWeatherForecast(latitude: latitude, longitude: longitude) {(apiResp) in
            
            print("ApiResp: \(String(describing: apiResp.cod))")
            
            guard let data = apiResp.list else{
                print("Weather Forecast: Error processing data")
                return
            }
            
            DispatchQueue.main.async {
                
                self.weatherData = data
                self.list.reloadData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("Location update")
        
        guard let locationValues: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        print("Currect Location: \(locationValues.latitude) : \(locationValues.longitude)")
        
        //first time update, set latitude and longitude
        if(latitude == 0.0 && longitude == 0.0){
            latitude = locationValues.latitude
            longitude = locationValues.longitude
            
            let lat = "\(latitude)"
            let long = "\(longitude)"
            
            //fetch current weather
            fetchWeather(latitude: lat, longitude: long)
            
            //fetch weather forecast
            fetchWeatherForecast(latitude: lat, longitude: long)
        }
    }
    
    //collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherCell
        
        if(weatherData != nil){
            let weatherInfo = weatherData?[indexPath.row].main
            
            if let timestamp = weatherData?[indexPath.row].dt {
                let date = Date.getDate(timeStamp: timestamp)
                cell.dayField.text = date.toString(format: "EEEE")
            }
            
            if let temp = weatherInfo?.temp {
                cell.tempField.text = String(format: "%.f", temp ?? 0) + degree
            }
            
            if let desc = weatherData?[indexPath.row].weather?[0].main {
                
                let icon = getWeatherIcon(desc: desc)
                cell.image.image = UIImage(named: icon)
                print("Icon: \(icon)")
            }
            //cell.dayField.text = items[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item at position: \(indexPath.row) has been selected --- ")
    }
        
    func addConstraints(){
        
        NSLayoutConstraint.activate([

            svMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            svMain.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            svMain.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            svMain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            svMain.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: svMain.topAnchor, constant: 0.0),
            contentView.leadingAnchor.constraint(equalTo: svMain.leadingAnchor, constant: 0.0),
            contentView.trailingAnchor.constraint(equalTo: svMain.trailingAnchor, constant: 0.0),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),

            tempTodayStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempTodayStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            
//            tempText.centerXAnchor.constraint(equalTo: tempTodayStack.centerXAnchor),
//            tempText.centerYAnchor.constraint(equalTo: tempTodayStack.centerYAnchor),
            
            tempSubText.topAnchor.constraint(equalTo: tempText.bottomAnchor, constant: 0),

//            tempText.leadingAnchor.constraint(equalTo: svMain.leadingAnchor, constant: 10),
//            tempText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//
//            tempTextField.leadingAnchor.constraint(equalTo: svMain.leadingAnchor, constant: 20),
//            tempTextField.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
            
            
            svForecast.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
            svForecast.leadingAnchor.constraint(equalTo: svMain.leadingAnchor, constant: 0.0),
            svForecast.trailingAnchor.constraint(equalTo: svMain.trailingAnchor, constant: 0.0),
            svForecast.bottomAnchor.constraint(equalTo: svMain.bottomAnchor, constant: 0),
            svForecast.widthAnchor.constraint(equalTo: svMain.widthAnchor),
//
            svHeader.topAnchor.constraint(equalTo: svForecast.topAnchor, constant: 10.0),
            svHeader.leadingAnchor.constraint(equalTo: svForecast.leadingAnchor, constant: 0.0),
            svHeader.trailingAnchor.constraint(equalTo: svForecast.trailingAnchor, constant: 0.0),
            svHeader.widthAnchor.constraint(equalTo: svForecast.widthAnchor),
            
            svMin.leadingAnchor.constraint(equalTo: svHeader.leadingAnchor, constant: 20.0),
            svMax.trailingAnchor.constraint(equalTo: svForecast.trailingAnchor, constant: -20.0),
            
            seperatorView.topAnchor.constraint(equalTo: svHeader.bottomAnchor, constant: 10.0),
            seperatorView.leadingAnchor.constraint(equalTo: svForecast.leadingAnchor, constant: 0.0),
            seperatorView.trailingAnchor.constraint(equalTo: svForecast.trailingAnchor, constant: 0.0),
            seperatorView.heightAnchor.constraint(equalToConstant: 1.0),
            
            list.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 30.0),
            list.leadingAnchor.constraint(equalTo: svForecast.leadingAnchor, constant: 0.0),
            list.trailingAnchor.constraint(equalTo: svForecast.trailingAnchor, constant: 0.0),
            list.bottomAnchor.constraint(equalTo: svForecast.bottomAnchor, constant: 0.0)
            

        ])
        
//        svMain.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        svMain.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//
//        imageView.leftAnchor.constraint(equalTo: svMain.leftAnchor, constant: 0).isActive = true
//        imageView.rightAnchor.constraint(equalTo: svMain.rightAnchor, constant: 0).isActive = true
    }
    
    struct WeatherPreview: PreviewProvider {
        
        static var previews: some View {
            ContainerView().previewDevice("iPhone 13 Pro").ignoresSafeArea().previewInterfaceOrientation(.portrait)
        }
        
        struct ContainerView: UIViewControllerRepresentable {
            
            func makeUIViewController(context: UIViewControllerRepresentableContext<WeatherPreview.ContainerView>) -> UIViewController {
                return WeatherViewController()
            }
            
            func updateUIViewController(_ uiViewController: WeatherPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WeatherPreview.ContainerView>) {
            
            }
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
