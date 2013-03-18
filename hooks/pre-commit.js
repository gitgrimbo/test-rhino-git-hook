var filename = arguments[0];
if (!filename.match(/\.js$/)) {
    // ignore files not ending with ".js"
    quit();
}
// jshint looks at the arguments object to find the filenames.
// There will be one in our case
load("./.git/hooks/jshint-rhino-1.1.0.js");
