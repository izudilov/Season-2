//
//  UserViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 01.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

private func letter (character: String) -> Character {
    guard let firstcharacter = character.first else { return "D"}
    return firstcharacter
}



class UserViewController: UITableViewController {


    var friendsFromVK = [UserVK]()
    var token: NotificationToken?
    
    /*var firstCharacters = [Character]()
    var sortedFriends: [Character: [UserVK]] = [:]
   
    private func sort(_ friends: [UserVK]) -> (characters: [Character], sortedFriends: [Character: [UserVK]]) {
        
        var characters = [Character]()
        var sortedFriends = [Character: [UserVK]]()
        
        friends.forEach { friend in
        
            var i = 0
            guard let character = self.friendsFromVK[i].last_name.first else { return }
            
            
            if var thisCharFriends = sortedFriends[character]  {
                thisCharFriends.append(friend)
                sortedFriends[character] = thisCharFriends
                
            } else {
                sortedFriends[character] = [friend]
                characters.append(character)
            }
            i += 1
        }
        
        characters.sort()
        
        return (characters, sortedFriends)
    }*/
    
    var sections = [GroupedSection <Character, UserVK>]()
 
    let searchController = UISearchController(searchResultsController: nil)
    private var filteredFriends = [UserVK]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            let realm = try Realm()
            let usersFromRealm = realm.objects(UserVK.self)
            self.friendsFromVK = Array(usersFromRealm)
            self.token = usersFromRealm.observe {  (changes) in
               
                switch changes {
                        
                        case .initial:
                            self.tableView.reloadData()
                            
                        case .update:
                            self.tableView.reloadData()

                            
                        case .error:
                           print("Hello")
                        }
                
                        print("данные изменились")
                    }

        } catch {
// если произошла ошибка, выводим ее в консоль
            print(error)
        }
        loadDataUsers()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.estimatedRowHeight = 63
        //tableView.rowHeight = UITableView.automaticDimension
        
        /*let loadData = APIFriends()
        loadData.loadVKFriends() { [weak self] friends in
            self?.friendsFromVK = friends
             self?.tableView.reloadData()
           
            
        }*/
        
        //(firstCharacters, sortedFriends) = sort(friendsFromVK)

        self.sections = GroupedSection.group(rows: friendsFromVK, by: { letter(character: $0.last_name) })
        self.sections.sort { lhs, rhs in lhs.sectionItem < rhs.sectionItem }
        
        // Setup searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти друзей"
        //tableView.tableHeaderView = searchController.searchBar
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //tableView.reloadData()
    }

// MARK: - Table view data source
    
    func loadDataUsers() {
            do {
                
                let realm = try Realm()
                let usersFromRealm = realm.objects(UserVK.self)
                self.friendsFromVK = Array(usersFromRealm)
               

            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        }
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFriends.count
        }
        
        let section = self.sections[section]
        return section.rows.count
    }
    
    override func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int) -> String? {
    
        if isFiltering {
          
            return "Найденные друзья"
        }

        let section = self.sections[section]
        let date = String(section.sectionItem)
        return date
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           
            var sub1 = UIImageView()
            var sub2 = UIImageView()
            var imageFoto = UIImage(named: "")
        
            // Получаем ячейку из пула
            let user = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserViewCell
        
                        
           // Устанавливаем userName and Foto в надпись ячейки
    
            
            sub2 = UIImageView(frame: CGRect(x: 3, y: 4, width: 60, height: 60))

            sub2.layer.masksToBounds = false

            sub2.layer.shadowPath = UIBezierPath(roundedRect: sub2.layer.bounds, cornerRadius: (sub2.bounds.height / 2)).cgPath
            sub2.layer.shadowColor = UIColor.black.cgColor
            sub2.layer.shadowOpacity = 0.8
            sub2.layer.shadowRadius = 3.5
            sub2.layer.shadowOffset = CGSize(width: 3, height: 2)
            
            if user.userFoto.subviews.isEmpty {
            user.userFoto.addSubview(sub2)
            }
        
            var friends: UserVK
        
            if isFiltering {
                friends = filteredFriends[indexPath.row]
                let fio = friends.last_name + " " + friends.first_name
                user.userName.text = fio
                imageFoto = try? UIImage(data: Data(contentsOf: (URL(string: friends.photo_100) ?? URL(string: "https://vk.com/images/camera_100.png"))!))
                
            }
                                            else {
        
                let section = self.sections[indexPath.section]
                let headline = section.rows[indexPath.row]
                let fio = headline.last_name + " " + headline.first_name
                user.userName.text = fio
                //imageFoto = UIImage(named: headline.photo_100)
                imageFoto = try? UIImage(data: Data(contentsOf: (URL(string: headline.photo_100) ?? URL(string: "https://vk.com/images/camera_100.png"))!))
                
            }
              
            sub1 = UIImageView (frame: CGRect(x: 3, y: 4, width: 60, height: 60))
            sub1.contentMode = .scaleAspectFit
            sub1.image = imageFoto
    
            sub1.layer.cornerRadius = sub1.bounds.height / 2
            sub1.clipsToBounds = true

            
        
            user.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

 
            user.userFoto.addSubview(sub1)
            
            return user
        }
   
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    // Опциональная привязка, проверка на nil
    // TableViewCellForService – это ваш класс
    if let cell = tableView.cellForRow(at: indexPath) as? UserViewCell {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut, .beginFromCurrentState],
                       animations: {
            cell.userFoto.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            if UIView.areAnimationsEnabled {
                UIView.animate(withDuration: 0.5,
                               delay: 0.1,
                               options: [.curveEaseOut],
                               animations: {
                                cell.userFoto.transform = CGAffineTransform(scaleX: 1, y: 1)}
                )}
            })
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectIndex = self.tableView.indexPathForSelectedRow else {
            return
        }
        if segue.destination is ScrollFotoViewController {
           
            
            let vc = segue.destination as? ScrollFotoViewController

            if isFiltering {
               
                
                let headline = filteredFriends[selectIndex.row]
                vc?.userPhoto = headline.id
                //vc?.imageArray.append(UIImage(data: try! Data(contentsOf: (URL(string: headline.photo_200_orig)!)))!)
                            
            } else {
                let section = self.sections[selectIndex.section]
                let headline = section.rows[selectIndex.row]
                vc?.userPhoto = headline.id
                
                print(headline.id)
                //vc?.imageArray.append(UIImage(data: try! Data(contentsOf: (URL(string: headline.photo_200_orig)!)))!)
                
            }
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

extension UserViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText (_ searchText: String) {
        
        filteredFriends = FriendsVK.friends.filter({ (friends: UserVK) -> Bool in
            return friends.last_name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
