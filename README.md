# ecom_app

This is my practice project where i'm trying various RESTful API's from Dummyjson.
I'll provide details about this project below:

1: At first i have created the folder structure for this project.
   This is a clean architecture structure which is divide into:
   - Core
   - Features
   - Widget
Inside of Core it is divide into:
   - bloc
   - common
   - constants
   - extension
   - flavor
   - mixin
   - routes
   - services
   - utils
Inside feature it is divided into:
   - data
   - domain
   - presentation/bloc/screen

2: I have created a basic login page where i used dummyjson auth API for login.
    -This page handles various validation.
    - user must pass correct credentials to login.
    - after successful login users access token is saved in the shared preference to remember 
    user is logged in. Other data is stored in the database using sqflite.
3: Next user navigates to the Dashboard Page.

  Rest of the details to be continueed....
