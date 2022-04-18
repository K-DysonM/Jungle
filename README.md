# Jungle
A workout app that helps you track your workouts
<p align="center">
  <img alt="LOGO" src="https://user-images.githubusercontent.com/43551312/163849445-914beb12-dbc9-42dd-a68a-a8b3f0c8e520.png" width="25%">
  <p align="center"> A workout app that helps you track your progress in the gym </p>
</p>
<p float="center" align="center">
  <img alt="Mockup1" src="https://user-images.githubusercontent.com/43551312/163851458-81316371-7b06-41c7-bd82-f4dd3da567e6.png" width="30%">
  <img alt="Mockup2" src="https://user-images.githubusercontent.com/43551312/163851460-5bf099ff-0e26-4053-9495-0627d6e55bb8.png" width="30%">
  <img alt="Mockup3" src="https://user-images.githubusercontent.com/43551312/163851461-e36c3e17-8d1f-4b5e-b49a-0f69f84476ba.png" width="30%">
</p>

<b> Things I Learned </b>
- More familiar with Core Data 
- Utilizing semantic colors to support light and dark mode
- Better acquainted with creating UI strictly from Auto-Layout
- Utilizing MVVM to help with code organization
- Creating charts on iOS via Charts swift package
- Making custom models for JSON file reading 
- Ability to make custom CollectionViewCells and TableViewCells

# Updates - Iterations

Iteration 0.15 + 0.16 - CoreData improvements + ViewModel Structs/Classes changes + Bug Fixes - April 14th 

- All of the ViewModels are classes to utilize combine functionality but for a workout template I needed some of
the benefits of structs. Primarily, changing values in the templateVM shouldn't cause lasting changes
to the actual template but just the instance of it being created for a workout. Wasn't able to use structs because
of Combine @Published properties being used so instead implemented NSCopying 
-Added ability to remove sets + entire exercises from your workout using Combine + MVVM

<p float="left">
  <img alt="Remove Exercise" src="https://user-images.githubusercontent.com/43551312/163511788-ba0ad8d5-fd37-4df5-a1f1-773a0a559620.jpeg" width="40%">
  <img alt="Remove Exercise" src="https://user-images.githubusercontent.com/43551312/163511843-f5cb8b84-a554-46ec-9780-667a45f37a69.jpeg" width="40%">
</p>


Iteration 0.14 - Templates + Fixed bugs + Beginning of History Tab - Love the way its coming along so far - April 12th
<p float="left">
  <img alt="Templates" src="https://user-images.githubusercontent.com/43551312/163092623-d178816f-7cad-4660-a96d-edf76ecf462f.gif" width="40%">
  <img alt="Templates" src="https://user-images.githubusercontent.com/43551312/163092771-0eb198db-f134-41bd-a90a-71d6672a5eb9.jpeg" width="40%">
</p>

Iteration 0.131 - UI Improvements + Fixed bugs + MVVM tableview + Add/Delete set functionality - April 8 
<p float="left">
  <img alt="Add/Delete Sets" src="https://user-images.githubusercontent.com/43551312/162258968-73864f2b-9ce1-4d2b-9999-3503c8f687a0.jpeg" width="50%">
</p>

Iteration 0.13 - "Start Workout" tableview + beginning of coredata - April 6th
<p float="left">
  <img alt="Start Workout" src="https://user-images.githubusercontent.com/43551312/162034833-bc3fdd53-a11a-4de1-9e20-550a278d8d49.gif" width="50%">
</p>

Iteration 0.121 - Refactoring and UI improvements on charts - April 5th
<p float="left">
  <img alt="Charts" src="https://user-images.githubusercontent.com/43551312/161784099-0920b3de-87a0-4ae1-9857-9f7ee3b92c2d.PNG" width="50%">
</p>

Iteration 0.12 - Search functionality and front end for charts - April 4th
<p float="left">
  <img alt="Search" src="https://user-images.githubusercontent.com/43551312/161467337-edee3829-e172-4e08-8327-7360198aae3f.gif" width="50%">
</p>

Iteration 0.11 - April 3rd
<p float="left">
  <img alt="FirstScreen" src="https://user-images.githubusercontent.com/43551312/161409931-e3ead3a4-54aa-4a52-8279-fe9e0b9eef77.jpeg" width="50%">
</p>

Initial Iteration 0.1 - April 1st
<p float="left">
  <img alt="FirstScreen" src="https://user-images.githubusercontent.com/43551312/161350034-aa210e15-f66f-4b1b-9d68-fb8c05608602.jpeg" width="50%">
</p>


