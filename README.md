# TROOP

iOS deployment to [TestFlight](http://testflightapp.com) with the [betabuilder](http://rubygems.org/gems/betabuilder) gem.

## Installation

Simply install the gem:

    gem install troops

### Configuration files

There are 2 kind of configuration files, there needs to be a global file & file defined for each project. The files are always named `.troop` and resides in your home folder (for the global file) or in your project folder (for the project dependent file).

### Global file

This `.troop`-file only needs to contain your API Token from TestFlight. You can find this token on the 'Your Account' page. Here is how the file needs to be formatted:

    api_token: "thisismymegaawesometoken"

### Project file

The project's '.troop' file contains the Team Token from your TestFlight Team. and some environmental properties that you can change. The Team Token can be found on the Team Info page.

Next to the token there are some other setting that you can define such as the environment you wish to deploy to (ex. Ad Hoc, Release...), or you can specify the target.

    team_token: "thisismyawesometeamtoken"
    
    staging:
        target: "My App"
        environment: "Ad Hoc"
    
    production:
        target: "My App"
        environment: "Release"

Add this file to your project folder.

## Usage

### Archive builds

Archive your application by running the following command:
    
    troop archive

This always uses the staging 'environment' to build the correct target. You can specify an environment by adding it as an argument:

    troop archive production

### Deploy to TestFlight

Deploy your application by running the following command:
    
    troop deploy

This always uses the staging 'environment' to build the correct target. You can specify an environment by adding it as an argument:

    troop deploy production

This command doesn't archive the build, if you want to archive while deploying, add the `--archive` argument.

    troop deploy production --archive
    
## Copyright

Copyright (c) 2011 Jelle Vandebeeck. See LICENSE.txt for further details.
