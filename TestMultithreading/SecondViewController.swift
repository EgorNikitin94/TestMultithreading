//
//  SecondViewController.swift
//  TestMultithreading
//
//  Created by Егор Никитин on 27.01.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    
    @IBOutlet var logoLabel: UILabel!
    
    @IBOutlet var myImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadMyView1()
        //loadMyView2()
        loadMyView3()
    }
    
    // classic
    private func loadMyView1() {
        guard let imageUrl = URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fce%2FCoca-Cola_logo.svg%2F1200px-Coca-Cola_logo.svg.png&f=1&nofb=1") else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // DispatchWorkItem
    private func loadMyView2() {
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        guard let imageUrl = URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fce%2FCoca-Cola_logo.svg%2F1200px-Coca-Cola_logo.svg.png&f=1&nofb=1") else { return }
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: imageUrl)
            print(Thread.current)
        }
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.myImageView.image = UIImage(data: imageData)
                
            }
        }
    }
    
    // URLSession
    private func loadMyView3() {
        guard let imageUrl = URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fce%2FCoca-Cola_logo.svg%2F1200px-Coca-Cola_logo.svg.png&f=1&nofb=1") else { return }
        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            print(Thread.current)
            if let imageData = data {
                DispatchQueue.main.async {
                    self?.myImageView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}

