# QuizWebsite for CS108

To start a branch for your own code:

1) First `git clone https://github.com/MasonStricklin/QuizWebsite.git`

2) Then do `git pull origin master` from within the project directory

3) Then create your own branch via `git checkout -b "your_branch_name"`

4) Now you are working on your own branch. Use `git commit -am "commit message"` to commit whenever needed
    4.a) Whenever you add a new file, you have to run `git add path/to/file`
    4.b) -a flag: whenever you change a file you also have to run `git add path/to/file`, or you can just
         use the -a flag whenever you commit
    4.c) -m flag: this flag allows you to pass in the commit message as an argument in quotes

5) If `git commit` tells you there are untracked files, run `git add path/to/file` on all the files it list. Then do step 4 agains

--

When you are ready to push your code up for review:

1) Run `git pull origin master`to make sure your branch has all the code from the master branch (this happens when someone changes master while you were working on your branch). You may need to manually solve merge conflicts. `git status` will show you all of the merge conflicts

2) Make sure to run `git commit -am "final commit message"` to commit one last time

3) Run `git push origin "your_branch_name"` to push your branch up into the interwebs

4) Go to this url to create a pull request for your branch: https://github.com/MasonStricklin/QuizWebsite/compare?expand=1

5) Create the pull request with base=`master` and compare=`your_branch_name` and leave a description so teammates can review the code

6) When everyone has reviewed it, we can hit the merge button

--

Other things:

1) If you commit, then write some garbage code, you can undo the garbage code with `git stash`. This only works if you haven't committed the garbage code

2) For small updates, just merge directly to master. Pull requests are good for bigger chunks of code though
