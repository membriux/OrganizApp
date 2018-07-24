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
  - `organizationsManaging: String`
  
- `Organization` Firebase Data Model
  - `organizationID: String`
  - `email: String`
  - `calendarEmail: String`
  - `location: Array`
    - `streetAddress: String`
    - `city: String`
    - `state: String`
    - `zip: String`
  
- `Post` Firebase Data model
  - `organizationUsername: String`
  - `images: [String]`
  - `time: Date`


## Views
- `HomeView`
  - `PostsTableViewCell`
- `CalendarView`
- `UpcomingEventsTableView`
  - `UpcomingEventsTableViewCell`
- `SideMenuTableView`
  - `SideMenuTableViewCell`
- `AddOrganizationView`
- `AdminView`
- `OrganizationSettingView`

## Controllers
- `HomeViewController`: Display posts/news feed about the organization.
  - `PostsTableViewCell`: Cell containing the post along with a description, date it was posted, and maybe some pictures.
- `CalendarViewController`: Calendar displaying the month and the events that are ocurring that month. Data pulled from calendar email.
- `UpcomingEventsTableViewController`: Shows the upcoming events pulled from calendar.
  -`UpcomingEventsTableViewCellController`: Contains date, title, location, and description of the event.
- `SideMenuTableViewController`: Displays the organizations that the user is involved in and a button to add organizations to the list.
  - `SideMenuTableViewCellController`: Contains the organizationID.
- `AddOrganizationViewController`: Allows user to input organizationID and add it to their list of organizations that they are involved with.
- `AdminViewController`: Allows the admin of the organization to create a post and modify/update information about the organization
- `OrganizationSettingsViewController`: Set the contact information of the organization

## Other
- Services
  - Firebase Service (Authentication)
  
- APIs
  - Google Calendar API

- Helpers: 
  - CreateAdminUser
  - CreateAnonymousUser
  - CreateOrganization
  - CreatePost 
  - RetreivePosts
  - RetrieveEvents
  - AddOrganization
  - UpdateOrganizationInfo
  - DeletePost
  - DeleteOrganization

# Weekly Milestone
## Week 4 - Usable Build
[List of tasks needed to be complete before you can start user testing]
- [Monday] Finish creating design document
- [Tuesday] Finish Create helpers
  - Be able to create an admin account, anonymous user, organization, and posts
- [Wednesday] Be able to retrieve organizations and their posts.
  - Allow anonymous user to add organizations to his list 
  - Allow anonymous user to delete organizations from his list
- [Thursday] Update organization contact information and be able to delete organizations
  - Retrieve information and add it to the contact information
- [Friday] Retreive google calendar events from google account
- Display all information in a more nicely fashion


## Week 5 - Finish Features
[List of tasks to complete the implementation of features]
- Create UI for the organization news feed
  - Polish it so that it looks somewhat nice
- Create UI for events page
- Create Slide Menu and display the organizations that the user is involved with
- Add button for "Add Organization" and add it to the table
  - Take you to the "add organization" view it on the user's list of organizations
- Create UI for admin page and for organization editing page

## Week 6 - Polish
[List of tasks needed to polish and ship to the app store]
- Learn how to ship to the appstore
- Add animations
- Find the right color scheme
- Get user testing and make sure there are no errors


