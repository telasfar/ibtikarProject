//
//  HomeVC.swift
//  IbtikarProject
//
//  Created by Tariq Maged on 9/22/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    //vars
    var episodeModel:EpisodeModel?
    let refreshControl:UIRefreshControl = {
        let rC = UIRefreshControl()
        rC.tintColor = UIColor.lightGray
        rC.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return rC
    }()
    //outlets
    @IBOutlet weak var tableViewEpisode: TanibleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupTableView()
      episodeModel = Storage.retrieve(FileSystemNames.episode.rawValue, from: .documents, as: EpisodeModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alertUser(message: "You watch now the stored Data but you can refresh that data any time by Pull the tableView to refresh ")
    }

    func setupTableView(){
        let seriesNib = UINib(nibName: SieresCell.identifier(), bundle: nil)
        tableViewEpisode.register(seriesNib, forCellReuseIdentifier: SieresCell.identifier())
        let channelHeader = UINib(nibName: ChannelHeaderCell.identifier(), bundle: nil)
        let categoryFooter = UINib(nibName: CategoryFooterCell.identifier(), bundle: nil)
        tableViewEpisode.register(channelHeader, forHeaderFooterViewReuseIdentifier: ChannelHeaderCell.identifier())
        tableViewEpisode.register(categoryFooter, forHeaderFooterViewReuseIdentifier: CategoryFooterCell.identifier())
        tableViewEpisode.refreshControl = refreshControl
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.direction = .right
        tableViewEpisode.setNeedsDisplay()
    }
      
    @objc
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        PreftechService.instance.loadAndSaveData(vc: self) {
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
                self.tableViewEpisode.reloadData()
            }
        }
    }

}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeModel?.data?.channels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SieresCell.identifier(), for: indexPath) as?  SieresCell else {return UITableViewCell()}
        cell.configCell(channel: episodeModel?.data?.channels?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChannelHeaderCell.identifier()) as? ChannelHeaderCell else {return UITableViewCell()}
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryFooterCell.identifier()) as? CategoryFooterCell else {return UITableViewCell()}
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.height*0.4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return tableView.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
