# TROOPS

iOS deployment to [TestFlight](http://testflightapp.com) with the [betabuilder](http://rubygems.org/gems/betabuilder) gem.

## Installation

Simply install the gem:

    gem install troops

### Configuration files

There are 2 kind of configuration files, there needs to be a global file & file defined for each project. The files are always named `.troops` and resides in your home folder (for the global file) or in your project folder (for the project dependent file).

### Global file

This `.troops`-file only needs to contain your API Token from TestFlight. You can find this token on the 'Your Account' page. Here is how the file needs to be formatted:

    api_token: "thisismymegaawesometoken"

### Project file

The project's '.troops' file contains the Team Token from your TestFlight Team. and some environmental properties that you can change. The Team Token can be found on the Team Info page.

Next to the token there are some other setting that you can define such as the environment you wish to deploy to (ex. Ad Hoc, Release...), or you can specify the target.

    team_token: "thisismyawesometeamtoken"
    
    staging:
        target: "My App"
        environment: "Ad Hoc"
        disitribution_list: ["developers"]
    
    production:
        target: "My App"
        environment: "Release"
        disitribution_list: ["developers", "testers"]

Add this file to your project folder.

## Usage

### Archive builds

Archive your application by running the following command:
    
    troops archive

This always uses the staging 'environment' to build the correct target. You can specify an environment by adding it as an argument:

    troops archive production

### Deploy to TestFlight

Deploy your application by running the following command:
    
    troops deploy

This always uses the staging 'environment' to build the correct target. You can specify an environment by adding it as an argument:

    troops deploy production

This command doesn't archive the build, if you want to archive while deploying, add the `--archive` argument.

    troops deploy production --archive

To distribute the build to a disitribution group add the `--distribute` argument. This will send an email to the persons belonging to the distribution list defined in the project `.troops` file.

    troops deploy production --distribute
    
## License

Copyright (c) 2011 Jelle Vandebeeck

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
