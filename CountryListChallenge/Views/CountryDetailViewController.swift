import UIKit

class CountryDetailViewController: UIViewController {
    var country: CountryModel?
    private var viewModel: CountryDetailViewModel
    
    private let capitalLabel = UILabel()
    private let regionLabel = UILabel()
    private let populationLabel = UILabel()
    private let flagLabel = UILabel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = viewModel.country.name.common
        
        setupLabel(label: capitalLabel, text: viewModel.capital, topAnchor: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        setupLabel(label: regionLabel, text: viewModel.region, topAnchor: capitalLabel.bottomAnchor, constant: 10)
        setupLabel(label: populationLabel, text: viewModel.population, topAnchor: regionLabel.bottomAnchor, constant: 10)
        
        setupLabel(label: flagLabel, text: viewModel.flagEmoji!, topAnchor: populationLabel.bottomAnchor, constant: 10)
        
        let backButton = UIBarButtonItem(title: DetailView.goToBack.rawValue, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupLabel(label: UILabel, text: String, topAnchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: constant),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

