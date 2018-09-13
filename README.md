# iOSimple

## Installation:
Install by adding the **iOSimple** folder into your project

## Usage:

Import **"iOSimple.h"** into your project where needed.

## Extensions

Let's say i'm coding from a UIViewController class.. I could import the iOSimple+UIViewController.h class and use [self "classMethod"] - because "self" is an extension of a UIViewController.

- **iOSimple+UIButton**
*Easily add a growing animation and action to a custom UIButton*

- **iOSimple+UIColor**
*Convert HEX text into a UIColor object. Also a function for colorWithRed... without having to supply the (x/255) everytime - just use the float value of the colour.*

- **iOSimple+UIMapView**
*Search and zoom, geocode an address string into a CLLocation, remove all annotations, zoom to custom location, zoom to current location, add annotations and more.*

- **iOSimple+UINavigationController**
*For custom UINavigationController pops and pushes. Currently only supports flip and fade.. but feel free to add more and lookout for upcoming ones to this class.*

- **iOSimple+UIScrollView**
*Scroll to the bottom, get the current page, set a sticky header (a UIView / UIImageView that sticks to the top and stretches like it's being pulled - Twitter is an example). Also includes a function for easily adding a UIRefreshControl action.*

- **iOSimple+UITextField**
Set a placeholder colour, easily add padding to a UITextField.

- **iOSimple+UIViewController**
*Handy for adding NSNotificationCenter handlers without having to call "[[NSNotificationCenter defaultCenter] addObser....]" .. now just call "[self addHandlerWithName:name selector:selector]". Also support for posting notifications and removing them all.*

- **iOSimple+UIView**
*Easily set auto resizing masks. I often use "[myView setResizingMask:MaskTypeFull]" if i want to make a UIView object fully stretchable and adjusts to all corners, etc. Another great feature of this class... is adding a "magic button".<br>
Instead of creating a hidden UIButton object, setting up it's targets.. adding the functions.. just call [myView addMagicButtonWithAction:SEL sender:sender] - this will add a UIButton that will automatically stretch, and grow / shrink when selected. SO handy.<br>
Find a UIView object with an identifier (set the restoration id in the storyboard file).*

<hr>

These classes can be initialised as objects, some of them also have class methods to simplify things.

-  **iOSAlert**
*UIAlertController simplification - easily present alerts, add buttons to alerts. etc.*

- **CGExt / CGeometry**
*CGRect extensions for easy resizing, positioning and calculations*

- **Finder**
*Easily find the highest ViewController, or a UINavigationController / UIViewController of a UIView object. Comes in handy when using subclasses of UIView objects.*

- **Haptic Helper (YANIK)**
*Generate haptic feedback for supported devices - supports: selection, impact light, impact medium, impact heavy, notification success, notification warning, notification error.*

- **iOSReachability**
*Check if internet connection is reachable.*

- **Keyboard Helper**
*Useful for detecting the keyboard size of any device - instead of using notifications throughout subclasses.. just use 1 and optionally store the keyboard size to use globally.. without calling it over and over again.*

- **Location Manager**
*Handy for fetching a users current location, converting locations to CLPlacemarks (where you can extract information on the country, city, street, etc), also supports converting an NSString address to a CLPlacemark, and getting the distance between 2 locations.*

- **Push Handle**
*Handles registering the device for remote push notifications (APNS) - also with optional completion handler, and delegate methods for when a notification is presented, and tapped.*

- **Share Handler**
*Presents a UIActivityViewController with a given NSArray of objects (NSURL, NSString, UIImage, etc). Comes in handy when somebody taps a share button.*

- **Growing Text View**
*Basically what it says in the title. This comes with a .xib file that you can customise (remember to update the height in the .m file). Usefull for having a UITextView that could be dropped in a "new message" screen where a user will be displayed 1 line of text, then when they start typing.. it expands vertically.*

- **TouchID**
*Check whether a device supports TouchID, and includes a method to authenticate with TouchID - with completion handlers error / success / invalid.*

- **Validator**
*Scan for arrays, strings, whatever inside of dictionaries NSDictionary's/NSArray's. This checks to see if they're not NULL or checks the lengths (if it's a string) or checks the array count (if it's an array or a dictionary - then it'll check the dictionary key count). Also includes functions for converting an NSDate into a string (with optional extra's), and validating an NSString to an NSDate.*

<hr>

- **Drop Down View**
*UIView subclass - click on this and it will present a list of dropdown options that are customisable in .xib format.*

<hr>

## Credits
<a href="https://github.com/iosdec">Declan Land</a>
