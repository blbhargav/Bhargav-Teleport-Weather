# teleport_weather_bhargav

Interview Assignment.

To build an app that can show the current weather and 5 days forecast. Along with default cities/places user can also add new cites.

Using BLoC as state management tool. Implemented with MultiBlocProvider.
Check this [Video](https://drive.google.com/file/d/1VnWhlmatXPgKb8is4ClfE-QHe2JA8ekp/view?usp=sharing) to understand how this app works.
Project [APK](https://drive.google.com/file/d/1M7j0oUuHbLMyilHUYZpgouGb1Z1lbUCw/view?usp=sharing). No login required. Only location permission needed when asked to fetch location.
## Getting start

#### Splash Screen
<img src="/screenshots/Splash.jpg" width="150">

Just a welcome screen. Used flare animation.

#### Home Screen
<img src="/screenshots/Home.jpg" width="150">

The home screen contains 4 main sections. Pulling down the from top will make the screen to refresh.
1. Cities Corousal/Tabs
   * Here all the default cites along with user added cities/places will be listed.
   * We can scroll horizontally and select any one of these cities.
   * By Default first item will be pre-selected.
2. Current Weather of the selected city.
    * Current weather details of the selected city/place will be displayed.
    * Clicking on "See Details" button will take you to "Weather Details" screen where full details of weather are displayed.
3. 5 days Weather forecast of the selected city.
    * In this section weather forecast for next 5 days will be displayed for the selected City/place.
4. Bottom Navigation panel.
    * Navigation panel for easy access.
    * Contails "Home/Dashboard", "Cities" and "Settings" menus.
5. Floating Action Button with Location Icon
    * Clicking on it will fetch user current location and also refreshes the screen with user location weather details.

#### Weather Details Screen
<img src="/screenshots/weather_details.jpg" width="150">
This page contains more details about the current weather of the selected city/place. Clicking on left arrow on top of the screen or device back button will navigate back to Home page.

#### Cities Screen
<img src="/screenshots/my_cities.jpg" width="150">
Clicking on bottom navigation panels menu "CITIES" will navigate to this page. Here all the default cities will be listed. Lastly user added cities will be appended to default cities.
In this screen a Floating Action button is there. It is used for adding new city to the app.
###### How to add new city?
Click on the Floating action button in Cities page. A popup will appear just like the below image.
<img src="/screenshots/add_new_city.jpg" width="150">

Here Enter the new city name. Click submit. Then the new city will be added to list of cities. Scroll down the cities list to see the newly added city. In home screen too the new city will be appear at the end of the cities list.
> Note:- Entering the already existing city name will give error. This is done to restrict duplication of data.

#### Setings Page
<img src="/screenshots/Settings.jpg" width="150">
Clicking on bottom navigation panels menu "SETTINGS" will navigate to this page.
Here 2 options will be there. One is "Light" and another is "Dark". By default "Light" will be selected.
The purpose of these options it to change the app theme. Click on "Dark" option to see the magic. Our app screen colors will change to dark(see below image).
<img src="/screenshots/Home_dark.jpg" width="150">
You can undo this operation by selecting "Light" option if you don't like this theme 😔.

That's it. I have recorded all these things in a [Video](https://drive.google.com/file/d/1VnWhlmatXPgKb8is4ClfE-QHe2JA8ekp/view?usp=sharing).
Install the [APK](https://drive.google.com/file/d/1M7j0oUuHbLMyilHUYZpgouGb1Z1lbUCw/view?usp=sharing) and check my app.

Thank you for reading.