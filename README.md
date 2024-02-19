
A Swift UIKit project that follows the VIPER design pattern, featuring login and home views designed using storyboards, and using URLSession for networking. This project also integrates Firebase Analytics for tracking user interactions, SwiftLint for code style consistency, and localization for internationalization.

### Login 
The Login is responsible for user authentication. It includes a user interface for entering email and password, interaction handling, and communication with the server for authentication. 
- LoginViewController: Manages user interactions, including email and password input, and initiates the login process.
- LoginPresenter: Coordinates user interactions and communicates with the LoginInteractor.
- LoginInteractor: Handles the business logic of user authentication and communicates with the NetworkManager for network requests.
- LoginRouter: Handles navigation within the Login module. It is responsible for transitioning to the home screen upon successful login. This router coordinates the creation of the Login module and provides navigation to other parts of the application.

### Home

The Home is responsible for displaying lists of data using UICollectionView. 
- HomeViewController: Manages the user interface for the Home screen, displaying product lists in multiple collection views. It loads and displays product data retrieved through the interactor, handling user interactions and providing user feedback through alerts.
- HomeInteractor: Acts as a bridge between the presenter and the network manager, fetching product data for different collection views. It utilizes user tokens for secure data requests.
- HomePresenter: Coordinates actions between the view and the interactor. It initiates data requests, handles errors, and communicates with the view.

