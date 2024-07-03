import UIKit

class CountryListViewController: UIViewController {
    private let viewModel: CountryListViewModel
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var errorViewController: ErrorViewController?
    
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = CountryList.countries.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupSearchBar()
        setupTableView()
        fetchCountries()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchCountries() {
        viewModel.fetchCountries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.dismissErrorView()
                    self?.tableView.reloadData()
                case .failure:
                    self?.showErrorView()
                }
            }
        }
    }
    
    private func showErrorView() {
        let errorVC = ErrorViewController()
        errorVC.retryAction = { [weak self] in
            self?.dismissErrorView()
            self?.fetchCountries()
        }
        self.errorViewController = errorVC
        addChild(errorVC)
        errorVC.view.frame = view.bounds
        view.addSubview(errorVC.view)
        errorVC.didMove(toParent: self)
    }
    
    private func dismissErrorView() {
        errorViewController?.willMove(toParent: nil)
        errorViewController?.view.removeFromSuperview()
        errorViewController?.removeFromParent()
        errorViewController = nil
    }
}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = viewModel.countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.resignFirstResponder()
        if viewModel.countryHasNilValues(at: indexPath.row) {
            showAlertForNilValue()
        } else {
            let country = viewModel.countries[indexPath.row]
            showCountryDetail(for: country)
        }
    }
    
    private func showAlertForNilValue() {
        let alert = UIAlertController(title: Constants.errorTitle.rawValue, message: Constants.errorDescription.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showCountryDetail(for country: CountryModel) {
        let detailViewModel = CountryDetailViewModel(country: country)
        let detailVC = CountryDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountries(by: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


