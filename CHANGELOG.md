[33mcommit 846eac708859c4bba4cf6e99cc76e82d39887e30[m[33m ([m[1;36mHEAD -> [m[1;32mmaster[m[33m, [m[1;31morigin/master[m[33m)[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Tue Jul 28 00:01:02 2020 +0300

    Massive Update 🎉😄 28/7/2020
    
    - general
        - made the app portrait only to avoid overflow
        - removed debug banner
        - changed appbar theme to make it black and 0 elevation
        - added 'no builds' screen to home page when there's no builds
    
    - finished build edit and build preview screens
        - added perk decks
        - added export/import string options for both screens
        - exported skills card to seperate file
        - added 'editable' variable to skills and perks cards
        - added Icons.dart contains constants of perks names and icon locations
    
    - fixes
        - home page now refreshes when u save or create a new build
        - fixed home screen not updating after searching
    
    - Build.dart
        - added perk variable to Build
        - removed commas from export string

[33mcommit e32ddf45ab99c939966f84a1c8eadb2beaff707f[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Sun Jul 26 21:33:40 2020 +0300

    got rid of print statements in Subtree.dart

[33mcommit a69b8451584f9504ffc0057cae8a138f60b98497[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Sun Jul 26 21:25:31 2020 +0300

    - changed font to Roboto
    - fixed mastermind images
    - moved homePage to a sperate file
    - added a buildEdit page
    - added a skillTree widget: used to display one of the five trees depending on the index (1 to 5)
    - fixed some bugs with the Build and Subtree classes

[33mcommit 99e97b6154a8e8ac419383dc6c3fdb878ff96526[m
Merge: 7fc0635 6854ef6
Author: Laith Shono <lshono8@gmail.com>
Date:   Sun Jul 26 02:20:54 2020 +0300

    Merge branch 'master' of https://github.com/ElforL/Payday2-builds-app

[33mcommit 7fc0635a722d6bd08b8aecbac786547c46e81373[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Sun Jul 26 02:20:26 2020 +0300

    added 'getExportString' function

[33mcommit 6854ef64447e41442450309c36a6cfadf2d6bfef[m
Author: Elfor <lshono8@gmail.com>
Date:   Sat Jul 25 20:37:06 2020 +0300

    updated README

[33mcommit 65172c55c610d82e681d63b7ead93904d70bf8f0[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Sat Jul 25 20:33:55 2020 +0300

    changed tiles list, detailes in preivious commit

[33mcommit e475fcfc4cf2b182b59564200c08c648873ee69e[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Sat Jul 25 20:26:56 2020 +0300

    - modified Main.dart:
        - tiles  list:
            - renamed to buildsList
            - changed children type to String (to be changed to Build later)
        - HomePage:
            - added a search field
            - switched to Containers insted of ListTiles
        - removed buildPage from Main.dart
    
    - added BuildPreview.dart (empty)

[33mcommit b3bfc0ef169c223e6c6579d5cd64a08627032b2d[m
Author: Laith Shono <lshono8@gmail.com>
Date:   Tue Jul 21 22:18:15 2020 +0300

    pushing all files from local
