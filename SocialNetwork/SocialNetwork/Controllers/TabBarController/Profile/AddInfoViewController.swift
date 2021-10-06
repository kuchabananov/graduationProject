//
//  AddInfoViewController.swift
//  SocialNetwork
//
//  Created by Евгений on 4.10.21.
//

import UIKit

class AddInfoViewController: UIViewController {
    
    var user: User?

    
    
    @IBOutlet weak var bDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    
    @IBOutlet weak var infoTableView: UITableView!
    
    let listInfoForTable = ["Friends", "Following", "Communities", "Music", "Videos"]
    let namesImage = ["person", "person.2", "person.3", "music.note", "video.circle"]
    var listInfoNumber: [Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillListInfoNumber()
        infoTableView.separatorStyle = .none
    }
    
    private func fillListInfoNumber() {
        guard let user = user.self else { return }
        if let friendsNum = user.counters?.friends {
            listInfoNumber.append(friendsNum)
        }
        if let followersNum = user.counters?.followers {
            listInfoNumber.append(followersNum)
        }
        if let communitiesNum = user.counters?.groups {
            listInfoNumber.append(communitiesNum)
        }
        if let musicNum = user.counters?.audios {
            listInfoNumber.append(musicNum)
        }
        if let videosNum = user.counters?.videos {
            listInfoNumber.append(videosNum)
        }
        self.infoTableView.reloadData()
    }
    
    private func setupUI() {
        guard let user = self.user else { return }
        if let bDate = user.birthDate {
            bDateLabel.text = bDate
        }
        if let city = user.city?.title {
            cityLabel.text = city
        }
        if let university = user.universityName {
            universityLabel.text = university
        }
        if let followers = user.counters?.followers {
            followersLabel.text = "\(followers) followers"
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


extension AddInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listInfoForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell") as! InfoCell
        let name = listInfoForTable[indexPath.row]
        let nameImg = namesImage[indexPath.row]
        let number = listInfoNumber[indexPath.row]
        
        cell.infoNameLabel.text = name
        cell.infoImgView.image = UIImage(systemName: nameImg)
        cell.infoNumberLabel.text = "\(number)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
}
