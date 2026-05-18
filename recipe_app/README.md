# Recipe App

Recipe App is a cross‑platform mobile application that allows users to browse, search, and view recipes categorized by type, with detailed instructions and ingredient lists. It includes authentication, personalized favorites, daily recipe suggestions, and push notifications.

---

## Table of Contents
- [Authentication](#authentication)
- [Home Screen](#home-screen)
- [Categories](#categories)
- [Meal Details](#meal-details)
- [Profile](#profile)
- [Favorites](#favorites)
- [Notifications](#notifications)
- [Tech Stack](#tech-stack)

---

## Authentication
- Built with **Firebase Authentication**  
- Includes **Login** and **Register** screens  

<p align="center">
  <img src="recipe_app_images_lab3/RegisterScreen.png" alt="Register Screen" height="550"/>
  <img src="recipe_app_images_lab3/LoginScreen.png" alt="Login Screen" height="550"/>
</p>

---

## Home Screen
- Displays a catalog of food categories.
- Includes a **search bar** to quickly find categories.  
- Features a **Random Recipe button** that opens the Meal Details screen with the recipe of the day.  
- Contains a **drawer** with navigation options: Home, Profile, Favorites, Logout.  

<p align="center">
  <img src="recipe_app_images_lab3/Drawer.png" alt="Drawer" height="400"/>
  <img src="recipe_app_images_lab3/OpenedDrawer.png" alt="Opened Drawer" height="400"/>
  <img src="recipe_app_images/RandomMealButton.png" alt="Random Meal Button" height="400"/>
  <img src="recipe_app_images/RandomRecipe.png" alt="Random Recipe" height="400"/>
</p>

---

## Categories
- Clicking a category opens a list of meals belonging to that category.  
- Users can:
  - Search for recipes within the category  
  - Like recipes  
  - Access the random recipe of the day  

<p align="center">
  <img src="recipe_app_images/CategoryScreen1.png" alt="Category Screen 1" height="400"/>
  <img src="recipe_app_images/CategoryScreen2_HorizontalScroll.png" alt="Category Screen Horizontal Scroll" height="400"/>
  <img src="recipe_app_images/CategoryScreen4_Searchbar.png" alt="Category Screen Searchbar" height="400"/>
  <img src="recipe_app_images_lab3/AddedToFavoritesFromMealScreen.png" alt="Added to Favorites from Meal Screen" height="400"/>
</p>

---

## Meal Details
- Displays full details of a selected recipe.  
- Users can:
  - View ingredients and instructions  
  - Add the recipe to their favorites  
  - Access the random recipe of the day  

<p align="center">
  <img src="recipe_app_images_lab3/AddedToFavoritesFromMealDetailScreen.png" alt="Added to Favorites from Meal Detail Screen" height="550"/>
</p>

---

## Profile
- Simple profile screen showing the user’s email address.  
- Includes a **Logout button** to sign out.  

<p align="center">
  <img src="recipe_app_images_lab3/ProfileScreen.png" alt="Profile Screen" height="550"/>
</p>

---

## Favorites
- Displays all meals the user has liked.  
- Allows users to manage their favorite recipes.  

<p align="center">
  <img src="recipe_app_images_lab3/UpdatedFavoritesScreen.png" alt="Updated Favorites Screen" height="550"/>
</p>

---

## Notifications
- Sends a **daily push notification** reminding users to check out the recipe of the day.

<p align="center">
  <img src="recipe_app_images_lab3/NotificationFromApp.png" alt="Notification From App" height="550"/>
</p>

---

## Tech Stack
- **Flutter** (cross‑platform development)  
- **Firebase Authentication & Firestore**  
- **Provider** for state management  
- **Dio** for API requests  
- **MVVM Architecture** with modular repositories  
- **Push Notifications** via Firebase Messaging  

---
