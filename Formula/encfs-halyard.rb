class EncfsHalyard < Formula
  desc "Encrypted pass-through FUSE file system"
  homepage "https://vgough.github.io/encfs/"
  url "https://github.com/vgough/encfs/archive/v1.9.2.tar.gz"
  sha256 "cd9e972cd9565cdc26473c86d2c77c98de31fc6f604fa7d149dd5d6e35d46eaa"
  head "https://github.com/vgough/encfs.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gettext"
  depends_on "openssl"
  depends_on :osxfuse

  needs :cxx11

  def install
    ENV.cxx11

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCMAKE_INCLUDE_PATH=/usr/local/include", "-DCMAKE_LIBRARY_PATH=/usr/local/lib"
      system "make", "install"
    end
  end

  test do
    # Functional test violates sandboxing, so punt.
    # Issue #50602; upstream issue vgough/encfs#151
    assert_match version.to_s, shell_output("#{bin}/encfs 2>&1", 1)
  end
end
