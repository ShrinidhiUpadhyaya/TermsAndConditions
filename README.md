**Easy way to create a License Agreement Screen or a Terms and Conditions Screen for Android**

So basically the necessity of such screens is to make the user read the terms and conditions of the app or the company and once the user accepts the terms and conditions, that screen should not be shown again. We are going to make use of something called as **Settings** in qml.

So **Settings** basically allows you to save and restore the application settings value.The Settings type provides persistent platform-independent application settings. You can read more about settings [from.](https://doc.qt.io/qt-5/qml-qt-labs-settings-settings.html)

To include Settings inside your Qt project you need to include two things:-
* The Application Name and the Organisation Name.

,,,

    QCoreApplication::setApplicationName("TermsAndConditions");
    QCoreApplication::setOrganizationName("OpenSource");
    
,,,
    
**Note:-** If you dont include this you will not be able to initilize settings and you will get some errors like this

'''

     QML Settings: Failed to initialize QSettings instance. Status code is: 1
     QML Settings: The following application identifiers have not been set: QVector("organizationName", "organizationDomain")
    
'''

* You need to import this **import Qt.labs.settings 1.1** in your QML file.

**Steps:-**
* So first we are going to create a variable of settings something like this:-

'''

    Settings {
        id: settings

        property bool termsAndConditionsAgreed: false
    }
    
'''
 
* Next place the content you need in the Content.txt file. I have placed some random content from [here](https://en.wikipedia.org/wiki/Qt_(software))
* When you launch the app for the first time you will this screen!
<p align="center">
    <img src="https://user-images.githubusercontent.com/8769408/118407906-82c67980-b6a0-11eb-882d-a158e3cca632.jpg" width="200" height="400"/>
</p>

* Once you read the complete Terms and Conditions, the 'I accept' checkbox will be enabled
<p align="center">
    <img src="https://user-images.githubusercontent.com/8769408/118408048-50694c00-b6a1-11eb-9a2d-7ea70c71f276.jpg" width="200" height="400"/>
</p>

* You need to check the checkbox after which the "Agree" button will be enabled!
<p align="center">
    <img src="https://user-images.githubusercontent.com/8769408/118408115-9faf7c80-b6a1-11eb-97cb-f6c129a5a754.jpg" width="200" height="400"/>
</p>
* Once you click the agree button you will be taken to the main app screen.

So when you click the agree button we make "termsAndConditionsAgreed" as true. So from the next time whenever you open the app you will directly go into the main app screen.

'''

    onClicked: {
                  settings.termsAndConditionsAgreed = true;
               }
            
'''

<p align="center">
    <img src="https://user-images.githubusercontent.com/8769408/118408119-a3db9a00-b6a1-11eb-89ca-547125d1eac5.jpg" width="200" height="400"/>
</p>
    
**Note:-** You can go to Settings->Apps->TermsAndConditions->ClearData and clear all the data including apps and once again the when you open the app it will show you the Terms And Conditions Screen.
