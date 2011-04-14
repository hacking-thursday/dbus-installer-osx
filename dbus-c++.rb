require 'formula'

class DbusCxx <Formula
  head 'git://gitorious.org/dbus-cplusplus/mainline.git'
  homepage 'http://git-wt-commit.rubyforge.org/'
  # Don't clean the empty directories that D-Bus needs
  skip_clean "etc/dbus-1/session.d"
  skip_clean "etc/dbus-1/system.d"
  skip_clean "var/run/dbus"

  depends_on 'd-bus'
 # depends_on 'libpthread'
  def install
    # Fix the TMPDIR to one D-Bus doesn't reject due to odd symbols
    ENV["TMPDIR"] = "/tmp"
    system "sed -i -e '28,33 d' bootstrap"
    system "autoreconf -sif"
    system "./configure", "--prefix=#{prefix}", "--disable-doxygen-docs"
    system "make install"

    # Generate D-Bus's UUID for this machine
    #system "#{bin}/dbus-uuidgen", "--ensure=#{prefix}/var/lib/dbus/machine-id"
  end
end
  
