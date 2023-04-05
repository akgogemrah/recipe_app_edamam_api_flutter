# Edamam Recipe Api Flutter App



### To see  Screen Record Video of App [Click here](https://disk.yandex.com.tr/i/v3hP8xpqTwF47A).

This project is food recipe app project that users can find recipes based on ingredients and food names.

A few resources to get you started if this is your first Flutter project:

- Edamam  Recipe Search Api is used to fetch food recipes. [Edamam Api](https://www.edamam.com/).
- App has home screen that users can search recipes and displays recipes as list based on search query.
- Users are able to save recipes to their favorites list by tapping a "favorite" button on the recipe details screen.
- Displaying details of recipe if user tap to recipe,recipe detail screen contains the recipe name, ingredients, and recipe image,also i tried to fetch instructions,Api is returning null value for the insructions thats why detail screen does not contains instructions.
- App has a favorites screen that displays a list of the user's saved recipes.
- Users are able to remove recipes from their favorites list by swiping left on the recipe in the favorites list.
- App has  "random recipe" feature that allows users to find a random recipe.
- App has recipe-sharing feature that allows users to share a recipe with their friends via email or social media.

### State Management Solution
- Provider
### Navigation
-  Flutter Navigation  is used to navigate between screens.
### Database
-SQFLITE package is used to adding favorite recipes and reading favorite recipe screen.

## About Edamam Research Search Api
-To fetch ingredients i request from 'ingredientLines'.
-Fetching recipe name, request to 'label'.
-Fetching food calories, request to 'calories'.
### Search query for query='chicken'

<img src="https://github.com/akgogemrah/recipe_app/blob/master/ScreenShots/Screenshot_1680666077.png" alt="alt text" width="400" height="866">


### FavoriteListPage Screenshot
<img src="https://github.com/akgogemrah/recipe_app/blob/master/ScreenShots/Screenshot_1680666530.png" alt="alt text" width="400" height="866">
Users can share their favorite recipes taping on the share button and delete receipt swipping on the left.

### Recipe Details of SearchPage
<img src="https://github.com/akgogemrah/recipe_app/blob/master/ScreenShots/Screenshot_1680665866.png" alt="alt text" width="400" height="866">

- User can add receipt tapping to '+' button.
