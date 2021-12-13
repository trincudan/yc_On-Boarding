## Java Multi-Version

I've downloaded 3 versions of Java (17,16 and 15), I unzipped them in '''/opt''' folder, then i added the following aliases:

'''
alias java17='/opt/jdk-17.0.1.jdk/Contents/Home/bin/java'
alias java16='/opt/jdk-16.0.2.jdk/Contents/Home/bin/java'
alias java15='/opt/jdk-15.0.2.jdk/Contents/Home/bin/java'
'''

Now we can run the command `java[17,16,15] --version` to test and it's working as it should.
