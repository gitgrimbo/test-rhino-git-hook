test-rhino-git-hook
===================

Experiment to use Rhino and Javascript in Git pre-commit hooks. The hook will invoke the linting provided by www.jshint.com.

The following file paths are all relative to the repo folder.

Copy `./hooks/pre-commit` to `./.git/hooks`. This is a Bash script that will invoke Rhino.

    #!/bin/sh

    if git-rev-parse --verify HEAD >/dev/null 2>&1; then
        against=HEAD
    else
        against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
    fi
     
    # Redirect output to stderr.
    exec 1>&2

    # Set this to where your Rhino jar is.
    # Mine is on a Windows machine running Git Bash.
    RHINO_JAR=/C/java/rhino1_7R4/js.jar

    # For each changed file, run pre-commit.js via Rhino.
    # This could be slow, executing java/Rhino once per file.
    # Maybe we could pass all the changed files to pre-commit.js?
    for FILE in `git diff-index --name-only $against --` ; do
        echo $FILE
        java -classpath $RHINO_JAR org.mozilla.javascript.tools.shell.Main -opt 0 ./.git/hooks/pre-commit.js $FILE
        rc=$?
        echo "return code " $rc
        if [[ $rc != 0 ]] ; then
            exit $rc
        fi
    done

    echo "All good!"

    exit


Copy `./hooks/pre-commit.js` to `./.git/hooks`. This is a JS file that will load JSHint.

    var filename = arguments[0];
    if (!filename.match(/\.js$/)) {
        // ignore files not ending with ".js"
        quit();
    }
    // jshint looks at the arguments object to find the filenames.
    // There will be one in our case
    load("./.git/hooks/jshint-rhino-1.1.0.js");

Copy `http://www.jshint.com/get/jshint-rhino-1.1.0.js` (or later version) to `./.git/hooks` (there is already a copy there for your convenience). This will perform the linting.
