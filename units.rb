require 'formula'

class Units < Formula
  homepage 'http://www.gnu.org/software/units/'
  url 'http://ftp.gnu.org/gnu/units/units-2.01.tar.gz'
  version '2.01'
  sha1 '80e7f1a2e70769bfac93702924871843b85f12d4'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make check"

    ENV.deparallelize # units install otherwise races to make some directories
    system "make install"
  end

  def test
    system %{[ $(units '(((square(kiloinch)+2.84m2) /0.5) meters^2)^(1|4)' m | sed -n -e 's/[[:space:]]\\\* //p') = 6 ]}
  end
end
