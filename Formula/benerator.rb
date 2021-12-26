class Benerator < Formula
  desc "This formula installs the GPL'd Community Edition of the Benerator test data generator"
  homepage "https://www.benerator.de/"
  url "https://github.com/rapiddweller/rapiddweller-benerator-ce/releases/download/2.0.0/rapiddweller-benerator-ce-2.0.0-jdk-11-dist.tar.gz"
  sha256 "5e49f2427d8cc20212a5f65944c5a35fb31f98f7403fe1333761aec43ddaf310"

  depends_on "openjdk"

  def install
    # Remove unnecessary files
    rm Dir["bin/*.bat", "bin/pom.xml"]

    # Installs only the 'bin' and 'lib' directories from the tarball
    # Creates the symlinks to 'bin' scripts in /usr/local/bin
    # Creates the symlink to the installation path in /usr/local/opt
    prefix.install Dir["bin", "lib"]
  end

  # opt_prefix is set to the symlink /usr/local/opt/benerator
  def caveats; <<~EOS
    To use the benerator commands, please set the following environment variables:
        BENERATOR_HOME=#{opt_prefix}
        JAVA_HOME=

    Use one of the following commands to find the value for JAVA_HOME:
    $(dirname $(readlink $(which javac)))/java_home

    or (more platform independent)

    java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'

  EOS
  end

  
  test do
    #assert_match "Benerator 21.0.0-jdk-11", shell_output("#{bin}/benerator --version", 2)
  end
end

