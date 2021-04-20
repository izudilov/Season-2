//
//  GroupViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 02.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class GroupViewController: UITableViewController, CAAnimationDelegate {

    var addGroup = [GroupVK]()
    var shapeLayer1 = CAShapeLayer()
    var groupsFromVK = [GroupVK]()
    var token: NotificationToken?
    var photoService: PhotoService?
    
    // For search bar
    
    private var filteredGroups = [GroupVK]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
        @IBAction func addGroup(segue: UIStoryboardSegue) {
         
        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addGroup" {
           
            /*if !groupsFromVK.contains(where: { (VKGroups) -> Bool in
                if VKGroups == addGroup{
                    return true
                } else {
                    return false
                }
            })
            
                {
                groupsFromVK.append(addGroup)
                    // Обновляем таблицу
                    tableView.reloadData()
                
            } else {
               showLoginError()
            }*/
           
        }
           
    }
    
        

        override func viewDidLoad() {
        super.viewDidLoad()
            photoService = PhotoService.init(container: tableView)
            let group = APIGroups()
            group.loadVKG().done { (group) in
                self.groupsFromVK = group
                self.tableView.reloadData()
                }
            
         /*   let loadData = APIGroups()
            loadData.loadVKGroups() { [weak self] groups in
                self?.groupsFromVK = groups
                self?.tableView.reloadData()
                
            }*/
            
            /*do {
                let realm = try Realm()
                let groupsFromRealm = realm.objects(GroupVK.self)
                self.groupsFromVK = Array(groupsFromRealm)
                self.token = groupsFromRealm.observe {  (changes) in
                   
                    switch changes {
                            case .initial:
                                self.tableView.reloadData()
                                
                            case .update(_, let deletions, let insertions, let modifications):
                                    
                                    self.tableView.beginUpdates()
                                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                         with: .automatic)
                                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                                         with: .automatic)
                                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                         with: .automatic)
                                    
                                self.tableView.reloadData()
                        case .error:
                               print("Hello")
                            }
                    
                            print("данные изменились")
                        }
                
                
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }*/
            
            //loadDataGroups()
            
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButton))
            self.navigationItem.rightBarButtonItem = button

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
             //   self.navigationItem.rightBarButtonItem = UIBarButtonItem()
            
            tableView.estimatedRowHeight = 63
            tableView.rowHeight = UITableView.automaticDimension
            
            // Setup searchController
            
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Найти группу"
            navigationItem.searchController = searchController
            definesPresentationContext = true
        
    }

    // MARK: - Table view data source
 /*   func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "nextVC" {
                let a = segue.destination as! NoMyGroupViewController
                
            }*/
    
    func loadDataGroups() {
        
        
            do {
                let realm = try Realm()
                let groupsFromRealm = realm.objects(GroupVK.self)
                self.groupsFromVK = Array(groupsFromRealm)
                              
                
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        
        self.tableView.reloadData()
        
    }
    
    
    @objc func barButton() {
        print("Button Tapped")
        performSegue(withIdentifier: "nextVC", sender: self)
           //If you want pass data while segue you can use prepare segue method
    
    }


    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ой", message: "Ты уже состоишь в указанной группе", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredGroups.count
        }
            return groupsFromVK.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupViewCell

        if isFiltering {
            cell.groupName.text =  filteredGroups[indexPath.row].name
            cell.groupLogo.image = photoService?.photo(atIndexpath: indexPath, byUrl: self.groupsFromVK[indexPath.row].photo_100)
            
        } else {
        
            cell.groupName.text =  self.groupsFromVK[indexPath.row].name
            cell.groupLogo.image = photoService?.photo(atIndexpath: indexPath, byUrl: self.groupsFromVK[indexPath.row].photo_100)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    // Опциональная привязка, проверка на nil
    // TableViewCellForService – это ваш класс
    if let cell = tableView.cellForRow(at: indexPath) as? GroupViewCell {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut, .beginFromCurrentState],
                       animations: {
            cell.groupLogo.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            if UIView.areAnimationsEnabled {
                UIView.animate(withDuration: 0.5,
                               delay: 0.1,
                               options: [.curveEaseOut],
                               animations: {
                                cell.groupLogo.transform = CGAffineTransform(scaleX: 1, y: 1)}
                )}
            })
        }

    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            // Удаляем город из массива
           
            if isFiltering {
                var deletedName = [GroupVK]()
                var i = 0
                deletedName = [filteredGroups[indexPath.row]]
                filteredGroups.remove(at: indexPath.row)
                
                while i < groupsFromVK.count {
                    if deletedName[0].name == groupsFromVK[i].name  {
                       groupsFromVK.remove(at: i)
                    }
                    i += 1
                }
            } else {
                groupsFromVK.remove(at: indexPath.row)
            }
            // И удаляем строку из таблицы
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

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

extension GroupViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText (_ searchText: String) {
        
        filteredGroups = groupsFromVK.filter({ (groups: GroupVK) -> Bool in
            return groups.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
