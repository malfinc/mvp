namespace :docs do
  namespace :diagrams do
    task :generate do
      if system("which plantuml")
        system("plantuml -progress -nbthread auto #{Dir[File.join("docs", "diagrams", "*.puml")].join(" ")}")
      else
        puts("You need to install plantuml: brew install plantuml")
      end
    end
  end
end
