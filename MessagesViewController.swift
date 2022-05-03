//
//  MessagesViewController.swift
//  malone-swift-app
//
//  Created by Carter Brehm on 4/19/22.
//

import UIKit
import SafariServices

class MessagesViewController: UITableViewController {

    var announcements: AnnouncementsObject?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Announcements"
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(swipeRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
        fetchPosts()
        self.title = "Announcements"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc private func swipeRefresh(refreshControl: UIRefreshControl) {
        fetchPosts()
        refreshControl.endRefreshing()
    }
    
    
    
    private func fetchPosts() {
        
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "SavedAnnouncements") as? Data {
            do {
                let decoder = JSONDecoder()
                self.announcements = try decoder.decode(AnnouncementsObject.self, from: data)
            } catch {
                print("Failed to decode data: \(error)")
            }
        }
        
        guard let url = URL(string: "https://malone.carters.cloud/ghost/api/v3/content/posts?key=9a559148799180975f4a5d4e58&fields=id,title,published_at,url,custom_excerpt") else {
            print("Failed to create a URL from the string.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }
            let decoder = JSONDecoder()

            do {
                self!.announcements = try decoder.decode(AnnouncementsObject.self, from: data)
            } catch {
                print("Failed to decode data: \(error)")
            }

            DispatchQueue.main.async {
                self?.tableView.reloadData()
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: "SavedAnnouncements")
            }
        }

        task.resume()
    }

    // MARK: - Table view data source
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements?.posts.count ?? 0
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: (announcements?.posts[indexPath.row].url)!) {
                let config = SFSafariViewController.Configuration()
                config.barCollapsingEnabled = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }


     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)

         let announcement = announcements!.posts[indexPath.row]
         cell.textLabel?.text = announcement.title
         cell.textLabel?.lineBreakMode = .byWordWrapping
         cell.textLabel?.numberOfLines = 0
         cell.detailTextLabel?.text = announcement.custom_excerpt
         cell.detailTextLabel?.lineBreakMode = .byWordWrapping
         cell.detailTextLabel?.numberOfLines = 0
         

             return cell
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
