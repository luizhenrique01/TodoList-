//
//  ViewController.swift
//  todolist4
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    let listaKey = "chaveLista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey: listaKey) as? [String] {
            listaDeTarefas.append(contentsOf: lista)
            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa"
                                    , message: "Adicione uma tarefa",
                                      preferredStyle: .alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default){
            (action) in if let textField = alert.textFields?.first, let texto = textField.text{
                self.listaDeTarefas.append(texto)
                self.tableView.reloadData()
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
            }
        }
        
        let acaoCancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancel)
        
        alert.addTextField()
        
        present(alert, animated: true)
        
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    
}


