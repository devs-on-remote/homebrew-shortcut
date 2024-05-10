class Shortcut < Formula
  desc 'A CLI tool enhancing your terminal usage by allowing you to save your most used commands/scripts and then executing them in no time.  '
  homepage 'https://github.com/devs-on-remote/shortcut'
  url 'https://github.com/devs-on-remote/shortcut/archive/1.0.1.tar.gz'
  sha256 '6f3df98cc4360a5f5226e436c2d2ac9ae787e6b93a4ffbd76f2c8db56c3641f8'

  depends_on 'ruby'

  def install
    ENV['GEM_HOME'] = libexec
    ENV['GEM_PATH'] = "#{libexec}:#{Gem.dir}"

    system 'gem', 'install', 'bundler', '--no-document'
    system 'bundle', 'config', 'set', '--local', 'path', 'vendor/bundle'
    system 'bundle', 'install'

    # Explicitly install required gems
    system 'gem', 'install', 'rainbow'
    system 'gem', 'install', 'thor'

    system 'gem', 'build', 'shortcut.gemspec'
    system 'gem', 'install', '--ignore-dependencies', "shortcut-#{version}.gem"

    bin.install libexec / 'bin' / 'shortcut'
    bin.env_script_all_files(libexec / 'bin', GEM_HOME: ENV['GEM_HOME'], GEM_PATH: ENV['GEM_PATH'])

    bin.install_symlink bin / 'shortcut' => 'sc'
  end

  test do
    system 'shortcut', '--version'
    system 'sc', '--version'
  end
end
