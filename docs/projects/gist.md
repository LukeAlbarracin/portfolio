# Developer Automation Tool for Clojure
[Source: Github Gist link](https://gist.github.com/5c366a3e9be836bf63570015a292a0a9)
<p>This problem occurred to me in high school, when we were allowed to borrow school computers from the library. Not knowing the password but wanting to program during my free periods in Clojure, it required me admin access to run install commands such as homebrew. To get around this, I used a similar technique to install pip3 that I had used before, taking advantage of the .bashrc profile while grabbing a self-install script. </p>
```
1. Make a new directory called "bin" in the home (~) folder : mkdir ~/bin
2. Download the self-install script for Leiningen : curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ~/bin
3. Create your .bashrc file if not already created : touch ~/.bashrc
4. Edit the path in your favorite editor to : PATH=$PATH:~/bin
5. Confirm the changed path using the command : source ~/.bashrc
6. Test out the newly installed Leiningen with : lein new app hello-world
```