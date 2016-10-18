suite of tools built for use as Rundeck "plugins".  may also be called from './cli'

Rundeck plugin developer guide -> http://rundeck.org/docs/developer/plugin-development.html

Plugin directory structure

[name]-plugin.zip
\- [name]-plugin/ -- root directory of zip contents, same name as zip file
   |- plugin.yaml -- plugin metadata file
      \- contents/
            |- ...      -- script or resource files
                  \- ...
