//
//  ScrollFotoViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 22.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ScrollFotoViewController: UIViewController {
  
    var userPhoto: Int = 0
    static var userAPI: Int?
    
    var fotosFromVK = [PhotoSize]()
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.126"
    
    @IBOutlet weak var photoView: UIImageView!
 
    //lazy var tapGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    let previosViewOffSet: CGFloat = 0.0
    let initialPositionForView: CGFloat = 0.0
    
    var userID = [Int]()
    var imageArray = [UIImage]()
    var add = [UserIDForPhoto]()
    
    var countSwipe = 0

    
    override func viewDidLoad() {

        loadVKPhotos1 { [weak self] foto in
                    self?.fotosFromVK = foto
                }
        loadPhotoUsersFromRealm()
       
       
                
        photoView.image = imageArray.first

        let swipeLeft = UISwipeGestureRecognizer()
        let swipeRight = UISwipeGestureRecognizer()
        swipeLeft.direction = .left

        swipeRight.direction = .right
        
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        
        swipeLeft.addTarget(self, action: #selector(handleGesture))
        swipeRight.addTarget(self, action: #selector(handleGesture))
        
      
        
        // Do any additional setup after loading the view.
    }

    
    
    func loadPhotoUsersFromRealm() {
        
        do {
            let realm = try Realm()
           
            let photoArray = realm
                .objects (UserIDForPhoto.self)
                .filter("id = \(self.userPhoto)")
            
            print("\(photoArray.isEmpty)")
            
            self.add = Array(photoArray)
            
            self.add.forEach { (userPhoto) in
                
                userPhoto.photo.forEach { (userPhotoUrl) in
                          
                    self.imageArray.append(UIImage(data: try! Data(contentsOf: (URL(string: userPhotoUrl.url as String? ??  "https://vk.com/images/camera_100.png")!)))!)
                        print(self.imageArray)

                                       
                    
                }
                
               
            }
            
           
            
            } catch {
                print(error)
            }
    }
    
  func loadVKPhotos1(completion: @escaping ([PhotoSize]) -> Void ) {
        
        let request = "photos.getAll"
        
        guard let apiKey = Session.shared.acess_token else {return}
        let parameters: Parameters = [
            "owner_id": self.userPhoto,
            "extended": 0,
            "offset": 0,
            "photo_sizes": 0,
            "no_service_albums": 0,
            "need_hidden" : 0,
            "skip_hidden": 1,
            "count": 200,
            "access_token": apiKey,
            "v": version,
            
        ]
       
        let url = baseUrl+request
        AF.request(url, method: .get, parameters:
                    parameters).responseJSON { response in
                        
                        //guard let data = response.data else { return }
                        
                        do {
                            let parsedResult: StructAPIPhoto = try JSONDecoder().decode(StructAPIPhoto.self, from: response.data!)
                            
                            let array = parsedResult.response.items
                            AllPhotosVK.photosFromVK = array

                            
                            var i = 0
                            
                            print("Loading is starting")
                            while i < array.count {
                               
                               /* self.imageArray.append(UIImage(data: try Data(contentsOf: (URL(string: array[i].sizes.last?.url ?? "https://vk.com/images/camera_100.png")
                                )!))!)*/
                                
                                let id = UserIDForPhoto()
                                id.id = self.userPhoto
                                
                                var count = 0
                                
                                while count < parsedResult.response.items.count {   id.photo.append(parsedResult.response.items[count].sizes.last!)
                                    count += 1
                                }
                                
                                do {
                                    let realm = try Realm()
                                    realm.beginWrite()
                                    
                                    realm.add(parsedResult.response.items[i].sizes.last!, update: .all)
                                    realm.add(id, update: .modified)
                                    try realm.commitWrite()
                                                     
                                    
                                    /*var photoArray = realm
                                        .objects (UserIDForPhoto.self)
                                        .filter("id == %@", self.userID)
                                    
                                    var add = [UserIDForPhoto]()
                                    add = Array(photoArray)
                                    
                                    add.forEach { (userPhoto) in
                                        print("\(userPhoto.photo)")
                                        }*/
                                    
                                   
                                    
                                } catch {
                                    print(error)
                                }
                                   
                                
                                i += 1
                            }
                            
                     
                            
                            
                            
                            print("Loading is finished")
                           
                            completion (array)
                            
                        }
                        catch {
                            print(error)
                        }
                       
                    }
    }
  /*  @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
       
      
        if sender.state == .began {
            UIView.animate(withDuration: 0.5,
                           animations: {
                            self.imageScroll.frame = CGRect(x: 0, y: 300, width: self.imageScroll.frame.width, height: self.imageScroll.frame.height)
                            self.imageScroll.image = self.imageArray[0]
                            //self.photoView.frame.origin = CGPoint(x: self.photoView.center.x, y: self.photoView.center.y)
                           
                           },
                           completion: nil )
                      
            self.view.backgroundColor = .yellow
            self.imageScroll.image =  imageArray[1]
        } else if sender.state == .changed {
            self.view.backgroundColor = .white
        }
        
        
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc
    
    private func handleGesture (_ sender: UISwipeGestureRecognizer) {
        
       
            
        switch sender.direction {
        
        
        case .left:
            
         

            if self.countSwipe < self.imageArray.count {
                self.countSwipe += 1
                print(self.countSwipe)
                UIView.animate(withDuration: 0.5,
                           animations: {
                            
                            self.photoView.frame.origin = CGPoint(x: -500, y: self.photoView.frame.origin.y)
                            self.photoView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                            
                           },
                           completion: {  _ in
                            
                            self.photoView.alpha = 0
                            self.photoView.frame.origin = CGPoint(x: self.view.frame.origin.x + 50, y: self.view.frame.origin.y)

                            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                                
                                if self.countSwipe  < self.imageArray.count {
                                    self.photoView.alpha = 1
                                    self.photoView.image = self.imageArray[self.countSwipe]
                                    //self.photoView.frame.origin = CGPoint(x: +500, y: self.photoView.frame.origin.y)
                                    self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    self.photoView.center.x = self.view.frame.midX
                                    self.countSwipe += 1
                                    print(self.countSwipe)
                                } else if self.countSwipe == self.imageArray.count {
                                    self.photoView.alpha = 1
                                    self.photoView.image = self.imageArray.last
                                    self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    self.photoView.center.x = self.view.frame.midX}
                            })
                           })
                
                
                            
                
            } else {
                
                UIView.animate(withDuration: 0.5,
                           animations: {
                            
                            self.photoView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                            self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)                           })
            }
            case.right:
                
    
               
                
                if self.countSwipe > 0 {
                    
                    self.countSwipe -= 1
                    print(self.countSwipe)

                    
                    UIView.animate(withDuration: 0.5,
                               animations: {
                               
                                self.photoView.frame.origin = CGPoint(x: +500, y: self.photoView.frame.origin.y)
                                self.photoView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
                                
                               },
                               completion: {  _ in
                                self.photoView.alpha = 0
                                self.photoView.frame.origin = CGPoint(x: self.view.frame.origin.x + 50, y: self.view.frame.origin.y)
                
                                
                                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                                    if self.countSwipe > 0 {
                                        self.countSwipe -= 1
                                        print(self.countSwipe)
                                        self.photoView.alpha = 1
                                        self.photoView.image = self.imageArray[self.countSwipe]
                                        //self.photoView.frame.origin = CGPoint(x: +500, y: self.photoView.frame.origin.y)
                                        self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        self.photoView.center.x = self.view.frame.midX


                                    }  else if self.countSwipe == 0 {
                                        self.photoView.alpha = 1
                                        self.photoView.image = self.imageArray.first
                                        self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        self.photoView.center.x = self.view.frame.midX}
                                })
                               })
                
                    
                } else {
                    UIView.animate(withDuration: 0.5,
                               animations: {
                                
                                self.photoView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                self.photoView.transform = CGAffineTransform(scaleX: 1, y: 1)                           })
                }
                
        default: break
            

        
        }
      
        
    }

}
