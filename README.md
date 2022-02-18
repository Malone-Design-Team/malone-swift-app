# malone-swift-app

An app designed and built by the Malone Design Team in Swift and Storyboards for the Malone Community Center. The app is designed to be easier to use than the website to access specific information, and make it easier to spread Malone curriculum to other movements.

## Development

Xcode is the IDE used for the development of the project. Please make sure you have at least Xcode 13 for proper functionality (other versions are untested).

### Downloading the Repository

The simplest way to test the code is to [download the repository as a ZIP file] onto your computer. However, this is **not a recommended method**, as committing changes back to the repository is very difficult and will not be supported.

If you are comfortable with the command line, using the Git CLI is a very easy option. The following command will clone the repository into a folder called `malone-swift-app`:

git clone https://github.com/Malone-Design-Team/malone-swift-app

Otherwise, if you want something with a graphical interface, I recommend using something like [Github Desktop] (free), or even a third party client like [GitKraken] (free w/ paid upgrade) or [Gitfox] (paid). The method to clone the repository varies with each client, so consult the guide for the client you choose. 

Note: Xcode does have built-in Git cloning support, but it is very simplified and as such is **not recommended** for use with this repository.

### Editing

To open the project in Xcode, open the `malone-swift-app.xcodeproj` file by double clicking it (or, if Xcode is already open, choose *Open a project or file* and click the `malone-swift-app.xcodeproj` file).

### Committing Code

To commit code back to the repository, first make sure all files are saved and Xcode is closed.

If you are using Git CLI, you can use the following commands to commit and push your code:

git commit -am "Commit message"
git push

This will commit all changed files to the local git repository, and then push those back to the origin (Github). **Please make sure to write a descriptive commit message.**

If you’re using a graphical app, the procedure will vary based on the app. Just make sure you perform the following actions:

- **Stage** all changed files
- **Commit** the staged files to the local git repository
- **Push** the commit to the origin
