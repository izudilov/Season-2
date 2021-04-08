//
//  NewsTableViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 15.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController  {

    var newsVK: Response?
    var isLoading = false
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.126"
    let request = "newsfeed.get"
    let request3 = "groups.getById"
    let user = Session.shared.userID!
    let apiKey = Session.shared.acess_token!
    var photoService: PhotoService?
    static var groupsID = [GroupsIDFromVK]()
    var id = APINews.id

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService.init(container: tableView)
        
        let parameters: Parameters = [
            "filters": "post",
            "access_token": apiKey,
            "v": version
        ]
        
                
        let url = baseUrl + request
              
        let opq = OperationQueue()
        //opq.maxConcurrentOperationCount = 1
        
        let request = AF.request(url, method: .get, parameters: parameters).responseJSON { [self] response in
            
            guard let data = response.data else { return }
            print(response.request)
            print("FirstRequest-00")
        
        }
        
        let url2 = baseUrl + request3
        
        let parameters2: Parameters = [
            "group_ids": APINews.id,
            "access_token": apiKey,
            "v": version
        ]
            
        
        let getDataOperation = GetData(request: request)
        getDataOperation.completionBlock = {
            print ("Request 1 is finished")
        }
        opq.addOperations([getDataOperation], waitUntilFinished: true)
        
        let parseData = APINews()
        parseData.addDependency(getDataOperation)
        parseData.completionBlock = {
            print ("Parse 1 is finished")
        }
        opq.addOperations([parseData], waitUntilFinished: true)
        
        let request2 =  AF.request(url2, method: .get, parameters: parameters2).responseJSON {  response in
                                        
            guard let data = response.data else { return }
            print(response.request)
            print("SecondReqest-00")
           
        }
        
        let requestID = GetData(request: request2)
        requestID.addDependency(parseData)
        requestID.completionBlock = {
            print ("Request 2 is finished")
        }
        
        opq.addOperations([requestID], waitUntilFinished: true)
        
        //parseData.addDependency(getDataOperation)
        //opq.addOperation(parseData)
        let parseData2 = APIGroupID()
        //parseData2.addDependency(parseData)
        parseData2.addDependency(requestID)
        parseData2.completionBlock = {
            print ("Parse 2 is finished")
        }
        
        opq.addOperations([parseData2], waitUntilFinished: true)
        //opq.addOperations([getDataOperation, parseData, requestID, parseData2], waitUntilFinished: true)
        
        tableView.reloadData()
        
                        
        let reloadTableController = ReloadTableController(controller: self)
        reloadTableController.addDependency(parseData)
        reloadTableController.addDependency(parseData2)
        //let reloadTable2 = ReloadTableController(controller: self)
        //reloadTable2.addDependency(parseData2)
        
        //OperationQueue.main.addOperation(reloadTable2)
        OperationQueue.main.addOperation(reloadTableController)
        setupRefreshControl()
        
        self.tableView.prefetchDataSource = self

       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCellxib")
    }
    
   
    // MARK: - Table view data source
    
    fileprivate func setupRefreshControl() {
           // Инициализируем и присваиваем сущность UIRefreshControl
           refreshControl = UIRefreshControl()
           // Настраиваем свойства контрола, как, например,
           // отображаемый им текст
           refreshControl?.attributedTitle = NSAttributedString(string: "Обновляем ленту...")
           // Цвет спиннера
            refreshControl?.tintColor = .systemBlue
           // И прикрепляем функцию, которая будет вызываться контролом
           refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
            
       }

    @objc func refreshNews() {
          // Начинаем обновление новостей
          self.refreshControl?.beginRefreshing()
          // Определяем время самой свежей новости
          // или берем текущее время
          let mostFreshNewsDate = self.newsVK?.items.first?.date ?? Date().timeIntervalSince1970
          // отправляем сетевой запрос загрузки новостей
            let parameters: Parameters = [
            "filters": "post",
            "start_time":  mostFreshNewsDate + 1,
            "access_token": apiKey,
            "v": version
            ]
                       
        let url = baseUrl + request
        
        let request = AF.request(url, method: .get, parameters: parameters).responseJSON { [self] response in
            
            guard let data = response.data else { return }

            print(response.request)
            
            do {
                let decoder = JSONDecoder()
                let parsedResult: Welcome = try JSONDecoder().decode(Welcome.self, from: data)
                
                if parsedResult.response.items.count > 0 {
                
                    var i = 0
                    var arrayIDGroup = [Int]()
                    var arrayIDUser = [Int]()
                    
                    while i < parsedResult.response.items.count {
                        if parsedResult.response.items[i].source_id < 0 {
                            arrayIDGroup.append((parsedResult.response.items[i].source_id) * -1)
                        } else {
                            arrayIDUser.append(parsedResult.response.items[i].source_id)
                        }
                        i += 1
                    }
                    
                    APINews.id.append(contentsOf: arrayIDGroup)
                    print(arrayIDGroup.count)
                                    
                    let addNews = parsedResult.response.items + self.newsVK!.items
                    print(addNews.count)
                    self.newsVK?.items = addNews
                    //tableView.reloadData()
                    // формируем IndexSet свежедобавленных секций и обновляем таблицу
                    tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    //self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                } else {
                    self.refreshControl?.endRefreshing()
                }
              
                
            
        }
        catch {
            print(error)
        }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newsVK?.items.count ?? 0
        //return NewsTableViewController.groupsID.count
        //return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsVK?.items.count ?? 0
        //return NewsTableViewController.groupsID.count
        //return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellxib", for: indexPath) as! NewsCell
               
                 /*cell.userFoto.image = try? UIImage(data: Data(contentsOf: ((URL(string: newsVK?.groups[indexPath.row].photo_50 ?? "https://vk.com/images/camera_50.png")) ?? URL(string: "https://vk.com/images/camera_50.png"))!))*/
        
            cell.userFoto.image = photoService?.photo(atIndexpath: indexPath, byUrl: newsVK?.groups[0].photo_50 ?? "https://vk.com/images/camera_50.png")
            
            //cell.userName.text = NewsTableViewController.groupsID[indexPath.row].name
            cell.userName.text = newsVK?.groups[0].name
       
        
            cell.newsData.text = newsVK?.items[indexPath.row].dateText
            

        if ((newsVK?.items[indexPath.row].text) != nil) {
            

                cell.newsText.text? = (newsVK?.items[indexPath.row].text.maxLength(length: 197))! + "..."

            
        }
        
        
            cell.views.text = newsVK?.items[indexPath.row].views?.count.description ?? "0"
                if ((newsVK?.items[indexPath.row].attachments) == nil) {
                    cell.newsFoto.isHidden = true
            } else {
                /*cell.newsFoto.image = try? UIImage(data: Data(contentsOf: (URL(string: (newsVK?.items[indexPath.row].attachments?[0].photo?.sizes?.last?.url) ?? "https://vk.com/images/camera_200.png"))!))*/
                cell.newsFoto.image = photoService?.photo(atIndexpath: indexPath, byUrl: newsVK?.items[indexPath.row].attachments?[0].photo?.sizes?.last?.url ?? "https://vk.com/images/camera_200.png")
                }
            cell.comments.text = newsVK?.items[indexPath.row].comments.count.description
        
            if cell.like.tag == 0 {
                cell.like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.like.tintColor = .red
                cell.countNumber = (newsVK?.items[indexPath.row].likes.count ?? 0) + 1
                cell.likeNumbers.text = "\(cell.countNumber)"
                cell.like.tag = 1
            
            } else if cell.like.tag == 1 {
                cell.like.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.like.tintColor = .systemBlue
                cell.countNumber = (newsVK?.items[indexPath.row].likes.count ?? 0) - 1
                cell.likeNumbers.text = "\(cell.countNumber)"
                cell.like.tag = 0
                
            } else if cell.like.tag > 1  {
                cell.like.tag = 1
            }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellxib", for: indexPath) as! NewsCell
        
        if cell.newsText.text?.count == 200 {
            cell.newsText.text = newsVK?.items[indexPath.row].text
            print(cell.newsText.text)
            let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        // Ячейки с фото у нас, например, имеют .row == 2
        case 2:
                // Вычисляем высоту
                let tableWidth = tableView.bounds.width
                let news = self.newsVK?.items[indexPath.row].attachments?[0].photo?.sizes?.first?.aspectRatio
                let cellHeight = tableWidth //* news
                return cellHeight
        default:
        // Для всех остальных ячеек оставляем автоматически определяемый размер
                return UITableView.automaticDimension
           
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NewsTableViewController: UITableViewDataSourcePrefetching {
   func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
       guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
       // Проверяем,является ли эта секция одной из трех ближайших к концу
        if maxSection > (newsVK?.items.count)! - 15,
           // Убеждаемся, что мы уже не в процессе загрузки данных
           !isLoading {
           // Начинаем загрузку данных и меняем флаг isLoading
           isLoading = true
           // Обратите внимание, что сетевой сервис должен уметь обрабатывать входящий параметр nextFrom
            let mostOldNews = self.newsVK?.items.last?.date ?? Date().timeIntervalSince1970
            // отправляем сетевой запрос загрузки новостей
              let parameters: Parameters = [
              "filters": "post",
              "start_time": mostOldNews + 1,
              "access_token": apiKey,
              "v": version
              ]
                         
          let url = baseUrl + request
          
          let request = AF.request(url, method: .get, parameters: parameters).responseJSON { [self] response in
              
              guard let data = response.data else { return }

              print(response.request)
              
              do {
                  let decoder = JSONDecoder()
                  let parsedResult: Welcome = try JSONDecoder().decode(Welcome.self, from: data)
                  
                  if parsedResult.response.items.count > 0 {
                  
                      var i = 0
                      var arrayIDGroup = [Int]()
                      var arrayIDUser = [Int]()
                      
                      while i < parsedResult.response.items.count {
                          if parsedResult.response.items[i].source_id < 0 {
                              arrayIDGroup.append((parsedResult.response.items[i].source_id) * -1)
                          } else {
                              arrayIDUser.append(parsedResult.response.items[i].source_id)
                          }
                          i += 1
                      }
                      
                      APINews.id.append(contentsOf: arrayIDGroup)
                     
                      //let addNews = self.newsVK!.items + parsedResult.response.items
                      let addNews = self.newsVK!.items
                      self.newsVK?.items = addNews
                      //tableView.reloadData()
                      // формируем IndexSet свежедобавленных секций и обновляем таблицу
                        // Прикрепляем новости к cуществующим новостям
                    let indexSet = IndexSet(integersIn: (self.newsVK?.items.count)! ..< (self.newsVK?.items.count)! + addNews.count)
                    self.newsVK?.items.append(contentsOf: addNews)
                        // Обновляем таблицу
                        //self.tableView.insertSections(indexSet, with: .automatic)
                    self.tableView.reloadData()                    
                        // Выключаем статус isLoading
                        self.isLoading = false
                        
                    //tableView.reloadData()

                      //self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                  }

          }
          catch {
              print(error)
          }
          }
            

           }
       }
   }


extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
}
