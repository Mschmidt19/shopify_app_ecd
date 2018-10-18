# Shopify App

### By Marek Schmidt

## Tasks
```
1. Create job for generating products
  - Create 6 'Tops' type products (
      'Short Sleeve Crewneck', 'Long Sleeve Crewneck', 'Short Sleeve V-Neck',
      'Long Sleeve V-Neck', 'Short Sleeve Henley', 'Long Sleeve Henley'
    )
    with variants for sizes ('S', 'M', 'L')
    and colors ('White', 'Black', 'Gray', 'Blue')
    and prices of '$15' for short sleeve and '$20' for long sleeve

  - Create 4 'Bottoms' type products (
      'Khaki Shorts', 'Denim Shorts', 'Khaki Pants', 'Denim Pants'
    )
    with variants for sizes ('30', '32', '34', '36', '38', '40')
    and colors ('Blue', 'Black', 'Brown')
    and prices of '$20' for shorts and '$30' for pants

2. Create job for pulling created products from Shopify store and persist into database
  - Limit pulling to 5 products per page so that pagination is required to retrieve
    all products from store
```

## Thought process
I wanted to ensure this app can be tested properly. In order to do this I focused on a few main points other than solving the tasks given. I also made my app an embedded app so that it can be accessed directly from the Shopify Admin panel.  
Once all tasks were accomplished, I ensured that clicking the 'Save all product to database' button will first check if that product is already present in the database. Once that was complete, I realized that additional variants could have been added to an existing product so I added an extra check to ensure these new variants will be added despite the product already existing.  
Lastly, I wanted the user to be able to delete the products from the database themselves so that the list of items won't get overly long when testing. This allows a user to wipe any existing data before trying it with their own app.  
This app is a proof of concept and would not be viable for public use due to using a shared Heroku database rather than a local database specific to each user

## How To Use

### 1. - Visit the app on Heroku
* [ecd-shopify-app](https://ecd-shopify-app.herokuapp.com/)

### 2. - Enter the URL of your Shopify store
* ![Entering Shopify URL](https://i.imgur.com/RSk6vef.jpg)

### 3. - Sign in to your Shopify account using your Shopify Email and Password
* ![Entering Shopify Credentials](https://i.imgur.com/CwOCwzE.jpg)

### 4. - Use the app!
#### There are five main components of the app:
* A form to create a new product including variants for size and color
* A button which will save all of your current Shopify products and corresponding variants into the Heroku database (or your local database if this app was instead run locally)
* A button which will clear all products from the Heroku database. This exists so that you can test the app properly
* A list of all products in your Shopify store
* A list of all products and variants that are saved in the Heroku database
* ![The form and two buttons](https://i.imgur.com/uQhb99a.jpg)
#### To add a product fill out the form as shown in the image below
* Enter the product title
* Enter the product type
* Enter the product price
* Enter any sizes you would like to include separated by commas
* Enter any colors you would like to include separated by commas
* Click the 'Create' button
* ![Filled out form](https://i.imgur.com/Tnpb4GU.jpg)
#### Adding a product will add it to the 'Products from shopify' list on the left
* Each product will link you to the product in your Shopify Admin panel for updating
* ![List of Shopify products](https://i.imgur.com/1Qnufu6.jpg)
#### Clicking 'Save all products to database' will add all existing products to the 'Products from rails' list on the right
* Each product will be listed by its title and show the titles of all corresponding variants
* Products are pulled and added in batches of five at a time
* If a product already exists in the Heroku database it will be skipped
* If a product already exists but additional variants have been added, only the new variants will be added to the Heroku database
* ![List of Rails products](https://i.imgur.com/NfeyQ7H.jpg)
#### Clicking 'Delete all products from database' will remove all products from the Heroku database
