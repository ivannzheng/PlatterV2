# Platter
Find, filter, and share recipes with a community of cooks!

[Demo Video](https://drive.google.com/file/d/1jq-2TaqbgcLjdmK009_M_9FkhBhwwPBF/view?usp=sharing)

[Designs](https://www.figma.com/design/IY607DHT0Dp7k0NHTI1qEs/AppDev-Hack-Challenge-FA-'24?node-id=36-87&t=ExTSXUPw6uJYctGA-1)

![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)

## Description
Platter incorporates recipe information with interactive features for cooks, offering a comprehensive platform where users can explore dishes and engage with a cooking community.

### Features

#### Home Page

Platter's home page displays three sections that, in theory, would showcase recipes corresponding to each section's name. There is "Recommended For You," which would recommend daily recipes based on the cooking interests users input during onboarding but is also accessible on the profile screen. "Just in Season" would suggest recipes based on upcoming holidays or events. "Explore More" would offer additional recipe suggestions. Each section features a horizontally scrollable view, displaying an image of the dish, its name, and whether the user has bookmarked it. Users can click or tap on any recipe cell to navigate to a detailed view of the recipe, which includes its name, an image, ingredients, instructions, and the option to bookmark it.

#### Search Bar

When clicking on the search bar icon on the top right of the home screen, Platter displays a list of recent recipe searches and filtered categories for sorting recipes. A user can click or tap on a category (vegetarian, meats, grilled, healthy, soups) to view recipes that fall under that category.

#### Groups Page

In theory, users would be able to join specific groups or cooking communities. In each group, users could see a feed of posts sharing cooking accomplishments, asking questions, giving suggestions, and more. They could also create their own posts.

#### Profile Page

The profile page shows a user's profile picture, name, username, interests (which could be used for "Recommended For You"), and saved posts. When a user saves a post, it appears on their profile. The name and username can also be edited.

## Hack Requirements:

### Design

[Figma](https://www.figma.com/design/IY607DHT0Dp7k0NHTI1qEs/AppDev-Hack-Challenge-FA-'24?node-id=36-87&t=ExTSXUPw6uJYctGA-1)

### iOS
- Multiple screens that you can navigate between: 9 screens to navigate between: navigation bar, home page, detailed recipe view, search bar, filter categories, groups page, create a post, profile, edit profile
- At least one scrollable view: 5 scrollable views: recipes on home page scroll horizontally, filters in search bar scroll horizontally, groups page scrolls vertically, different group names scroll horizontally, saved recipes on profile page scroll vertically
- Networking integration with a backend API: was not given backend url, used dummy data, and put "placeholder" in NetworkManager

### Backend
- At least 4 routes (1 must be GET, 1 must be POST, 1 must be DELETE): Get recipes route, post recipes route (which adds a recipe to the recipe database), and a delete recipe route (which removes it)
- At least 2 tables in database with a relationship between them: The recipes table and the saved recipes table: when a user saved a recipe, it would also be added to the saved recipes table
- API specification explaining each implemented route

## Screens
Home Screen:

<img src="https://github.com/user-attachments/assets/554aade7-29ce-4004-ab9d-6f799275c157" width="300" />

Detailed Recipe:

<img src="https://github.com/user-attachments/assets/c99a2c75-c42a-4ced-909a-616407f11476" width="300" />

Search:

<img src="https://github.com/user-attachments/assets/d6cc4063-d2df-4942-a80b-513a475c351e" width="300" />

Filter:

<img src="https://github.com/user-attachments/assets/06637a4f-59ce-42aa-9e19-47d1381b95d5" width="300" />

Groups:

<img src="https://github.com/user-attachments/assets/bcf394e8-3237-4627-8fe6-3668d3a9c246" width="300" />

Create a Post:

<img src="https://github.com/user-attachments/assets/2a984988-13cb-4b63-b554-f15dd2a61905" width="300" />

Profile:

<img src="https://github.com/user-attachments/assets/b5885d3f-97f5-41d5-8373-2d36eb3efc3e" width="300" />

Edit Profile:

<img src="https://github.com/user-attachments/assets/28d438f2-c89b-4094-9433-269cd09a908c" width="300" />


