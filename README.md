## OrganizApp
iOS App that allows organizations to keep in touch with their members. What makes this app different is that members of organizations do not need to create a username/email account. This is useful for people who don not wish to create a social media/user account to keep in touch with their organization!

## Audience
People who want to stay in touch with their organizations but don't want to go through the hazzle of creating a username/social media account.

## Experience
As soon as the app launches, the user is taken to the home page, where there is a news feed posted by their organization that they are involved in. They can view the calendar of the organization and view the upcoming events as well. The best part about this is that the user never had to sign in to view all the things mentioned previously! We are aware that users are involved in more than one organization; they can be involved at their school, sports team, local church, support group, and more! To switch between organization, they can go on the slide menu and add/choose the organization that they want to view. The only ones who need to sign in/create an account are the administrators of organizations.

# Technical
## Models
- `Administrator` Firebase Data Model
  - `username: String`
  - `email: String`
  - `realName: String`
  
- `Organization` Firebase Data Model
  - `organizationUsername: String`
  - `email: String`
  - `calendarEmail: String`
  - `location: Dictionary/Hashmap`
    - `streetAddress: String`
    - 
  
- `Post` Firebase Data model
  - `organizationUsername: String`
  - `images: String`
  - 


## Views
[What custom views do we need to create? Include pictures of your prototypes/sketches!]

## Controllers
[What controllers will we need? What will they do?]

## Other
[Any other frameworks / things we will need? Helpers? Services?]

# Weekly Milestone
## Week 4 - Usable Build
[List of tasks needed to be complete before you can start user testing]
- task 1
- task 2
- task 3
- [...]

## Week 5 - Finish Features
[List of tasks to complete the implementation of features]
- task 1
- task 2
- task 3
- [...]

## Week 6 - Polish
[List of tasks needed to polish and ship to the app store]
- task 1
- task 2
- task 3
- [...]

