module PDFBox
  class CLI

    DEFAULT_OPTIONS = {
      ignoreBeads: true,
      alwaysNext:  true,
      sort:        true
    }

    def run_command(*args)
      options = DEFAULT_OPTIONS.merge(args.pop)
      command = args.shift
      command_with_options = [command].concat options_to_args(options)
      args = command_with_options.concat args
      pdfbox_vendor_dir = File.expand_path('../../vendor/pdfbox',__dir__)
      args = ["-jar", "#{pdfbox_vendor_dir}/pdfbox-app-2.0.13.jar"].concat( args )
      output, status = Open3.capture2e(cmd, *args)
      raise "Command `#{cmd} #{args.join(" ")}` failed: #{output}" if status.exitstatus != 0
      output
    end

    private

    def cmd
      @cmd ||= "java"
    end

    def options_to_args(options)
      args = []
      options.each do |key, value|
        next if value === false
        args.push "-#{key}"
        args.push value.to_s unless value === true
      end
      args
    end
  end
end
