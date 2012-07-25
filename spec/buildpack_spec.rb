require './lib/mason/buildpack'

describe Mason::Buildpack do
  let(:tempdir) { Dir.tmpdir }

  subject { Mason::Buildpack.new("/tmp") }

  before do
    FileUtils.mkdir_p tempdir
  end

  after do
    FileUtils.rm_rf tempdir
  end

  describe "#write_procfile" do
    it "uses Foreman to create the Procfile" do
      File.open("#{tempdir}/Procfile", "w+") { |f| f.puts "web: ls -la" }
      subject.send :write_procfile, tempdir, {}
      File.read("#{tempdir}/Procfile").should =~ /web: ls -la/
    end
  end
end
