# ecom_app

This is an Ecommerce app called Cheapify which allows user to explore available product, add product to cart, make online payment using Esewa.
All the data shown are dynamic which i have fetched from dummyjson api.
Key Fetures of this Project includes:
💡- Interactive UI.
💡- Bloc for state Management.
💡- Dummy json api for Authentication and showing dynamic data.
💡- Shared Preference for storing light data.
💡- SQflite for Offline Database.
💡- Esewa for online payment Integration.
   
I'll provide details about this project below:


    1: At first i have created the folder structure for this project.
   This is a clean architecture structure which is divide into:
   - Core
   - Features
   - Widget
   -Inside of Core it is divide into:
   - bloc
   - common
   - constants
   - extension
   - flavor
   - mixin
   - routes
   - services
   - utils
   - Inside feature it is divided into:
   - data
   - domain
   - presentation/bloc/screen



    2:I have created a basic login page where i used dummyjson auth API for login.
 
   -This page handles various validation.
   - user must pass correct credentials to login.
   - after successful login users access token is saved in the shared preference to remember 
    user is logged in. Other data is stored in the database using sqflite.
    
    3:Next user navigates to the Dashboard Page.
   - In the Dashboard Page it shows the list of the product that is fecthed from dummyjson API
   - these product data is also saved in the database making it available offline.
   - There is bottom navigation bar which shows DashBoardPage, Cart Page, and Profile page.

    4:After Login User Navigates to Product Screen.
   - Product Screen shows all the list of Available products.
   - AppBar has a search field where user can enter product title or categories to find their desired product.
   - when user taps on the product card it redirects user to the productsDetailScreen.

    5:ProductDetailsScreen 
   - This screen shows the details about the Product such as:
   - price
   - Rating
   - shipping time
   - remaining quantity
   - Add to Cart Button
   - After that selected product is saved with selected quantity in the database.Selected product is also stored in CartScreen.

    6:CartScreen 
   - In this Screen product with selected quantity is shown along with per unit cost of product.
   - Total ProductSummary shows total selected product with total sum Amount.
   - Proceed to CheckOut button when tapped redirects User to the Esewa page.
     
