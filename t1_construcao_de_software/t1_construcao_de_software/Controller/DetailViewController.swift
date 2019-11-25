//
//  DetailViewController.swift
//  t1_construcao_de_software
//
// Classe com os detalhes de um curso
//
//  Created by Fernando Locatelli Maioli on 02/10/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    @IBOutlet weak var monthlyPriceLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var notaIntegralCotaLabel: UILabel!
    @IBOutlet weak var notaIntegralAmplaLabel: UILabel!
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    
    var nameLabelText: String!
    var scoreLabelText: String!
    var universityLabelText: String!
    var campusLabelText: String!
    var monthlyPriceLabelText: String!
    var shiftLabelText: String!
    var ufLabelText: String!
    var cityLabelText: String!
    var notaIntegralCotaText: String!
    var notaIntegralAmplaText: String!
    
    var isFavorite: Bool!
    
    var curso: Curso!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = nameLabelText
        scoreLabel.text = scoreLabelText
        universityLabel.text = universityLabelText
        campusLabel.text = campusLabelText
        monthlyPriceLabel.text = monthlyPriceLabelText
        shiftLabel.text = shiftLabelText
        cityLabel.text = "\(cityLabelText ?? ""), \(ufLabelText ?? "")"
        notaIntegralCotaLabel.text = notaIntegralCotaText
        notaIntegralAmplaLabel.text = notaIntegralAmplaText

        
        if isFavorite {
            favoriteButtonOutlet.isHidden = true
        }
        else {
            favoriteButtonOutlet.isHidden = false
        }
    }
    
    
    @IBAction func favoritarCursoButton(_ sender: Any) {
        DataAccess.favoritarCurso(uf_busca: curso.uf_busca ?? "", cidade_busca: curso.cidade_busca ?? "", universidade_nome: curso.universidade_nome ?? "", nome: curso.nome ?? "", campus_nome: curso.campus_nome ?? "", grau: curso.grau ?? "", turno: curso.turno ?? "", mensalidade: "\(curso.mensalidade ?? 0.0)", notaIntegralAmpla: "\(curso.nota_integral_ampla ?? 0)", notaIntegralCotas: "\(curso.nota_integral_cotas ?? 0)", bolsa_integral_ampla: "\(curso.bolsa_integral_ampla ?? 0)", bolsa_integral_cotas: "\(curso.bolsa_integral_cotas ?? 0)", bolsa_parcial_cotas: "\(curso.bolsa_partial_cotas ?? 0)", bolsa_parcial_ampla: "\(curso.bolsa_parcial_ampla ?? 0)", nota_parcial_ampla: "\(curso.nota_parcial_ampla ?? 0)", nota_parcial_cotas: "\(curso.nota_parcial_cotas ?? 0)") { (finished) in
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
}
